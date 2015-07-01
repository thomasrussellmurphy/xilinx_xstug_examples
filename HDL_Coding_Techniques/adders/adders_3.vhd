--
-- Unsigned 8-bit Adder with Carry Out
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/adders/adders_3.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity adders_3 is
    generic (
        WIDTH : integer := 8);
    port(
        A, B : in  std_logic_vector(WIDTH-1 downto 0);
        SUM  : out std_logic_vector(WIDTH-1 downto 0);
        CO   : out std_logic);
end adders_3;

architecture archi of adders_3 is
    signal tmp: std_logic_vector(WIDTH downto 0);
begin
    tmp <= conv_std_logic_vector((conv_integer(A) + conv_integer(B)),WIDTH+1);
    SUM <= tmp(WIDTH-1 downto 0);
    CO  <= tmp(WIDTH);
end archi;
