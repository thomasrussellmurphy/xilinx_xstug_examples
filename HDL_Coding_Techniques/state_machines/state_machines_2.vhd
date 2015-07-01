--
-- State Machine described with two processes
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/state_machines/state_machines_2.vhd
--
library IEEE;
use IEEE.std_logic_1164.all;
entity fsm_2 is
    port ( clk, reset, x1 : IN std_logic;
           outp           : OUT std_logic);
end entity;

architecture beh1 of fsm_2 is
    type state_type is (s1,s2,s3,s4);
    signal state : state_type ;
begin

    process1: process (clk)
    begin
        if rising_edge(clk) then
            if (reset ='1') then
	        state <=s1;
	    else
                case state is
                    when s1 =>  if x1='1' then 
                                    state <= s2;
                                else
                                    state <= s3;
                                end if;
                    when s2 => state <= s4;
                    when s3 => state <= s4;
                    when s4 => state <= s1;
                end case;
            end if;
        end if;
    end process process1;

    process2 : process (state)
    begin
        case state is
            when s1 => outp <= '1';
            when s2 => outp <= '1';
            when s3 => outp <= '0';
            when s4 => outp <= '0';
        end case;
    end process process2;

end beh1;
