--
-- 4-bit Unsigned Up Accumulator with synchronous Reset
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/accumulators/accumulators_2.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity accumulators_2 is
    generic (
        WIDTH : integer := 4);
    port (
        clk  : in  std_logic;
        rst  : in  std_logic;
        D    : in  std_logic_vector(WIDTH-1 downto 0);
        Q    : out std_logic_vector(WIDTH-1 downto 0));	 
end accumulators_2;

architecture archi of accumulators_2 is
    signal cnt : std_logic_vector(WIDTH-1 downto 0);    
begin

    process (clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                cnt <= (others => '0');
            else
                cnt <= cnt + D;
            end if;
        end if;
    end process;
    
    Q <= cnt;
    
end archi;
