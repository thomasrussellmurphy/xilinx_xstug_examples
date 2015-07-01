--
-- Single-Port RAM with "False" Synchronous Read with
-- an additional reset of the RAM output,
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_06.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_06 is
    port (clk : in std_logic;
          we  : in std_logic;
          rst : in std_logic;
          a   : in std_logic_vector(5 downto 0);
          di  : in std_logic_vector(15 downto 0);
          do  : out std_logic_vector(15 downto 0));
end rams_06;

architecture syn of rams_06 is
    type ram_type is array (63 downto 0) of std_logic_vector (15 downto 0);
    signal RAM : ram_type;
begin

    process (clk)
    begin
        if (clk'event and clk = '1') then

            if (we = '1') then
                RAM(conv_integer(a)) <= di;
            end if;

            if (rst = '1') then
                do <= (others => '0');
            else
                do <= RAM(conv_integer(a));
            end if;

        end if;
    end process;

end syn;
