--
-- Asymmetric port RAM
--   Port A is 256x8-bit write-only
--   Port B is 64x32-bit read-only
--   Compact description with a for-loop statement
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/asymmetric_ram_1b.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity asymmetric_ram_1b is

  generic (
    WIDTHA      : integer := 8;
    SIZEA       : integer := 256;
    ADDRWIDTHA  : integer := 8;
    WIDTHB      : integer := 32;
    SIZEB       : integer := 64;
    ADDRWIDTHB  : integer := 6
    );

  port (
    clkA   : in  std_logic;
    clkB   : in  std_logic;
    weA    : in  std_logic;
    enA    : in  std_logic;
    enB    : in  std_logic;
    addrA  : in  std_logic_vector(ADDRWIDTHA-1 downto 0);
    addrB  : in  std_logic_vector(ADDRWIDTHB-1 downto 0);
    diA    : in  std_logic_vector(WIDTHA-1 downto 0);
    doB    : out std_logic_vector(WIDTHB-1 downto 0)
    );

end asymmetric_ram_1b;

architecture behavioral of asymmetric_ram_1b is

  function max(L, R: INTEGER) return INTEGER is
  begin
      if L > R then
          return L;
      else
          return R;
      end if;
  end;


  function min(L, R: INTEGER) return INTEGER is
  begin
      if L < R then
          return L;
      else
          return R;
      end if;
  end;

  function log2 (val: INTEGER) return natural is
    variable res : natural;
  begin
        for i in 0 to 31 loop
            if (val <= (2**i)) then
                res := i;
                exit;
            end if;
        end loop;
        return res;
  end function Log2;

  constant minWIDTH : integer := min(WIDTHA,WIDTHB);
  constant maxWIDTH : integer := max(WIDTHA,WIDTHB);
  constant maxSIZE  : integer := max(SIZEA,SIZEB);
  constant RATIO : integer := maxWIDTH / minWIDTH;

  type ramType is array (0 to maxSIZE-1) of std_logic_vector(minWIDTH-1 downto 0);
  signal ram : ramType := (others => (others => '0'));
  
  signal readB : std_logic_vector(WIDTHB-1 downto 0):= (others => '0');
  signal regB  : std_logic_vector(WIDTHB-1 downto 0):= (others => '0');

begin

  process (clkA)
  begin
    if rising_edge(clkA) then
      if enA = '1' then
        if weA = '1' then
          ram(conv_integer(addrA)) <= diA;
        end if;
      end if;
    end if;

  end process;

  process (clkB)
  begin
    if rising_edge(clkB) then
      if enB = '1' then        
        for i in 0 to RATIO-1 loop
          readB((i+1)*minWIDTH-1 downto i*minWIDTH)
	    <= ram(conv_integer(addrB & conv_std_logic_vector(i,log2(RATIO))));
        end loop;
      end if;
      regB <= readB;
    end if;
  end process;

  doB <= regB;
  
end behavioral;
