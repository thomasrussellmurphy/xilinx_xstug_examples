--
-- 3-Bit 1-of-9 Priority Encoder
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/priority_encoders/priority_encoders_1.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity priority_encoders_1 is
    port ( sel : in std_logic_vector (7 downto 0);
           code :out std_logic_vector (2 downto 0));

    attribute priority_extract: string;
    attribute priority_extract of priority_encoders_1: entity is "force";
end priority_encoders_1;

architecture archi of priority_encoders_1 is
begin

    code <= "000" when sel(0) = '1' else
            "001" when sel(1) = '1' else
            "010" when sel(2) = '1' else
            "011" when sel(3) = '1' else
            "100" when sel(4) = '1' else
            "101" when sel(5) = '1' else
            "110" when sel(6) = '1' else
            "111" when sel(7) = '1' else
            "---";

end archi;
