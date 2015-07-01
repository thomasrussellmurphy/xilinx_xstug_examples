-- 
-- Unsigned 8-bit Subtractor with Borrow In
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/adders/adders_8.vhd
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity adders_8 is
    port(A,B : in std_logic_vector(7 downto 0);
	     BI  : in std_logic;
         RES : out std_logic_vector(7 downto 0));
end adders_8;

architecture archi of adders_8 is

begin

	RES <= A - B - BI;
	
end archi;

