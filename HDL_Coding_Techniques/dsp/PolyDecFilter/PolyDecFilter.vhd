-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: PolyDecFilter
--  \   \        Version: 1.0
--  /   /        Filename: PolyDecFilter.vhd
-- /___/   /\    Date Last Modified:  Aug 18, 2005
-- \   \  /  \   Date Created: July 14, 2005
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-4 (4vsx35-FF668-10) 
--Library: IEEE 
--Purpose: Polyphase Decimating Filter Example
--         Top-level design file
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify 8.1, Xilinx ISE 7.1i, MTI ModelSim-SE 6.0
--Revision History: 
--    Rev 1.0 - First release, brianp, Aug 18, 2005 
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PolyDecFilter is
  generic (
    DataWidth : natural := 16;
    CoefWidth : natural := 16;
    DecFactor : natural := 16;
    AddrWidth : natural := 4;           -- ceil(log2(DecFactor))
    NumStages : natural := 8
    );
  port(
    din    : in  signed(DataWidth-1 downto 0);
    clk    : in  std_logic;
    ce     : in  std_logic;
    reset  : in  std_logic;
    dout   : out signed(47 downto 0)
    );
end PolyDecFilter;

architecture behavioral of PolyDecFilter is

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

  component CoefRom
    generic (
      AddrWidth : natural;
      CoefWidth : natural;
      DecFactor : natural;
      Stage     : natural
      );
    port (
      addr : in  unsigned(AddrWidth-1 downto 0);
      clk  : in  std_logic;
      ce   : in  std_logic;
      dout : out signed(CoefWidth-1 downto 0)
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
      cin   : in  signed(47 downto 0);
      clk   : in  std_logic;
      ce    : in  std_logic;
      reset : in  std_logic;
      dout  : out signed(47 downto 0)
      );
  end component;

  component AddrGen
    generic (
      AddrWidth : natural
      );
    port (
      clk   : in  std_logic;
      ce    : in  std_logic;
      reset : in  std_logic;
      addr  : out unsigned(AddrWidth-1 downto 0);
      sync  : out std_logic
      );
  end component;

  component Accum
    port (
      din   : in  signed(47 downto 0);
      clk   : in  std_logic;
      ce    : in  std_logic;
      reset : in  std_logic;
      sync  : in  std_logic;
      dout  : out signed(47 downto 0)
      );
  end component;

  component DataDelay
    generic (
      Width : natural
      );
    port (
      din   : in  signed(Width-1 downto 0);
      clk   : in  std_logic;
      ce    : in  std_logic;
      reset : in  std_logic;
      dout  : out signed(Width-1 downto 0)
      );
  end component;

  component AddrDelay
    generic (
      Width : natural
      );
    port (
      din   : in  unsigned(AddrWidth-1 downto 0);
      clk   : in  std_logic;
      ce    : in  std_logic;
      reset : in  std_logic;
      dout  : out unsigned(AddrWidth-1 downto 0)
      );
  end component;

  component SyncDelay
    generic (
      Depth : natural
      );
    port (
      din  : in  std_logic;
      clk  : in  std_logic;
      ce   : in  std_logic;
      dout : out std_logic
      );
  end component;

  attribute syn_useioff               : boolean;
  attribute syn_useioff of behavioral : architecture is false;

  type din_array is array (0 to NumStages) of signed(DataWidth-1 downto 0);
  signal din_bus : din_array;
  signal din_r   : signed(DataWidth-1 downto 0);
  
  type bin_array is array (0 to NumStages-1) of signed(CoefWidth-1 downto 0);
  signal bin_bus : bin_array;
  
  type dout_array is array (0 to NumStages) of signed(47 downto 0);
  signal dout_bus : dout_array;

  type addr_array is array (0 to NumStages) of unsigned(AddrWidth-1 downto 0);
  signal addr_bus : addr_array;
  signal addr : unsigned(AddrWidth-1 downto 0) := (others => '0');

  signal gnd48   : signed(47 downto 0) := (others => '0');

  signal sync         : std_logic;
  signal sync_delayed : std_logic;
  signal vcc          : std_logic := '1';

begin

  dout_bus(0) <= gnd48;
  din_bus(0)  <= din_r;
  addr_bus(0) <= addr;

  U0 : DataDelay
    generic map (
      Width => DataWidth
      )
    port map (
      din   => din,
      clk   => clk,
      ce    => ce,
      reset => reset,
      dout  => din_r
      );

  L0 : for i in 0 to NumStages-1 generate
  begin

    U0 : DelayLine
      generic map (
        Depth => DecFactor+1,
        Width => DataWidth
        )
      port map (
          din  => din_bus(i),
          clk  => clk,
          ce   => ce,
          dout => din_bus(i+1)
          );

    U1 : CoefRom
      generic map (
        AddrWidth => AddrWidth,
        CoefWidth => CoefWidth,
        DecFactor => DecFactor,
        Stage     => i
        )
      port map (
          addr => addr_bus(i),
          clk  => clk,
          ce   => ce,
          dout => bin_bus(i)
          );
    
    U2 : FilterStage
      generic map (
        DataWidth => DataWidth,
        CoefWidth => CoefWidth
        )
      port map (
          ain   => din_bus(i),
          bin   => bin_bus(i),
          cin   => dout_bus(i),
          clk   => clk,
          ce    => ce,
          reset => reset,
          dout  => dout_bus(i+1)
          );

    U3 : AddrDelay
      generic map (
          Width => AddrWidth
          )
      port map (
          din   => addr_bus(i),
          clk   => clk,
          ce    => ce,
          reset => reset,
          dout  => addr_bus(i+1)
          );
    
  end generate L0;  

  U4 : Accum
    port map (
        din   => dout_bus(NumStages),
        clk   => clk,
        ce    => ce,
        reset => reset,
        sync  => sync_delayed,
        dout  => dout
        );

  U5 : AddrGen
    generic map (
      AddrWidth => AddrWidth
      )
    port map (
      clk   => clk,
      ce    => ce,
      reset => reset,
      addr  => addr,
      sync  => sync
      );
  
  U6 : SyncDelay
    generic map (
        Depth => NumStages+3
        )
    port map (
        din  => sync,
        clk  => clk,
        ce   => ce,
        dout => sync_delayed
        );

end behavioral;
