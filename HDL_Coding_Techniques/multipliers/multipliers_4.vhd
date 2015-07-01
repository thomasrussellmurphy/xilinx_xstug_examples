--
-- Pipelined multiplier
--    The multiplication operation placed outside the
--    process block and the pipeline stages represented 
--    as shift registers.
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/multipliers/multipliers_4.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multipliers_4 is
    generic(A_port_size: integer := 18;
            B_port_size: integer := 18);
    port(clk : in std_logic;
         A : in unsigned (A_port_size-1 downto 0);
         B : in unsigned (B_port_size-1 downto 0);
         MULT : out unsigned ( (A_port_size+B_port_size-1) downto 0));

    attribute mult_style: string;
    attribute mult_style of multipliers_4: entity is "pipe_lut";

end multipliers_4;

architecture beh of multipliers_4 is
    signal a_in, b_in : unsigned (A_port_size-1 downto 0);
    signal mult_res : unsigned ((A_port_size+B_port_size-1) downto 0);
    
    type pipe_reg_type is array (2 downto 0) of unsigned ((A_port_size+B_port_size-1) downto 0);
    signal pipe_regs : pipe_reg_type;
    
begin

    mult_res <= a_in * b_in;

    process (clk)
    begin
        if (clk'event and clk='1') then
            a_in <= A; b_in <= B;
            pipe_regs <= mult_res & pipe_regs(2 downto 1);
            MULT <= pipe_regs(0);
        end if;
    end process;
end beh;
