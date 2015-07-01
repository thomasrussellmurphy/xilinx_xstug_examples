--
-- Multiple-Port RAM Descriptions
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_17.vhd
--
library ieee;                                                         
use ieee.std_logic_1164.all;                                          
use ieee.std_logic_unsigned.all; 
                                     
entity rams_17 is                                                     
    port (clk : in std_logic;                                                   
          we  : in std_logic;                                                    
          wa  : in std_logic_vector(5 downto 0);                                 
          ra1 : in std_logic_vector(5 downto 0);                                
          ra2 : in std_logic_vector(5 downto 0);                                
          di  : in std_logic_vector(15 downto 0);                                 
          do1 : out std_logic_vector(15 downto 0);                               
          do2 : out std_logic_vector(15 downto 0));                              
end rams_17;                                                          

architecture syn of rams_17 is                                        
    type ram_type is array (63 downto 0) of std_logic_vector (15 downto 0);
    signal RAM : ram_type;                                                
begin                                                                 

    process (clk)                                                         
    begin                                                                 
        if (clk'event and clk = '1') then                                     
            if (we = '1') then                                                    
                RAM(conv_integer(wa)) <= di;                                          
            end if;                                                               
        end if;                                                               
    end process;                                                          

    do1 <= RAM(conv_integer(ra1));                                        
    do2 <= RAM(conv_integer(ra2));

end syn;                                                              
