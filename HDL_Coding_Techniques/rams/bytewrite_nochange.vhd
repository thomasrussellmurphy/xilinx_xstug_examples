--
-- Single-Port BRAM with Byte-wide Write Enable
--   2x8-bit write
--   No-Change mode
--   Single-process description
--   Compact description of the write with a for-loop statement
--   Column width and number of columns easily configurable 
-- 
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/bytewrite_nochange.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bytewrite_nochange is

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
    
end bytewrite_nochange;

architecture behavioral of bytewrite_nochange is

  type ram_type is array (SIZE-1 downto 0) of std_logic_vector (NB_COL*COL_WIDTH-1 downto 0);
  signal RAM : ram_type := (others => (others => '0'));
begin

  process (clk)
  begin
    if rising_edge(clk) then
      if (we = (we'range => '0')) then
        do <= RAM(conv_integer(addr));
      end if;  
      for i in 0 to NB_COL-1 loop
        if we(i) = '1' then
  	  RAM(conv_integer(addr))((i+1)*COL_WIDTH-1 downto i*COL_WIDTH)
	    <= di((i+1)*COL_WIDTH-1 downto i*COL_WIDTH);
        end if;	     
      end loop;
    end if;
  end process;

end behavioral;
