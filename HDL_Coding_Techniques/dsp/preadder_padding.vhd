--
-- Explicit padding of pre-adder operands 
-- 
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/dsp/preadder_padding.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity preadder_padding is

  generic (
    DATA_WIDTH  : integer := 16
  );
  port (
    clk  : in  std_logic;
    a    : in  signed(DATA_WIDTH-1 downto 0);
    b    : in  signed(DATA_WIDTH-1 downto 0);
    c    : in  signed(DATA_WIDTH-1 downto 0);
    d    : in  signed(2*DATA_WIDTH-1 downto 0);
    o    : out signed(2*DATA_WIDTH-1 downto 0)
  );
	
end preadder_padding;

architecture behavioral of preadder_padding is

  constant PREADD_WIDTH : integer := 18;
  signal a_resized : signed(PREADD_WIDTH-1 downto 0);
  signal b_resized : signed(PREADD_WIDTH-1 downto 0);
  signal pre       : signed(PREADD_WIDTH-1 downto 0);
  signal m         : signed(DATA_WIDTH+PREADD_WIDTH-1 downto 0);
  signal p         : signed(DATA_WIDTH+PREADD_WIDTH-1 downto 0);

begin

  assert DATA_WIDTH <= PREADD_WIDTH report "DATA_WIDTH exceeds limit of 18 bits" severity ERROR;
 
  a_resized <= RESIZE(a, PREADD_WIDTH);
  b_resized <= RESIZE(b, PREADD_WIDTH);

  process (clk)
  begin
    if rising_edge(clk) then
      pre <= a_resized + b_resized;
      m <= pre * c;
      p <= m + d;
    end if;
  end process;
  
  o <= RESIZE(p, 2*DATA_WIDTH);

end behavioral;
