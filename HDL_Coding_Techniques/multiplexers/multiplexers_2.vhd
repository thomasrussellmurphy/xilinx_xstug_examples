--
-- 8-to-1 1-bit MUX using a Case statement.
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/multiplexers/multiplexers_2.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity multiplexers_2 is

    port (di  : in  std_logic_vector(7 downto 0);
          sel : in  std_logic_vector(2 downto 0);
          do  : out std_logic);
	  
end multiplexers_2;

architecture archi of multiplexers_2 is
begin
    process (sel, di)
    begin
        case sel is
            when "000"  => do <= di(7);
            when "001"  => do <= di(6);
            when "010"  => do <= di(5);
            when "011"  => do <= di(4);
            when "100"  => do <= di(3);
            when "101"  => do <= di(2);
            when "110"  => do <= di(1);
            when others => do <= di(0);
        end case;
    end process;
end archi;
