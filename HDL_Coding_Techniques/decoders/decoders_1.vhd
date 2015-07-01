--
-- 1-of-16 decoder (One-Hot)
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/decoders/decoders_1.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity decoders_1 is
    port (sel: in std_logic_vector (3 downto 0);
          res: out std_logic_vector (15 downto 0));
    end decoders_1;

architecture archi of decoders_1 is
begin
    res <= "0000000000000001" when sel = "0000" else
           "0000000000000010" when sel = "0001" else
           "0000000000000100" when sel = "0010" else
           "0000000000001000" when sel = "0011" else
           "0000000000010000" when sel = "0100" else
           "0000000000100000" when sel = "0101" else
           "0000000001000000" when sel = "0110" else
           "0000000010000000" when sel = "0111" else
           "0000000100000000" when sel = "1000" else
           "0000001000000000" when sel = "1001" else
           "0000010000000000" when sel = "1010" else
           "0000100000000000" when sel = "1011" else
           "0001000000000000" when sel = "1100" else
           "0010000000000000" when sel = "1101" else
           "0100000000000000" when sel = "1110" else
           "1000000000000000";
end archi;
