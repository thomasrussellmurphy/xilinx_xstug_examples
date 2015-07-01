--
-- Instantiating a LUT2 primitive
-- The INIT value is specified with an attribute, which is rejected by XST
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: FPGA_Optimization/primitive_support/primitive_1.vhd
--
library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity primitive_1 is
    port(I0,I1 : in std_logic;
         O     : out std_logic);
end primitive_1;

architecture beh of primitive_1 is

    attribute INIT: string;
    attribute INIT of inst: label is "1";

begin

    inst: LUT2
      port map (I0=>I0, I1=>I1, O=>O);

end beh;
