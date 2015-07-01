-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: PolyDecFilter
--  \   \        Version: 1.0
--  /   /        Filename: SyncDelay.vhd
-- /___/   /\    Date Last Modified:  Aug 18, 2005
-- \   \  /  \   Date Created: July 14, 2005
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-4 (4vsx35-FF668-10) 
--Library: IEEE 
--Purpose: Polyphase Decimating Filter Example
--         Sub-level design file
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify 8.1, Xilinx ISE 7.1i, MTI ModelSim-SE 6.0
--Revision History: 
--    Rev 1.0 - First release, brianp, Aug 18, 2005 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SyncDelay is
  generic (
    Depth : natural := 16
    );
  
  port(
    din  : in  std_logic;
    clk  : in  std_logic;
    ce   : in  std_logic;
    dout : out std_logic
    );
end SyncDelay;

architecture behavioral of SyncDelay is

  attribute syn_useioff               : boolean;
  attribute syn_useioff of behavioral : architecture is false;

  type DelayType is array (0 to Depth-1) of std_logic;
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
