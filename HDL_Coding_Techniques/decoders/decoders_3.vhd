--
-- No Decoder Inference (unused decoder output)
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/decoders/decoders_3.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity decoders_3 is
    port (sel: in std_logic_vector (2 downto 0);
          res: out std_logic_vector (7 downto 0));
end decoders_3;

architecture archi of decoders_3 is
begin
    res <= "00000001" when sel = "000" else
           -- unused decoder output
           "XXXXXXXX" when sel = "001" else
           "00000100" when sel = "010" else
           "00001000" when sel = "011" else
           "00010000" when sel = "100" else
           "00100000" when sel = "101" else
           "01000000" when sel = "110" else
           "10000000";
end archi;
