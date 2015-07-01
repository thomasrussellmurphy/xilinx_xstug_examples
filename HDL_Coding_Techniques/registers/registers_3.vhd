--
-- Flip-Flop with Positive-Edge Clock and Synchronous Set
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/registers/registers_3.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity registers_3 is
    port(C, D, S : in  std_logic;
         Q       : out std_logic);
end registers_3;

architecture archi of registers_3 is
begin

    process (C)
    begin
        if (C'event and C='1') then
            if (S='1') then
                Q <= '1';
            else
                Q <= D;
            end if;
        end if;
    end process;

end archi;
