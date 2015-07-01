-- 
-- Initial contents of a register is defined through a binary or
-- hexadecimal generic
-- May be overriden from the XST run command line with:
--   -generics { INITVAL=b10101100 }
--   -generics { INITVAL=hD9 }
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: Design_Constraints/generics/reginitgeneric_1.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reginitgeneric_1 is

  generic (
    INITVAL : std_logic_vector(7 downto 0) := "11110000");
  port (
    clk : in  std_logic;
    di  : in  std_logic_vector(7 downto 0);
    do  : out std_logic_vector(7 downto 0));
	 
end reginitgeneric_1;


architecture behavioral of reginitgeneric_1 is
  signal q : std_logic_vector(7 downto 0) := INITVAL;
begin 

  process (clk)
  begin
    if rising_edge(clk) then    
      q <= di;
    end if;
  end process;
 
  do <= q;
      
end behavioral;
