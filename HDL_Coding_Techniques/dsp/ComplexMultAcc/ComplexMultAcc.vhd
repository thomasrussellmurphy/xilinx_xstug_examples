--
-- Complex multiply-accumulate
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/dsp/ComplexMultAcc/ComplexMultAcc.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity ComplexMultAcc is
  generic (
    DATA_WIDTH  : integer := 18;  -- Data input width 
	COEFF_WIDTH : integer := 16;  -- Coefficient width
	ACCUM_WIDTH : integer := 4);  -- Width of accumulated data
  port (
    clk       : in  std_logic;					
    clk_accum : in  std_logic;		-- output clock, result is outputted after accumulation of n clocks. This is set in testbench as 10 for this example
	rst       : in  std_logic;
    a         : in  std_logic_vector (DATA_WIDTH-1 downto 0);	-- first input real part
    b         : in  std_logic_vector (DATA_WIDTH-1 downto 0);  -- first input imaginary part
    x         : in  std_logic_vector (COEFF_WIDTH-1 downto 0);	-- second input real part
    y         : in  std_logic_vector (COEFF_WIDTH-1 downto 0);	-- second input imaginary part
	outp_i    : out std_logic_vector (COEFF_WIDTH+DATA_WIDTH+ACCUM_WIDTH-1 downto 0);   -- output real part
	outp_q    : out std_logic_vector (COEFF_WIDTH+DATA_WIDTH+ACCUM_WIDTH-1 downto 0));  -- output imaginary part
end ComplexMultAcc;

architecture behavioral of ComplexMultAcc is

  signal accum_ax, accum_bx, accum_ay, accum_by: std_logic_vector (COEFF_WIDTH+DATA_WIDTH+ACCUM_WIDTH-1 downto 0);
  signal mult_ax, mult_bx, mult_ay, mult_by: std_logic_vector (COEFF_WIDTH+DATA_WIDTH-1 downto 0);
  
begin

  -- process to generate input product as well as partial accumulation.
  -- Assume the complex multiplication is in the form of (a+jb)*(x+jy) = (ax - by)+j(ay + bx)
  process (clk)
  begin
	 if rising_edge(clk) then
		if (rst = '1') then
			accum_ax <= (others => '0');
			mult_ax <= (others => '0');
			accum_bx <= (others => '0');
			mult_bx <= (others => '0');
			accum_ay <= (others => '0');
			mult_ay <= (others => '0');
			accum_by <= (others => '0');
			mult_by <= (others => '0');
		else
			accum_ax <= accum_ax + mult_ax;
			mult_ax <= a * x;
			accum_bx <= accum_bx + mult_bx;
			mult_bx <= b * x;
			accum_ay <= accum_ay + mult_ay;
			mult_ay <= a * y;
			accum_by <= accum_by + mult_by;
			mult_by <= b * y;
			end if;
	 end if;
  end process;

  -- process to add all partial accumulation results at every clock cycle (clk) to generate the final output real and imaginary 
  -- part at every few cycles (clk_accum). The periof of clk_accum can be set in testbench.
  process (clk)
  begin
	 if rising_edge(clk) then
	   if (clk_accum = '1') then
		  if (rst = '1') then
			 outp_i <= (others => '0');
			 outp_q <= (others => '0');
		  else
			  outp_i <= accum_ax - accum_by;
			  outp_q <= accum_ay + accum_bx;
		  end if;
	   end if;
	 end if;
  end process;

end behavioral;

