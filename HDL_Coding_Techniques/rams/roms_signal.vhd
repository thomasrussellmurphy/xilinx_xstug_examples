--
-- Description of a ROM with a VHDL signal
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/roms_signal.vhd
--
library ieee;                                                         
use ieee.std_logic_1164.all;                                          
use ieee.std_logic_unsigned.all; 
                                     
entity roms_signal is                                                     
    port (clk  : in  std_logic;                                                   
          en   : in  std_logic;                                                    
          addr : in  std_logic_vector(6 downto 0);                               
          data : out std_logic_vector(19 downto 0));                             
end roms_signal;                                                          

architecture syn of roms_signal is                                        
										 
    type rom_type is array (0 to 127) of std_logic_vector (19 downto 0);                 
    signal ROM : rom_type:= (
        X"0200A", X"00300", X"08101", X"04000", X"08601", X"0233A", X"00300", X"08602",
	X"02310", X"0203B", X"08300", X"04002", X"08201", X"00500", X"04001", X"02500",
	X"00340", X"00241", X"04002", X"08300", X"08201", X"00500", X"08101", X"00602",
        X"04003", X"0241E", X"00301", X"00102", X"02122", X"02021", X"00301", X"00102",
	X"02222", X"04001", X"00342", X"0232B", X"00900", X"00302", X"00102", X"04002",
	X"00900", X"08201", X"02023", X"00303", X"02433", X"00301", X"04004", X"00301",
        X"00102", X"02137", X"02036", X"00301", X"00102", X"02237", X"04004", X"00304",
	X"04040", X"02500", X"02500", X"02500", X"0030D", X"02341", X"08201", X"0400D",
        X"0200A", X"00300", X"08101", X"04000", X"08601", X"0233A", X"00300", X"08602",
	X"02310", X"0203B", X"08300", X"04002", X"08201", X"00500", X"04001", X"02500",
	X"00340", X"00241", X"04112", X"08300", X"08201", X"00500", X"08101", X"00602",
        X"04003", X"0241E", X"00301", X"00102", X"02122", X"02021", X"00301", X"00102",
	X"02222", X"04001", X"00342", X"0232B", X"00870", X"00302", X"00102", X"04002",
	X"00900", X"08201", X"02023", X"00303", X"02433", X"00301", X"04004", X"00301",
        X"00102", X"02137", X"FF036", X"00301", X"00102", X"10237", X"04934", X"00304",
	X"04078", X"01110", X"02500", X"02500", X"0030D", X"02341", X"08201", X"0410D"
	);                        

begin                                                                 

    process (clk)                                                         
    begin                                                                 
        if (clk'event and clk = '1') then                                     
            if (en = '1') then                                                    
                data <= ROM(conv_integer(addr));                                       
            end if;                                                               
        end if;                                                               
    end process;

end syn;                                                              
