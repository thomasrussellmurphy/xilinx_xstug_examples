--
-- Block RAM with Resettable Data Output
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/rams_18.vhd
--
library ieee;                          
use ieee.std_logic_1164.all;           
use ieee.std_logic_unsigned.all;   
    
entity rams_18 is                       
    port (clk  : in std_logic;                    
          en   : in std_logic;                     
          we   : in std_logic;                     
          rst  : in std_logic;                    
          addr : in std_logic_vector(6 downto 0);
          di   : in std_logic_vector(15 downto 0);  
          do   : out std_logic_vector(15 downto 0));
end rams_18;                            

architecture syn of rams_18 is                                         
    type ram_type is array (127 downto 0) of std_logic_vector (15 downto 0);
    signal ram : ram_type;                                                
begin                                                                 

    process (clk)                                                         
    begin                                                                 
        if clk'event and clk = '1' then                                       
            if en = '1' then -- optional enable
                if we = '1' then -- write enable 
	            ram(conv_integer(addr)) <= di;
		end if;
		if rst = '1' then -- optional reset
		    do <= (others => '0');
		else
		    do <= ram(conv_integer(addr));
		end if;
            end if;                                                             
        end if;                                                               
    end process;                                                          

end syn;                                                              
