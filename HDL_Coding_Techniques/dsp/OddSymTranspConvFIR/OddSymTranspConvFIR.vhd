-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: OddSymTranspConvFIR
--  \   \        Version: 1.0
--  /   /        Filename: OddSymTranspConvFIR.vhd
-- /___/   /\    Date Last Modified:  Apr 10, 2009
-- \   \  /  \   Date Created: February 2, 2009
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-6 () 
--Library: IEEE 
--Purpose: Symmetric Transpose Convolution Filter
--         with an Odd Number of Taps Example
--         Top-level design file
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify C-2009.06, Xilinx ISE 11.2, MTI ModelSim-SE 6.3b
--Revision History: 
--    Rev 1.0 - First release, wendling, Apr 10, 2009 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity OddSymTranspConvFIR is
  generic (
    DataWidth   : natural := 16;
    CoefWidth   : natural := 16;
    NumStages   : natural := 7		-- must be odd
    );
  port(
    datain : in  signed(DataWidth-1 downto 0);
    clk    : in  std_logic;
    ce     : in  std_logic;
    reset  : in  std_logic;
    dout   : out signed(47 downto 0)
    );
end OddSymTranspConvFIR;

architecture behavioral of OddSymTranspConvFIR is

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

  type CoefArray is array (0 to (NumStages+1)/2-1) of integer;
  constant Coeffs : CoefArray := (
  	(761/2),	-- Stages: 3 (central stage)
	                -- Coefficient is divided by two and the related
			-- DSP stage is configured with a pre-adder that
			-- receives this divided coefficient on both the A
			-- and D inputs
	6,		-- Stages: 2 and 4
	-1676,		-- Stages: 1 and 5
	27303		-- Stages: 0 and 6
	);

  type bin_array is array (0 to (NumStages+1)/2-1) of signed(CoefWidth-1 downto 0);
  signal bin_bus : bin_array;
  
  type acout_array is array (0 to (NumStages+1)/2) of signed(DataWidth-1 downto 0);
  signal acout_bus : acout_array;

  type dout_array is array (0 to (NumStages+1)/2) of signed(47 downto 0);
  signal dout_bus : dout_array;

  constant gnd48   : signed(47 downto 0) := (others => '0');

begin

  dout_bus(0) <= gnd48;
  acout_bus(0) <= datain;
  bin_bus(0) <= to_signed(Coeffs(0),CoefWidth);
  
  dout <= dout_bus((NumStages+1)/2);

  -- Central tap
  
  U0: DelayLine
    generic map (
      Depth => 1,
      Width => DataWidth
    )
    port map (
      din  => acout_bus(0),
      clk  => clk,
      ce   => ce,
      dout => acout_bus(1)
    );

  U1 : FilterStage
    generic map (
      DataWidth => DataWidth,
      CoefWidth => CoefWidth
      )
    port map (
  	ain   => acout_bus(1),
  	bin   => bin_bus(0),
        din   => datain,
  	cin   => dout_bus(0),
  	clk   => clk,
  	ce    => ce,
  	reset => reset,
  	dout  => dout_bus(1)
  	);

  -- Symmetric taps
  
  L0 : for i in 1 to (NumStages+1)/2-1 generate
  begin
  
    bin_bus(i) <= to_signed(Coeffs(i),CoefWidth);

    U2: DelayLine
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

    U3 : FilterStage
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
