--
-- No Decoder Inference (some selector values are unused)
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/decoders/decoders_4.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity decoders_4 is
    port (sel: in std_logic_vector (2 downto 0);
          res: out std_logic_vector (7 downto 0));
end decoders_4;

architecture archi of decoders_4 is
begin
    res <= "00000001" when sel = "000" else
           "00000010" when sel = "001" else
           "00000100" when sel = "010" else
           "00001000" when sel = "011" else
           "00010000" when sel = "100" else
           "00100000" when sel = "101" else
           -- 110 and 111 selector values are unused
           "XXXXXXXX";
end archi;
