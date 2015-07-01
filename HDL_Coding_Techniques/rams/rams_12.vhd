--
-- Dual-Port BRAM Write-First (registered read address template)
-- Distinct Clocks
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_12.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_12 is
    port (clk1 : in std_logic;
          clk2 : in std_logic;
          we   : in std_logic;
          add1 : in std_logic_vector(6 downto 0);
          add2 : in std_logic_vector(6 downto 0);
          di   : in std_logic_vector(15 downto 0);
          do1  : out std_logic_vector(15 downto 0);
          do2  : out std_logic_vector(15 downto 0));
end rams_12;

architecture syn of rams_12 is
    type ram_type is array (127 downto 0) of std_logic_vector (15 downto 0);
    signal RAM : ram_type;
    signal read_add1 : std_logic_vector(6 downto 0);
    signal read_add2 : std_logic_vector(6 downto 0);
begin

    process (clk1)
    begin
        if (clk1'event and clk1 = '1') then
            if (we = '1') then
                RAM(conv_integer(add1)) <= di;
            end if;
            read_add1 <= add1;
        end if;
    end process;

    do1 <= RAM(conv_integer(read_add1));

    process (clk2)
    begin
        if (clk2'event and clk2 = '1') then
            read_add2 <= add2;
        end if;
    end process;

    do2 <= RAM(conv_integer(read_add2));

end syn;
