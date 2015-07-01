--
-- A 128-deep 8-bit delay line implemented on LUT RAM
-- 127 stages implemented as addressable memory words
-- Last stage implemented with an external register
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/shift_registers/delayline_lutram_128.vhd
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;


entity srl_128_lutram is
  generic (
    LENGTH    : integer := 128;
    ADDRWIDTH : integer := 7;
    WIDTH     : integer := 8);
  port (
    CLK       : in  std_logic;
    SHIFT_IN  : in  std_logic_vector(WIDTH-1 downto 0);
    SHIFT_OUT : out std_logic_vector(WIDTH-1 downto 0));
end srl_128_lutram;


architecture behavioral of srl_128_lutram is

  signal CNTR : std_logic_vector(ADDRWIDTH-1 downto 0);
  type ram_type is array (0 to LENGTH-2) of std_logic_vector(WIDTH-1 downto 0);
  signal RAM : ram_type := (others => (others => '0'));
  
  attribute ram_style : string;
  attribute ram_style of RAM : signal is "distributed";
  
begin

  counter : process (CLK)
  begin
    if CLK'event and CLK = '1' then
      if CNTR = conv_std_logic_vector(LENGTH-2, ADDRWIDTH)  then
        CNTR <= (others => '0');
      else
        CNTR <= CNTR + '1';
      end if;
    end if;
  end process counter;


  memory : process (CLK)
  begin
    if CLK'event and CLK = '1' then
      RAM(conv_integer(CNTR)) <= SHIFT_IN;
      SHIFT_OUT               <= RAM(conv_integer(CNTR));
    end if;
  end process memory;
  
end behavioral;
