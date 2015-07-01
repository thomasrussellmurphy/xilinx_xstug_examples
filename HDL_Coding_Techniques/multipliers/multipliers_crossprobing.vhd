--
-- Unsigned 8x4-bit Multiplier
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/multipliers/multipliers_crossprobing.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multipliers_crossprobing is
    port(A : in std_logic_vector(7 downto 0);
         B : in std_logic_vector(3 downto 0);
         C : in std_logic_vector(3 downto 0);
	 S : in std_logic;
         RES : out std_logic_vector(11 downto 0));
	 
	 attribute resource_sharing : string;
	 attribute resource_sharing of multipliers_crossprobing : entity is "no";
	 
end multipliers_crossprobing;

architecture beh of multipliers_crossprobing is
begin
    RES <= A * B when S = '1' else A * C;
end beh;
