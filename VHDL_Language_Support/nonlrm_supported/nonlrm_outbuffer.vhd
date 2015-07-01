--
-- Supported non-LRM port association between
--     a formal out
--     an actual buffer
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: VHDL_Language_Support/nonlrm_supported/nonlrm_outbuffer.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity nonlrm_outbuffer is
  port (
    clk : in     std_logic;
    A   : in     std_logic;
    B   : in     std_logic;
    O   : out    std_logic);
end nonlrm_outbuffer;

architecture behavioral of nonlrm_outbuffer is
begin
  process(clk)
  begin
    if rising_edge(clk) then
      O <= A xor B;
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
    O1  : buffer std_logic;
    O2  : out    std_logic);
end top;

architecture behavioral of top is
  component sub is
    port (
      clk : in     std_logic;
      A   : in     std_logic;
      B   : in     std_logic;
      O   : out    std_logic);
  end component;
begin
  
  isub : sub
    port map (
      clk => clk,
      A   => A,
      B   => B,
      O   => O1);
      
  O2 <= not(O1);
  
end behavioral;


