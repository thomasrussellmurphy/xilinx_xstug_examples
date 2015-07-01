--
-- 4-bit Unsigned Up Accumulator with Asynchronous Reset
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/accumulators/macexample.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- use ieee.std_logic_arith.all;

entity macexample is
    port(C, CLR : in std_logic;
         A : in std_logic_vector(15 downto 0);
         B : in std_logic_vector(15 downto 0);
         Q : out std_logic_vector(31 downto 0));
end macexample;

architecture archi of macexample is
    signal tmp: std_logic_vector(31 downto 0);
    signal M: std_logic_vector(31 downto 0);
    signal rA, rB : std_logic_vector(15 downto 0);
begin

    process (C, CLR)
    begin
        if (CLR='1') then
            tmp <= (others => '0');
	    M <= (others => '0');
	    rA <= (others => '0');
	    rB <= (others => '0');	    
        elsif (C'event and C='1') then
            -- tmp <= tmp + sxt(M, 47);
            tmp <= tmp + M;
	    M <= rA * rB;
	    rA <= A;
	    rB <= B;
        end if;
    end process;
    
    Q <= tmp;
    
end archi;
