--
-- 8-to-1 1-bit MUX using an If statement.
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/multiplexers/multiplexers_1.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity multiplexers_1 is

    port (di  : in  std_logic_vector(7 downto 0);
          sel : in  std_logic_vector(2 downto 0);
          do  : out std_logic);
	  
end multiplexers_1;

architecture archi of multiplexers_1 is
begin
    process (sel, di)
    begin
        if    (sel = "000") then do <= di(7);
        elsif (sel = "001") then do <= di(6);
        elsif (sel = "010") then do <= di(5);
        elsif (sel = "011") then do <= di(4);
        elsif (sel = "100") then do <= di(3);
        elsif (sel = "101") then do <= di(2);
        elsif (sel = "110") then do <= di(1);
        else                     do <= di(0);
        end if;
    end process;
end archi;
