--
-- A 514-deep 8-bit delay line implemented on block RAM
-- 512 stages implemented as addressable memory words
-- 2 stages implemented with output latch and optional output register for
-- optimal performance
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/shift_registers/delayline_bram_514.vhd
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity srl_514_bram is
  generic (
    LENGTH    : integer := 514;
    ADDRWIDTH : integer := 9;
    WIDTH     : integer := 8);
  port (
    CLK       : in  std_logic;
    SHIFT_IN  : in  std_logic_vector(WIDTH-1 downto 0);
    SHIFT_OUT : out std_logic_vector(WIDTH-1 downto 0));
end srl_514_bram;


architecture behavioral of srl_514_bram is

  signal CNTR : std_logic_vector(ADDRWIDTH-1 downto 0);
  signal SHIFT_TMP : std_logic_vector(WIDTH-1 downto 0);
  type ram_type is array (0 to LENGTH-3) of std_logic_vector(WIDTH-1 downto 0);
  signal RAM : ram_type := (others => (others => '0'));
begin

  counter : process (CLK)
  begin
    if CLK'event and CLK = '1' then
      CNTR <= CNTR + '1';
    end if;
  end process counter;


  memory : process (CLK)
  begin
    if CLK'event and CLK = '1' then
      RAM(conv_integer(CNTR)) <= SHIFT_IN;
      SHIFT_TMP               <= RAM(conv_integer(CNTR));
      SHIFT_OUT               <= SHIFT_TMP;
    end if;
  end process memory;
  
end behavioral;
