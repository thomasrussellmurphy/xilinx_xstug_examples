--
-- Comparisons to constants
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/comparators/comparators_linenbpb.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comparators_linenbpb is

    port(
        A, B,C  : in  std_logic_vector(7 downto 0);
        CMPeq : out std_logic;
        CMPne : out std_logic;
        CMP1   : out std_logic;
        CMP2   : out std_logic
    );

end comparators_linenbpb;

architecture behavioral of comparators_linenbpb is
begin

    CMPeq <= '1' when A  = "00101111" else '0';
    CMPne <= '1' when A /= "00000010" else '0';
    
    CMP1   <= '1' when A  = B  else
              '0' when A  > C  else '1';
    

end behavioral;
