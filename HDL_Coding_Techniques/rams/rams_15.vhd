--
-- Dual-Port Block RAM with Different Clocks
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_15.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_15 is
    port (clka  : in std_logic;
          clkb  : in std_logic;
          wea   : in std_logic;
          addra : in std_logic_vector(5 downto 0);
          addrb : in std_logic_vector(5 downto 0);
          dia   : in std_logic_vector(15 downto 0);
          doa   : out std_logic_vector(15 downto 0);
          dob   : out std_logic_vector(15 downto 0));
end rams_15;

architecture syn of rams_15 is
    type ram_type is array (63 downto 0) of std_logic_vector (15 downto 0);
    signal RAM : ram_type;
    signal read_addra : std_logic_vector(5 downto 0);
    signal read_addrb : std_logic_vector(5 downto 0);
begin
    
    process (clka)
    begin
        if (clka'event and clka = '1') then
            if (wea = '1') then
                RAM(conv_integer(addra)) <= dia;
            end if;
            read_addra <= addra;
        end if;
    end process;

    process (clkb)
    begin
        if (clkb'event and clkb = '1') then
            read_addrb <= addrb;
        end if;
    end process;

    doa <= RAM(conv_integer(read_addra));
    dob <= RAM(conv_integer(read_addrb));

end syn;
