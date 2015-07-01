--
-- In the following example, an asynchronous reset is used and
-- so, the logic is not mapped onto block RAM
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: FPGA_Optimization/mapping_logic_onto_block_ram/bram_map_2.vhd
--
library ieee;                                         
use ieee.std_logic_1164.all;                          
use ieee.numeric_std.all;                             

entity logic_bram_2 is                               
port (clk, rst : in std_logic;                              
      A,B      : in unsigned (3 downto 0);                       
      RES      : out unsigned (3 downto 0));                     

    attribute bram_map : string;                          
    attribute bram_map of logic_bram_2 : entity is "yes";

end logic_bram_2;                                    

architecture beh of logic_bram_2 is
begin                               

    process (clk, rst)                  
    begin                               
        if (rst='1') then                   
            RES <= "0000";                      
        elsif (clk'event and clk='1') then  
            RES <= A + B + "0001";              
        end if;                             
    end process;                        

end beh;                            
