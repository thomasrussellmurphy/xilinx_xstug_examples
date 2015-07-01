--
-- Single-Port BRAM with Byte-wide Write Enable
--   2x8-bit write
--   Read-First Mode
--   Two-process description
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_24.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_24 is

  generic (
    SIZE       : integer := 512;
    ADDR_WIDTH : integer := 9;
    COL_WIDTH  : integer := 16;
    NB_COL     : integer := 2);
  
  port (
    clk  : in  std_logic;
    we   : in  std_logic_vector(NB_COL-1 downto 0);
    addr : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
    di   : in  std_logic_vector(NB_COL*COL_WIDTH-1 downto 0);
    do   : out std_logic_vector(NB_COL*COL_WIDTH-1 downto 0));
      
end rams_24;

architecture syn of rams_24 is

    type ram_type is array (SIZE-1 downto 0) of std_logic_vector (NB_COL*COL_WIDTH-1 downto 0);
    signal RAM : ram_type := (others => (others => '0'));

    signal di0, di1 : std_logic_vector (COL_WIDTH-1 downto 0);
begin

    process(we, di)
    begin
        if we(1) = '1' then
            di1 <= di(2*COL_WIDTH-1 downto 1*COL_WIDTH);
        else
            di1 <= RAM(conv_integer(addr))(2*COL_WIDTH-1 downto 1*COL_WIDTH);
        end if;
        
        if we(0) = '1' then
            di0 <= di(COL_WIDTH-1 downto 0);
        else
            di0 <= RAM(conv_integer(addr))(COL_WIDTH-1 downto 0);
        end if;
    end process;
  
    process(clk)
    begin
        if (clk'event and clk = '1') then
            do <= RAM(conv_integer(addr));
            RAM(conv_integer(addr)) <= di1 & di0;
        end if;
    end process;

end syn;

