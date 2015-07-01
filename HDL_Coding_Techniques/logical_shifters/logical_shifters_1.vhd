--
-- Following is the VHDL code for a logical shifter.
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/logical_shifters/logical_shifters_1.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logical_shifters_1 is
    port(DI  : in  unsigned(15 downto 0);
         SEL : in  unsigned(3 downto 0);
         SO  : out unsigned(15 downto 0));
end logical_shifters_1;

architecture archi of logical_shifters_1 is
begin
    with SEL select
        SO <= DI  when "0000",
        DI sll 1  when "0001",
        DI sll 2  when "0010",
        DI sll 3  when "0011",
        DI sll 4  when "0100",
        DI sll 5  when "0101",
        DI sll 6  when "0110",
        DI sll 7  when "0111",
        DI sll 8  when "1000",
        DI sll 9  when "1001",
        DI sll 10 when "1010",
        DI sll 11 when "1011",
        DI sll 12 when "1100",
        DI sll 13 when "1101",
        DI sll 14 when "1110",
        DI sll 15 when others;
end archi;
