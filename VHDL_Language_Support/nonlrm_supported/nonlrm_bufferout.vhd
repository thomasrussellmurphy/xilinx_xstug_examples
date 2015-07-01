--
-- Supported non-LRM port association between
--     a formal buffer
--     an actual out
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: VHDL_Language_Support/nonlrm_supported/nonlrm_bufferout.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity nonlrm_bufferout is
  port (
    clk : in     std_logic;
    A   : in     std_logic;
    B   : in     std_logic;
    O   : buffer std_logic);
end nonlrm_bufferout;

architecture behavioral of nonlrm_bufferout is
begin
  process(clk)
  begin
    if rising_edge(clk) then
      O <= A xor B xor O;
    end if;
  end process;
end behavioral;


library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk : in     std_logic;
    A   : in     std_logic;
    B   : in     std_logic;
    O   : out    std_logic);
end top;

architecture behavioral of top is
  component sub is
    port (
      clk : in     std_logic;
      A   : in     std_logic;
      B   : in     std_logic;
      O   : buffer std_logic);
  end component;
begin
  isub : sub
    port map (
      clk => clk,
      A   => A,
      B   => B,
      O   => O);
end behavioral;


