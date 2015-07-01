--
-- 8-to-1 1-bit MUX using tristate buffers.
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/multiplexers/multiplexers_3.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity multiplexers_3 is

    port (di  : in  std_logic_vector(7 downto 0);
          sel : in  std_logic_vector(7 downto 0);
          do  : out std_logic);
	  
end multiplexers_3;

architecture archi of multiplexers_3 is
begin
    do <= di(0) when sel(0)='0' else 'Z';
    do <= di(1) when sel(1)='0' else 'Z';
    do <= di(2) when sel(2)='0' else 'Z';
    do <= di(3) when sel(3)='0' else 'Z';
    do <= di(4) when sel(4)='0' else 'Z';
    do <= di(5) when sel(5)='0' else 'Z';
    do <= di(6) when sel(6)='0' else 'Z';
    do <= di(7) when sel(7)='0' else 'Z';
end archi;
