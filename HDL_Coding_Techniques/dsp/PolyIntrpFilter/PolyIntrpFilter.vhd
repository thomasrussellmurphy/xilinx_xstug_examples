-------------------------------------------------------------------------------- 
-- Copyright (c) 1996-2009 Xilinx, Inc. 
-- All Rights Reserved 
-------------------------------------------------------------------------------- 
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /   Company: Xilinx 
-- \   \   \/    Design: PolyIntrpFilter
--  \   \        Version: 1.0
--  /   /        Filename: PolyIntrpFilter.vhd
-- /___/   /\    Date Last Modified:  Aug 18, 2005
-- \   \  /  \   Date Created: Aug 2, 2005
--  \___\/\___\ 
-- 
--Device: Xilinx Virtex-4 (4vsx35-FF668-10) 
--Library: IEEE 
--Purpose: Polyphase Interpolation Filter Example
--         Top-level design file
--Reference: http://www.xilinx.com
--Tools: Synplicity Synplify 8.1, Xilinx ISE 7.1i, MTI ModelSim-SE 6.0
--Revision History: 
--    Rev 1.0 - First release, brianp, Aug 18, 2005 
--    Rev 2.0 - Fixed clock enabling and added handshaking outputs. Sean Caffee, 28 AUG 09
-------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PolyIntrpFilter is
  generic (
    DataWidth   : natural := 16;
    CoefWidth   : natural := 16;
    IntrpFactor : natural := 8;
    AddrWidth   : natural := 3;           -- ceil(log2(IntrpFactor))
    NumStages   : natural := 16
    );
  port(
    din    	: in  signed(DataWidth-1 downto 0);
    clk    	: in  std_logic;
    ce     	: in  std_logic;
    reset  	: in  std_logic;
    dout   	: out signed(47 downto 0);
    sync_out	: out std_logic;		-- used for enabling the input source to the filter
    valid_out	: out std_logic			-- used for capturing valid output data
    );
end PolyIntrpFilter;

architecture behavioral of PolyIntrpFilter is

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
      AddrWidth   : natural;
      CoefWidth   : natural;
      IntrpFactor : natural;
      Stage       : natural
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
      ain   : in  signed(CoefWidth-1 downto 0);
      bin   : in  signed(DataWidth-1 downto 0);
      cin   : in  signed(47 downto 0);
      clk   : in  std_logic;
      ce  : in  std_logic;
      reset : in  std_logic;
      dout  : out signed(47 downto 0)
      );
  end component;

  component AddrGen
    generic (
      AddrWidth : natural;
      IntrpFactor : natural
      );
    port (
      clk   : in  std_logic;
      ce    : in  std_logic;
      reset : in  std_logic;
      addr  : out unsigned(AddrWidth-1 downto 0);
      sync  : out std_logic
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
  
  type ain_array is array (0 to NumStages-1) of signed(CoefWidth-1 downto 0);
  signal ain_bus : ain_array;
  
  type dout_array is array (0 to NumStages) of signed(47 downto 0);
  signal dout_bus : dout_array;

  type addr_array is array (0 to NumStages) of unsigned(AddrWidth-1 downto 0);
  signal addr_bus : addr_array;
  signal addr : unsigned(AddrWidth-1 downto 0) := (others => '0');

  type sync_array is array (0 to NumStages) of std_logic;
  signal sync_bus 	: sync_array;
  signal gated_sync_bus : sync_array;

  signal gnd48   : signed(47 downto 0) := (others => '0');

  signal sync         : std_logic;
  signal vcc          : std_logic := '1';

begin

  dout_bus(0) <= gnd48;
  din_bus(0)  <= din_r;
  addr_bus(0) <= addr;
  sync_bus(0) <= sync;
  
  dout <= dout_bus(NumStages);
  
  gated_sync_proc : process(ce, sync_bus)
    begin
        for i in 0 to NumStages loop
            gated_sync_bus(i) <= sync_bus(i) AND ce;
        end loop;
    end process;


  U0 : DataDelay
    generic map (
      Width => DataWidth
      )
    port map (
      din   => din,
      clk   => clk,
      ce    => gated_sync_bus(0),
      reset => reset,
      dout  => din_r
      );

  L0 : for i in 0 to NumStages-1 generate
  begin

    U0 : DelayLine
      generic map (
        Depth => 2,
        Width => DataWidth
        )
      port map (
        din  => din_bus(i),
        clk  => clk,
        ce   => gated_sync_bus(i+1),
        dout => din_bus(i+1)
        );


    U1 : CoefRom
      generic map (
        AddrWidth => AddrWidth,
        CoefWidth => CoefWidth,
        IntrpFactor => IntrpFactor,
        Stage     => i
        )
      port map (
          addr => addr_bus(i),
          clk  => clk,
          ce   => ce,
          dout => ain_bus(i)
          );
    
    U2 : FilterStage
      generic map (
        DataWidth => DataWidth,
        CoefWidth => CoefWidth
        )
      port map (
          ain   => ain_bus(i),
          bin   => din_bus(i),
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
                                
    U4 : SyncDelay
      port map (
          din  => sync_bus(i),
          clk  => clk,
          ce   => ce,
          dout => sync_bus(i+1)
          );
    
  end generate L0;  


  U5 : AddrGen
    generic map (
      AddrWidth => AddrWidth,
      IntrpFactor => IntrpFactor
      )
    port map (
      clk   => clk,
      ce    => ce,
      reset => reset,
      addr  => addr,
      sync  => sync
      ); 

-- Pipeline 'sync_out' for high performance, but enable with 'ce' and AND output with 'ce'
sync_out <= sync AND ce;

-- Pipeline 'valid_out' for high performance, no 'ce' needed
valid_out <= ce;

end behavioral;
