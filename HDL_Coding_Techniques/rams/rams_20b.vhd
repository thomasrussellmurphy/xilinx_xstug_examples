--
-- RAM initial contents described in the VHDL source code
-- Specific address positions or ranges initialized to particular values
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_20b.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_20b is
    port (clk1  : in std_logic;
          clk2  : in std_logic;
          we    : in std_logic;
          addr1 : in std_logic_vector(7 downto 0);
          addr2 : in std_logic_vector(7 downto 0);
          di    : in std_logic_vector(15 downto 0);
          do1   : out std_logic_vector(15 downto 0);
          do2   : out std_logic_vector(15 downto 0));
end rams_20b;

architecture syn of rams_20b is

    type ram_type is array (255 downto 0) of std_logic_vector (15 downto 0);
    signal RAM : ram_type:= (
        196 downto 110 => X"B8B8",
	100            => X"FEFC",
	99 downto 0    => X"8282",
	others         => X"3344");

begin

    process (clk1)
    begin
        if rising_edge(clk1) then
            if we = '1' then
                RAM(conv_integer(addr1)) <= di;
            end if;
            do1 <= RAM(conv_integer(addr1));
        end if;
    end process;

    process (clk2)
    begin
        if rising_edge(clk2) then
            do2 <= RAM(conv_integer(addr2));
        end if;
    end process;

end syn;
