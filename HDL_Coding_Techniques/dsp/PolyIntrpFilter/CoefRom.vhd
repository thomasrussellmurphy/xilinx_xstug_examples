-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: PolyIntrpFilter
--  \   \        Version: 1.0
--  /   /        Filename: CoefRom.vhd
-- /___/   /\    Date Last Modified:  Aug 18, 2005
-- \   \  /  \   Date Created: Aug 2, 2005
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-4 (4vsx35-FF668-10) 
--Library: IEEE 
--Purpose: Polyphase Interpolation Filter Example
--         Sub-level design file.  References PolyIntrpFilterPkg package file.
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify 8.1, Xilinx ISE 7.1i, MTI ModelSim-SE 6.0
--Revision History: 
--    Rev 1.0 - First release, brianp, Aug 18, 2005 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PolyIntrpFilterPkg.all;

entity CoefRom is
  generic (
    AddrWidth   : natural := 4;
    CoefWidth   : natural := 16;
    IntrpFactor : natural := 16;
    Stage       : natural := 0
    );
  
  port(
    addr : in  unsigned(AddrWidth-1 downto 0);
    clk  : in  std_logic;
    ce   : in  std_logic;
    dout : out signed(CoefWidth-1 downto 0)
    );
end CoefRom;

architecture behavioral of CoefRom is

  attribute syn_useioff               : boolean;
  attribute syn_useioff of behavioral : architecture is false;

  type RomType is array (0 to IntrpFactor-1) of integer;

  -- Synplify likes this one.
  -- constant LocalRom : RomType := Coefficients(Stage*IntrpFactor to (Stage+1)*IntrpFactor-1);

  -- ModelSim likes this one.
  constant LocalRom : RomType := RomType(Coefficients(Stage*IntrpFactor to (Stage+1)*IntrpFactor-1));

begin
  
  process (clk)
  begin
    if rising_edge (clk) then
      if (ce = '1') then
        dout <= to_signed(LocalRom(to_integer(addr)), CoefWidth);
      end if;
    end if;
  end process;

end behavioral;
