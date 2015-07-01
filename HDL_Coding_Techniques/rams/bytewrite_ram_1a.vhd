--
-- Single-Port BRAM with Byte-wide Write Enable
--   2x8-bit write
--   Read-First Mode
--   Single-process description
--   Explicit enumaration of each write column
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/bytewrite_ram_1a.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bytewrite_ram_1a is

  generic (
    SIZE       : integer := 1024;
    ADDR_WIDTH : integer := 10;
    COL_WIDTH  : integer := 8;
    NB_COL     : integer := 2);
    
  port (
    clk  : in  std_logic;
    we   : in  std_logic_vector(NB_COL-1 downto 0);
    addr : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
    di   : in  std_logic_vector(NB_COL*COL_WIDTH-1 downto 0);
    do   : out std_logic_vector(NB_COL*COL_WIDTH-1 downto 0));
    
end bytewrite_ram_1a;

architecture behavioral of bytewrite_ram_1a is

  type ram_type is array (SIZE-1 downto 0)
                of std_logic_vector (2*COL_WIDTH-1 downto 0);
  signal RAM : ram_type := (others => (others => '0'));

begin

  process (clk)
  begin
    if rising_edge(clk) then
      do <= RAM(conv_integer(addr));
      if we(1) = '1' then
  	RAM(conv_integer(addr))(2*COL_WIDTH-1 downto 1*COL_WIDTH)
	  <= di(2*COL_WIDTH-1 downto 1*COL_WIDTH);
      end if;	     
      if we(0) = '1' then
  	RAM(conv_integer(addr))(COL_WIDTH-1 downto 0)
	  <= di(COL_WIDTH-1 downto 0);
      end if;
    end if;
  end process;

end behavioral;

