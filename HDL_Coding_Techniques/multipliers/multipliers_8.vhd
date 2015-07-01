--
-- Sequential Complex Multiplier 
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/multipliers/multipliers_8.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multipliers_8 is
    generic(A_WIDTH:        positive:=18;
            B_WIDTH:        positive:=18;
            RES_WIDTH:      positive:=48);
    port(   CLK:            in  std_logic;
            A:              in  signed(A_WIDTH-1 downto 0);
            B:              in  signed(B_WIDTH-1 downto 0);

            Oper_Load:      in  std_logic;
            Oper_AddSub:    in  std_logic;
            --  Oper_Load  Oper_AddSub  Operation
            --  0          0            R= +A*B   
            --  0          1            R= -A*B   
            --  1          0            R=R+A*B   
            --  1          1            R=R-A*B   

            RES:             out signed(RES_WIDTH-1 downto 0)
    );
end multipliers_8;

architecture beh of multipliers_8 is

    constant P_WIDTH: integer:=A_WIDTH+B_WIDTH;

    signal oper_load0: std_logic:='0';
    signal oper_addsub0: std_logic:='0';

    signal p1: signed(P_WIDTH-1 downto 0):=(others=>'0');
    signal oper_load1: std_logic:='0';
    signal oper_addsub1: std_logic:='0';

    signal res0: signed(RES_WIDTH-1 downto 0);
begin

    process (clk)
        variable acc: signed(RES_WIDTH-1 downto 0);
    begin
        if rising_edge(clk) then
            oper_load0   <= Oper_Load;
            oper_addsub0 <= Oper_AddSub;

            p1 <= A*B;
            oper_load1   <= oper_load0;
            oper_addsub1 <= oper_addsub0;

            if (oper_load1='1') then
                acc := res0;
            else
                acc := (others=>'0');
            end if;

            if (oper_addsub1='1') then
                res0 <= acc-p1;
            else
                res0 <= acc+p1;
            end if;

        end if;
    end process;

    RES <= res0;
	
end architecture;
