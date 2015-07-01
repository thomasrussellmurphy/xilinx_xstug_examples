--
-- Unsigned 8-bit Subtractor
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/adders/adders_6.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adders_6 is
    port(A,B : in std_logic_vector(7 downto 0);
         RES : out std_logic_vector(7 downto 0));
end adders_6;

architecture archi of adders_6 is
begin

    RES <= A - B;

end archi;
