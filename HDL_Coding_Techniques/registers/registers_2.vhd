--
-- Flip-Flop with Negative-Edge Clock and Asynchronous Reset
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/registers/registers_2.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity registers_2 is
    port(C, D, CLR : in  std_logic;
         Q         : out std_logic);
end registers_2;

architecture archi of registers_2 is
begin

    process (C, CLR)
    begin
        if (CLR = '1')then
            Q <= '0';
        elsif (C'event and C='0')then
            Q <= D;
        end if;
    end process;

end archi;
