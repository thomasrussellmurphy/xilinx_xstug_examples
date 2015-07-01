-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: EvenSymSystFIR
--  \   \        Version: 1.0
--  /   /        Filename: FilterStage.vhd
-- /___/   /\    Date Last Modified:  May 29, 2009
-- \   \  /  \   Date Created: July 14, 2005
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-6 
--Library: IEEE 
--Purpose: Symmetric Systolic FIR Filter with an Even Number of Stages
--         Sub-level design file
--Reference: http://www.xilinx.com
--Tools: Xilinx ISE 11.2, MTI ModelSim-SE 6.3b
--Revision History: 
--    Rev 1.0 - First release
--    Rev 1.1 - Added header, wendling, May 29, 2009 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FilterStage is
  generic (
    DataWidth : natural := 18;
    CoefWidth : natural := 18
    );
  
  port(
    ain    : in  signed(DataWidth-1 downto 0);
    bin    : in  signed(CoefWidth-1 downto 0);
    din    : in  signed(DataWidth-1 downto 0);
    cin    : in  signed(47 downto 0);
    clk    : in  std_logic;
    ce     : in  std_logic;
    reset  : in  std_logic;
    dout   : out signed(47 downto 0)
    );
end FilterStage;

architecture behavioral of FilterStage is

  attribute syn_useioff               : boolean;
  attribute syn_useioff of behavioral : architecture is false;

  signal din_r    : signed(DataWidth-1 downto 0);
  signal preadd_r : signed(DataWidth downto 0);
  signal mult_r   : signed(DataWidth+CoefWidth downto 0);
  signal sum_r    : signed(47 downto 0);

begin
  dout <= sum_r;

  addmultadd : process (clk)
  begin
    if rising_edge(clk) then
      if (reset = '1') then
        din_r    <= (others => '0');
        preadd_r <= (others => '0');
        mult_r   <= (others => '0');
        sum_r    <= (others => '0');
      elsif (ce = '1') then
	din_r    <= din;            -- registered din
        preadd_r <= resize(ain,DataWidth+1) + resize(din_r,DataWidth+1); -- registered preadder
        mult_r <= preadd_r * bin;   -- registered multiply
        sum_r  <= mult_r + cin;     -- registered sum
      end if;
    end if;
  end process addmultadd;


end behavioral;
