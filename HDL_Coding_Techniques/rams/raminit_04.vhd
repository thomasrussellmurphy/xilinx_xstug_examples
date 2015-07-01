--
-- RAM initial contents described in the VHDL source code
-- All bit positions initialized to same value
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/raminit_04.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity raminit_04 is
    port (
        clk : in  std_logic;
        we  : in  std_logic;
        a   : in  std_logic_vector(6 downto 0);
        di  : in  std_logic_vector(15 downto 0);
        do  : out std_logic_vector(15 downto 0)
    );
end raminit_04;

architecture syn of raminit_04 is

    type ram_type is array (0 to 127) of std_logic_vector (15 downto 0);
    signal RAM : ram_type := (others => (others => '1'));
    
begin

    process (clk)
    begin
        if (clk'event and clk = '1') then
            if (we = '1') then
                RAM(conv_integer(a)) <= di;
            end if;
            do <= RAM(conv_integer(a));
        end if;
    end process;

end syn;
