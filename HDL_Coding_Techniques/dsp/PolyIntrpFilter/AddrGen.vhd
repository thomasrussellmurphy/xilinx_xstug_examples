-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: PolyIntrpFilter
--  \   \        Version: 1.0
--  /   /        Filename: AddrGen.vhd
-- /___/   /\    Date Last Modified:  Aug 18, 2005
-- \   \  /  \   Date Created: July 27, 2005
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

entity AddrGen is
  generic (
    AddrWidth : natural := 4;
    IntrpFactor : natural := 16
    );
  
  port(
    clk    : in  std_logic;
    ce     : in  std_logic;
    reset  : in  std_logic;
    addr   : out unsigned(AddrWidth-1 downto 0);
    sync   : out std_logic
    );
end AddrGen;

architecture behavioral of AddrGen is

  attribute syn_useioff               : boolean;
  attribute syn_useioff of behavioral : architecture is false;

  constant InitAddr : unsigned := to_unsigned(0, AddrWidth);
  
  signal addr_i : unsigned(AddrWidth-1 downto 0);
  
begin
  addr <= addr_i;
  
  addrgen : process (clk)
  begin
    if rising_edge(clk) then
      if (reset = '1') then
        addr_i <= InitAddr;
        sync   <= '0';
      elsif (ce = '1') then
        if (addr_i = IntrpFactor - 1) then
          addr_i <= InitAddr;
          sync <= '1';
        else
          addr_i <= addr_i + 1;
          sync <= '0';
        end if;
      end if;
    end if;
  end process addrgen;

end behavioral;
