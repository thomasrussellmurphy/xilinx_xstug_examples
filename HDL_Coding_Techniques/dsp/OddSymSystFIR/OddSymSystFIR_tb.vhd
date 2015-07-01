-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: OddSymSystFIR
--  \   \        Version: 1.0
--  /   /        Filename: OddSymSystFIR_tb.vhd
-- /___/   /\    Date Last Modified:  May 29, 2009
-- \   \  /  \   Date Created: July 14, 2005
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-6 
--Library: IEEE 
--Purpose: Symmetric Systolic FIR Filter with an Odd Number of Stages
--         Testbench file
--Reference: http://www.xilinx.com
--Tools: Xilinx ISE 11.2, MTI ModelSim-SE 6.3b
--Revision History: 
--    Rev 1.0 - First release
--    Rev 1.1 - Added header, wendling, May 29, 2009 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.TestPkg.all;

entity OddSymSystFIR_tb is
end OddSymSystFIR_tb;


architecture testbench of OddSymSystFIR_tb is

  component OddSymSystFIR
    generic (
      DataWidth   : natural;
      CoefWidth   : natural;
      NumStages   : natural
      );
    port (
      datain   : in  signed(DataWidth-1 downto 0);
      clk   : in  std_logic;
      ce    : in  std_logic;
      reset : in  std_logic;
      dout  : out signed(47 downto 0)
      );
  end component;

  constant DataWidth   : natural := 16;
  constant CoefWidth   : natural := 16;
  constant NumStages   : natural := 17;

  signal datain    : signed(DataWidth-1 downto 0);
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

  dut: OddSymSystFIR
    generic map (
      DataWidth => DataWidth,
      CoefWidth => CoefWidth,
      NumStages => NumStages
      )
    port map (
        datain   => datain,
        clk   => clk,
        ce    => '1',
        reset => reset,
        dout  => dout
        );
  
  stimulus : process (clk)
    
    variable count              : integer := 0;
    
  begin
    if (clk'event and clk = '1') then
      if (reset = '1') then
        datain <= (others => '0');
        count := 0;
      else
        count := (count + 1);
        datain <= to_signed(TestData(count), DataWidth) after Tcko;
      end if;
    end if;
  end process stimulus;

  
end testbench;
