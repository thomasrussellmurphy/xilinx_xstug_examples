--
-- Quad-Port Distibuted RAM
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_23.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rams_23 is
    port (clk   : in  std_logic;
          weA   : in  std_logic;
          addrA : in  std_logic_vector( 5 downto 0);
          addrB : in  std_logic_vector( 5 downto 0);
          addrC : in  std_logic_vector( 5 downto 0);
          addrD : in  std_logic_vector( 5 downto 0);
          diA   : in  std_logic_vector(15 downto 0);
          doA   : out std_logic_vector(15 downto 0);
          doB   : out std_logic_vector(15 downto 0);
          doC   : out std_logic_vector(15 downto 0);
          doD   : out std_logic_vector(15 downto 0));      
end rams_23;

architecture syn of rams_23 is
    type ram_type is array (0 to 63) of std_logic_vector(15 downto 0);
    signal RAM: ram_type;    
begin

    process(clk)
    begin
      if clk'event and clk = '1' then
        if weA = '1' then
          RAM(conv_integer(addrA)) <= diA;
        end if;
      end if;
    end process;
    
    doA <= RAM(conv_integer(addrA));
    doB <= RAM(conv_integer(addrB));
    doC <= RAM(conv_integer(addrC));
    doD <= RAM(conv_integer(addrD));
    
end syn;
