--
-- Comparisons to constants
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/comparators/comparetoconst_1.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comparetoconst_1 is

    port(
        A     : in  std_logic_vector(7 downto 0);
        CMPeq : out std_logic;
        CMPne : out std_logic;
        CMPgt : out std_logic;
        CMPge : out std_logic
    );

end comparetoconst_1;

architecture behavioral of comparetoconst_1 is
begin

    CMPeq <= '1' when A  = "00101111" else '0';
    CMPne <= '1' when A /= "00000010" else '0';    
    CMPgt <= '1' when A >  "00001110" else '0';    
    CMPge <= '1' when A >= "10100010" else '0';    

end behavioral;
