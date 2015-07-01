-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: PolyIntrpFilter
--  \   \        Version: 1.0
--  /   /        Filename: PolyIntrpFilter_tb.vhd
-- /___/   /\    Date Last Modified:  Aug 18, 2005
-- \   \  /  \   Date Created: Aug 2, 2005
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-4 (4vsx35-FF668-10) 
--Library: IEEE 
--Purpose: Polyphase Interpolation Filter Example
--         Testbench file
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify 8.1, Xilinx ISE 7.1i, MTI ModelSim-SE 6.0
--Revision History: 
--    Rev 1.0 - First release, brianp, Aug 18, 2005 
--    Rev 2.0 - Modified for rev 2.0 of PolyIntrpFilter.vhd, Sean Caffee, 28 AUG 09 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PolyIntrpFilterPkg.all;
use work.TestPkg.all;

entity PolyIntrpFilter_tb is
end PolyIntrpFilter_tb;


architecture testbench of PolyIntrpFilter_tb is

  component PolyIntrpFilter
    generic (
      DataWidth   : natural;
      CoefWidth   : natural;
      IntrpFactor : natural;
      AddrWidth   : natural;
      NumStages   : natural
      );
    port (
      din   : in  signed(DataWidth-1 downto 0);
      clk   : in  std_logic;
      ce    : in  std_logic;
      reset : in  std_logic;
      dout  : out signed(47 downto 0);
      sync_out	: out std_logic;
      valid_out	: out std_logic	
      );
  end component;

  constant DataWidth   : natural := 16;
  constant CoefWidth   : natural := 16;
  constant IntrpFactor : natural := 8;
  constant AddrWidth   : natural := 3;
  constant NumStages   : natural := 16;

  signal din       : signed(datawidth-1 downto 0);
  signal clk       : std_logic := '1';
  signal ce        : std_logic := '0';
  signal reset     : std_logic := '1';
  signal dout      : signed(47 downto 0);

  constant Tck  : time := 10 ns;        -- clock period
  constant Tpw  : time := Tck/2;        -- clock pulse width
  constant Tcko : time := 100 ps;       -- clock to out

begin
  
  clk <= not clk after Tpw;
  
  reset <= '0' after (10*Tck + Tcko);

  dut: PolyIntrpFilter
    generic map (
      DataWidth => DataWidth,
      CoefWidth => CoefWidth,
      IntrpFactor => IntrpFactor,
      AddrWidth => AddrWidth,
      NumStages => NumStages
      )
    port map (
        din   => din,
        clk   => clk,
        ce    => '1',
        reset => reset,
        dout  => dout,
        sync_out => open,
        valid_out => open
        );
  
  stimulus : process (clk)
    
    variable count              : integer := 0;
    variable NumClocksPerEnable : integer := IntrpFactor;
    
  begin
    if (clk'event and clk = '1') then
      if (reset = '1') then
        din <= (others => '0');
        count := 0;
      else
        count := (count + 1) mod (1024 * NumClocksPerEnable);
        if (count mod NumClocksPerEnable) = 0 then
          din <= to_signed(TestData(count/NumClocksPerEnable), DataWidth) after Tcko;
          ce <= '1' after Tcko;
         else
           ce <= '0' after Tcko;
         end if;
      end if;
    end if;
  end process stimulus;

  
end testbench;
