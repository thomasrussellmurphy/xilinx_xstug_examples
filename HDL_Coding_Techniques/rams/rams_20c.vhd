--
-- Initializing Block RAM from external data file
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_2oc.vhd
--
library ieee;                             
use ieee.std_logic_1164.all;              
use ieee.std_logic_unsigned.all;          
use std.textio.all; 
                      
entity rams_20c is                    
    port(clk  : in std_logic;                 
         we   : in std_logic;                        
         addr : in std_logic_vector(5 downto 0);   
         din  : in std_logic_vector(31 downto 0);   
         dout : out std_logic_vector(31 downto 0));
end rams_20c;                         

architecture syn of rams_20c is                        

    type RamType is array(0 to 63) of bit_vector(31 downto 0);    

    impure function InitRamFromFile (RamFileName : in string) return RamType is                                                   
        FILE RamFile         : text is in RamFileName;                       
        variable RamFileLine : line;                                 
        variable RAM         : RamType;                                      
    begin                                                        
        for I in RamType'range loop                                  
            readline (RamFile, RamFileLine);                             
            read (RamFileLine, RAM(I));                                  
        end loop;                                                    
        return RAM;                                                  
    end function;                                                

    signal RAM : RamType := InitRamFromFile("rams_20c.data");

begin                                                        

    process (clk)                                                
    begin                                                        
        if clk'event and clk = '1' then                              
            if we = '1' then                                             
                RAM(conv_integer(addr)) <= to_bitvector(din);                
            end if;                                                      
            dout <= to_stdlogicvector(RAM(conv_integer(addr)));          
        end if;                                                      
    end process;                                                 

end syn;                                                   
