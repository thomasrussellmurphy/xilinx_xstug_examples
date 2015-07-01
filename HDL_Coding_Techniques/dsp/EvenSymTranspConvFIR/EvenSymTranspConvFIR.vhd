-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: EvenSymTranspConvFIR
--  \   \        Version: 1.0
--  /   /        Filename: EvenSymTranspConvFIR.vhd
-- /___/   /\    Date Last Modified:  Apr 10, 2009
-- \   \  /  \   Date Created: February 2, 2009
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-6 () 
--Library: IEEE 
--Purpose: Symmetric Transpose Convolution Filter
--         with an Even Number of Taps Example
--         Top-level design file
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify C-2009.06, Xilinx ISE 11.2, MTI ModelSim-SE 6.3b
--Revision History: 
--    Rev 1.0 - First release, wendling, Apr 10, 2009 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EvenSymTranspConvFIR is
  generic (
    DataWidth   : natural := 16;
    CoefWidth   : natural := 16;
    NumStages   : natural := 8		-- must be even
    );
  port(
    datain : in  signed(DataWidth-1 downto 0);
    clk    : in  std_logic;
    ce     : in  std_logic;
    reset  : in  std_logic;
    dout   : out signed(47 downto 0)
    );
end EvenSymTranspConvFIR;

architecture behavioral of EvenSymTranspConvFIR is

  component DelayLine
    generic (
      Depth : natural;
      Width : natural
      );
    port (
      din  : in  signed(Width-1 downto 0);
      clk  : in  std_logic;
      ce   : in  std_logic;
      dout : out signed(Width-1 downto 0)
      );
  end component;

  component FilterStage
    generic (
      DataWidth : natural;
      CoefWidth : natural
      );
    port (
      ain   : in  signed(DataWidth-1 downto 0);
      bin   : in  signed(CoefWidth-1 downto 0);
      din   : in  signed(DataWidth-1 downto 0);
      cin   : in  signed(47 downto 0);
      clk   : in  std_logic;
      ce    : in  std_logic;
      reset : in  std_logic;
      dout  : out signed(47 downto 0)
      );
  end component;

  attribute syn_useioff               : boolean;
  attribute syn_useioff of behavioral : architecture is false;

  type CoefArray is array (0 to NumStages/2-1) of integer;
  constant Coeffs : CoefArray := (
  	761,		-- Stages: 3 and 4
	6,		-- Stages: 2 and 5
	-5388,		-- Stages: 1 and 6
	27303		-- Stages: 0 and 7
	);

  type bin_array is array (0 to NumStages/2-1) of signed(CoefWidth-1 downto 0);
  signal bin_bus : bin_array;
  
  type acout_array is array (0 to NumStages/2) of signed(DataWidth-1 downto 0);
  signal acout_bus : acout_array;

  type dout_array is array (0 to NumStages/2) of signed(47 downto 0);
  signal dout_bus : dout_array;

  signal gnd48   : signed(47 downto 0) := (others => '0');

begin

  dout_bus(0) <= gnd48;
  acout_bus(0) <= datain;
  
  dout <= dout_bus(NumStages/2);

  L0 : for i in 0 to NumStages/2-1 generate
  begin
  
    bin_bus(i) <= to_signed(Coeffs(i),CoefWidth);

    U1: DelayLine
      generic map (
        Depth => 2,
	Width => DataWidth
      )
      port map (
        din  => acout_bus(i),
	clk  => clk,
	ce   => ce,
	dout => acout_bus(i+1)
      );

    U2 : FilterStage
      generic map (
        DataWidth => DataWidth,
        CoefWidth => CoefWidth
        )
      port map (
          ain   => acout_bus(i+1),
          bin   => bin_bus(i),
	  din   => datain,
          cin   => dout_bus(i),
          clk   => clk,
          ce    => ce,
          reset => reset,
          dout  => dout_bus(i+1)
          );
  end generate L0;  

end behavioral;
