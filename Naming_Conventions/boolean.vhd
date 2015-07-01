--
-- Naming of boolean type objects
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: Naming_Conventions/boolean.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity top is
    port(
        clk  : in  std_logic;
	di   : in  boolean;
        do   : out boolean
    ); 
end top;

architecture behavioral of top is
    signal data : boolean;
begin

    process (clk)
    begin
        if rising_edge(clk) then
            data <= di;       -- Post-synthesis name : data          
        end if;
    end process;

    do <= not(data);
    
end behavioral;
