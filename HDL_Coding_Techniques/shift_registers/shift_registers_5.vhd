--
-- 8-bit Shift-Left Register with Positive-Edge Clock, 
-- Serial In, and Parallel Out
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/shift_registers/shift_registers_5.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity shift_registers_5 is
    port(C, SI : in std_logic;
         PO : out std_logic_vector(7 downto 0));
end shift_registers_5;

architecture archi of shift_registers_5 is
    signal tmp: std_logic_vector(7 downto 0);
begin

    process (C)
    begin
        if rising_edge(C) then
            tmp <= tmp(6 downto 0)& SI;
        end if;
    end process;

    PO <= tmp;

end archi;
