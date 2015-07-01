--
-- 4-bit Unsigned Up Accumulator with Asynchronous Reset
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/accumulators/accumulators_1.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity accumulators_1 is
    generic (
        WIDTH : integer := 4);
    port(
        clk  : in  std_logic;
        rst  : in  std_logic;
        D    : in  std_logic_vector(WIDTH-1 downto 0);
        Q    : out std_logic_vector(WIDTH-1 downto 0));
end accumulators_1;

architecture archi of accumulators_1 is
    signal tmp: std_logic_vector(3 downto 0);
begin

    process (clk, rst)
    begin
        if (rst='1') then
            tmp <= "0000";
        elsif rising_edge(clk) then
            tmp <= tmp + D;
        end if;
    end process;
    
    Q <= tmp;
    
end archi;
