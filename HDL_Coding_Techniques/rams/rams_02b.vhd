--
-- Single-Port BRAM Write-First Mode (registered read address template)
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_02b.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_02b is
port (clk  : in std_logic;
      we   : in std_logic;
      en   : in std_logic;
      addr : in std_logic_vector(5 downto 0);
      di   : in std_logic_vector(15 downto 0);
      do   : out std_logic_vector(15 downto 0));
end rams_02b;

architecture syn of rams_02b is
    type ram_type is array (63 downto 0) of std_logic_vector (15 downto 0);
    signal RAM : ram_type;
    signal read_addr: std_logic_vector(5 downto 0);
begin

    process (clk)
    begin
        if clk'event and clk = '1' then
            if en = '1' then
                if we = '1' then
                    ram(conv_integer(addr)) <= di;
                end if;
                read_addr <= addr;
            end if;
        end if;
    end process;

    do <= ram(conv_integer(read_addr));

end syn;
