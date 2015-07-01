--
-- Unsigned 8-bit Adder with Carry In
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/adders/adders_2.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adders_2 is
    generic (
        WIDTH : integer := 8);
    port(
        CI   : in  std_logic;
        A, B : in  std_logic_vector(WIDTH-1 downto 0);
        SUM  : out std_logic_vector(WIDTH-1 downto 0));
end adders_2;

architecture archi of adders_2 is
begin
    SUM <= A + B + CI;
end archi;
