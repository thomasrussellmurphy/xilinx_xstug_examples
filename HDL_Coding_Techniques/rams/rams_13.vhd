--
-- Dual-Port RAM with One Enable Controlling Both Ports
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_13.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_13 is
    port (clk   : in std_logic;
          en    : in std_logic;
          we    : in std_logic;
          addra : in std_logic_vector(5 downto 0);
          addrb : in std_logic_vector(5 downto 0);
          di    : in std_logic_vector(15 downto 0);
          doa   : out std_logic_vector(15 downto 0);
          dob   : out std_logic_vector(15 downto 0));
end rams_13;

architecture syn of rams_13 is
    type ram_type is array (63 downto 0) of std_logic_vector (15 downto 0);
    signal RAM : ram_type;
    signal read_addra : std_logic_vector(5 downto 0);
    signal read_addrb : std_logic_vector(5 downto 0);
begin

    process (clk)
    begin
        if (clk'event and clk = '1') then
            if (en = '1') then
                if (we = '1') then
                    RAM(conv_integer(addra)) <= di;
                end if;

                read_addra <= addra;
                read_addrb <= addrb;

            end if;
        end if;
    end process;

    doa <= RAM(conv_integer(read_addra));
    dob <= RAM(conv_integer(read_addrb));

end syn;
