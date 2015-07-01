-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: PolyIntrpFilter
--  \   \        Version: 1.0
--  /   /        Filename: FilterStage.vhd
-- /___/   /\    Date Last Modified:  Aug 18, 2005
-- \   \  /  \   Date Created: Aug 2, 2005
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-4 (4vsx35-FF668-10) 
--Library: IEEE 
--Purpose: Polyphase Interpolation Filter Example
--         Sub-level design file
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify 8.1, Xilinx ISE 7.1i, MTI ModelSim-SE 6.0
--Revision History: 
--    Rev 1.0 - First release, brianp, Aug 18, 2005 
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
    ain    : in  signed(CoefWidth-1 downto 0);
    bin    : in  signed(DataWidth-1 downto 0);
    cin    : in  signed(47 downto 0);
    clk    : in  std_logic;
    ce   : in  std_logic;
    reset  : in  std_logic;
    dout   : out signed(47 downto 0)
    );
end FilterStage;

architecture behavioral of FilterStage is

  attribute syn_useioff               : boolean;
  attribute syn_useioff of behavioral : architecture is false;

  signal mult_r : signed(DataWidth+CoefWidth-1 downto 0);
  signal sum_r  : signed(47 downto 0);

begin
  dout <= sum_r;

  multadd : process (clk)
  begin
    if rising_edge(clk) then
      if (reset = '1') then
        mult_r <= (others => '0');
        sum_r  <= (others => '0');
      elsif (ce = '1') then
        mult_r <= ain * bin;            -- registered multiply
        sum_r  <= mult_r + cin;         -- registered sum
      end if;
    end if;
  end process multadd;


end behavioral;
