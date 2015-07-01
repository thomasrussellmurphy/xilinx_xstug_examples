--
-- Latch with Positive Gate and Asynchronous Reset
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/latches/latches_cp.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity latches_cp is
    port(G, D, CLR, PRE : in std_logic;
         Q : out std_logic);
end latches_cp;

architecture archi of latches_cp is
begin
    process (CLR, D, G)
    begin
        if (CLR='1') then
            Q <= '0';
        elsif (PRE='1') then
            Q <= '1';
        elsif (G='1') then
            Q <= D;
        end if;
    end process;
end archi;
