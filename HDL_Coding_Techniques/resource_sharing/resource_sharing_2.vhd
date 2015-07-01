--
-- Resource Sharing of multipliers
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/resource_sharing/resource_sharing_2.vhd
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity resource_sharing_2 is

    port(
        A, B, C, D : in  std_logic_vector(7 downto 0);
        OPER  : in  std_logic;
        RES   : out std_logic_vector(15 downto 0));
	 
end resource_sharing_2;

architecture archi of resource_sharing_2 is
begin

    RES <= A * B when OPER='0' else C * D;

end archi;
