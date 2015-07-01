--
-- Comparisons to the maximum or minimum value that should be simplified to
-- a simple wire
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/comparators/comparetoconst_2.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comparetoconst_2 is

    port(
        A     : in  std_logic_vector(7 downto 0);
        CMPgt : out std_logic;
        CMPge : out std_logic;
        CMPlt : out std_logic;
        CMPle : out std_logic
    );

end comparetoconst_2;

architecture behavioral of comparetoconst_2 is
begin

    CMPgt <= '1' when A >  "11111111" else '0';    
    CMPge <= '1' when A >= "00000000" else '0';    
    CMPlt <= '1' when A <  "00000000" else '0';    
    CMPle <= '1' when A <= "11111111" else '0';    

end behavioral;
