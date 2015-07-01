--
-- Parallel Complex multiplier
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/dsp/ComplexMult/ComplexMult.vhd
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity ComplexMult is

  port (
    clk      : in  std_logic;
	 A        : in  std_logic_vector(17 downto 0);
    B        : in  std_logic_vector(17 downto 0);
	 C        : in  std_logic_vector(17 downto 0);
	 D        : in  std_logic_vector(17 downto 0);
	 real_out : out std_logic_vector(35 downto 0);
	 imag_out : out std_logic_vector(35 downto 0)
  );

end ComplexMult;

architecture Behavioral of ComplexMult is

   signal A_reg: std_logic_vector(17 downto 0);
	signal B_reg, B_reg2: std_logic_vector(17 downto 0);
	signal C_reg, C_reg2: std_logic_vector(17 downto 0);
	signal D_reg, D_reg2: std_logic_vector(17 downto 0);
		
	signal M1_reg: std_logic_vector(35 downto 0);
   signal M2_reg: std_logic_vector(35 downto 0);
	signal M3_reg: std_logic_vector(35 downto 0);
	signal M4_reg: std_logic_vector(35 downto 0);	

	signal P1_reg: std_logic_vector(35 downto 0);
   signal P2_reg: std_logic_vector(35 downto 0);
	signal P3_reg: std_logic_vector(35 downto 0);
	signal P4_reg: std_logic_vector(35 downto 0);

begin
  
  pipelining : process(clk)
  begin
    if rising_edge(clk) then 
      A_reg <= A;
      B_reg <= B;
      B_reg2 <= B_reg;
      C_reg <= C;
      C_reg2 <= C_reg;
      D_reg <= D;
      D_reg2 <= D_reg;				 
    end if;
  end process pipelining;
							
  DSP_Slices : process(clk)
  begin
    if rising_edge(clk) then 
      M1_reg <= B_reg2 * D_reg2;
		M2_reg <= A_reg * C_reg;
		M3_reg <= B_reg2 * C_reg2;
		M4_reg <= A_reg * D_reg;
   	
		P1_reg <= P2_reg - M1_reg;
		P2_reg <= M2_reg;
		P3_reg <= M3_reg + P4_reg;
      P4_reg <= M4_reg;	 				 
    end if;
  end process DSP_Slices;

  real_out <= P1_reg;
  imag_out <= P3_reg;

end Behavioral;
