--
-- Dual-Port RAM with False Synchronous Read
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_10.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_10 is
    port (clk  : in std_logic;
          we   : in std_logic;
          a    : in std_logic_vector(5 downto 0);
          dpra : in std_logic_vector(5 downto 0);
          di   : in std_logic_vector(15 downto 0);
          spo  : out std_logic_vector(15 downto 0);
          dpo  : out std_logic_vector(15 downto 0));
end rams_10;

architecture syn of rams_10 is
    type ram_type is array (63 downto 0) of std_logic_vector (15 downto 0);
    signal RAM : ram_type;
begin

    process (clk)
    begin
        if (clk'event and clk = '1') then
            if (we = '1') then
                RAM(conv_integer(a)) <= di;
            end if;

            spo <= RAM(conv_integer(a));
            dpo <= RAM(conv_integer(dpra));

        end if;
    end process;

end syn;
