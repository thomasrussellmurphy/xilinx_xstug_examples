--
-- Simple dual-port block RAM
--     1 write-only port
--     1 read-only port
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_27.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_27 is
    port (clk   : in std_logic;
          en    : in std_logic;
          we    : in std_logic;
          re    : in std_logic;
          waddr : in std_logic_vector(6 downto 0);
          raddr : in std_logic_vector(6 downto 0);
          di    : in std_logic_vector(7 downto 0);
          do    : out std_logic_vector(7 downto 0));
end rams_27;

architecture syn of rams_27 is
    type ram_type is array (127 downto 0) of std_logic_vector (7 downto 0);
    signal RAM : ram_type;
begin

    process (clk)
    begin
        if (clk'event and clk = '1') then
            if (we = '1') then
                RAM(conv_integer(waddr)) <= di;
            end if;
            if (re = '1') then
                do <= RAM(conv_integer(raddr));
            end if;
        end if;
    end process;

end syn;
