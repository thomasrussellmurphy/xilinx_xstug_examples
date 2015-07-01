--
-- Single-Port BRAM with Byte-wide Write Enable (2 bytes) in Write-First Mode
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_25.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_25 is
    generic (SIZE       : integer := 512;
             ADDR_WIDTH : integer := 9;
             DI_WIDTH   : integer := 8);
  
    port (clk  : in  std_logic;
          we   : in  std_logic_vector(1 downto 0);
          addr : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
          di   : in  std_logic_vector(2*DI_WIDTH-1 downto 0);
          do   : out std_logic_vector(2*DI_WIDTH-1 downto 0));
end rams_25;

architecture syn of rams_25 is
   type ram_type is array (SIZE-1 downto 0) of std_logic_vector (2*DI_WIDTH-1 downto 0);
   signal RAM : ram_type;

   signal di0, di1 : std_logic_vector (DI_WIDTH-1 downto 0);
   signal do0, do1 : std_logic_vector (DI_WIDTH-1 downto 0);
begin

    process(we, di, addr, RAM)
    begin
        if we(1) = '1' then
            di1 <= di(2*DI_WIDTH-1 downto 1*DI_WIDTH);
            do1 <= di(2*DI_WIDTH-1 downto 1*DI_WIDTH);
        else
            di1 <= RAM(conv_integer(addr))(2*DI_WIDTH-1 downto 1*DI_WIDTH);
            do1 <= RAM(conv_integer(addr))(2*DI_WIDTH-1 downto 1*DI_WIDTH);
        end if;

        if we(0) = '1' then
            di0 <= di(DI_WIDTH-1 downto 0);
            do0 <= di(DI_WIDTH-1 downto 0);
        else
            di0 <= RAM(conv_integer(addr))(DI_WIDTH-1 downto 0);
            do0 <= RAM(conv_integer(addr))(DI_WIDTH-1 downto 0);
        end if;
    end process;
  
    process(clk)
    begin
        if (clk'event and clk = '1') then
            do <= do1 & do0;
            RAM(conv_integer(addr)) <= di1 & di0;
        end if;
    end process;

end syn;

