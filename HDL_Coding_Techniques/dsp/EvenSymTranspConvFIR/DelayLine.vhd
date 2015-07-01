-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: EvenSymTranspConvFIR
--  \   \        Version: 1.0
--  /   /        Filename: DelayLine.vhd
-- /___/   /\    Date Last Modified:  Apr 10, 2009
-- \   \  /  \   Date Created: February 2, 2009
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-6 () 
--Library: IEEE 
--Purpose: Symmetric Transpose Convolution Filter
--         with an Even Number of Taps Example
--         Sub-level design file
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify C-2009.06, Xilinx ISE 11.2, MTI ModelSim-SE 6.3b
--Revision History: 
--    Rev 1.0 - First release, wendling, Apr 10, 2009 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DelayLine is
  generic (
    Depth : natural := 2;
    Width : natural := 16
    );
  
  port(
    din  : in  signed(Width-1 downto 0);
    clk  : in  std_logic;
    ce   : in  std_logic;
    dout : out signed(Width-1 downto 0)
    );
end DelayLine;

architecture behavioral of DelayLine is

  attribute syn_useioff               : boolean;
  attribute syn_useioff of behavioral : architecture is false;

  type DelayType is array (0 to Depth-1) of signed(Width-1 downto 0);
  signal DataBuffer : DelayType;

begin
  dout <= DataBuffer(Depth-1);
  
  process (clk)
  begin
    if rising_edge (clk) then
      if (ce = '1') then
        DataBuffer(0) <= din;
        DataBuffer(1 to Depth-1) <= DataBuffer(0 to Depth-2);
      end if;
    end if;
  end process;

end behavioral;
