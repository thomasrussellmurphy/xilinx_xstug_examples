--
-- Latch with Positive Gate
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/latches/latches_0.vhd
--
library ieee;
use ieee.std_logic_1164.all;

entity latches_0 is
    port(G, D : in std_logic;
         Q : out std_logic);
end latches_0;

architecture archi of latches_0 is
begin

    Q <= D when (G = '1');

end archi;
