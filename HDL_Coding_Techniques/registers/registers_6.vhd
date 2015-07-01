--
-- Flip-Flop with
--     Rising-edge Clock
--     Active-high Synchronous Reset
--     Active-high Clock Enable
--     Initial Value
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/registers/registers_6.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity registers_6 is
    port(
        clk   : in  std_logic;
        rst   : in  std_logic;
        clken : in  std_logic;
        D     : in  std_logic;
        Q     : out std_logic);
end registers_6;

architecture behavioral of registers_6 is
    signal S  : std_logic := '0';
begin

    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1'then
                S <= '0';
            elsif clken = '1' then
                S <= D;
            end if;
        end if;
    end process;

    Q <= S;
    
end behavioral;
