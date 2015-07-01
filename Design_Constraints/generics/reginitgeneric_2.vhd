-- 
-- Initial contents of a register is defined through an integer generic
-- May be overriden from the XST run command line with:
--   -generics { INITVAL=47 }
--   -generics { INITVAL=d63 }
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: Design_Constraints/generics/reginitgeneric_2.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reginitgeneric_2 is

  generic (
    INITVAL : integer := 0);
  port (
    clk : in  std_logic;
    di  : in  std_logic_vector(7 downto 0);
    do  : out std_logic_vector(7 downto 0));
	 
end reginitgeneric_2;


architecture behavioral of reginitgeneric_2 is
  signal q : std_logic_vector(7 downto 0) := conv_std_logic_vector(INITVAL, 8);
begin 

  process (clk)
  begin
    if rising_edge(clk) then    
      q <= di;
    end if;
  end process;
 
  do <= q;
      
end behavioral;
