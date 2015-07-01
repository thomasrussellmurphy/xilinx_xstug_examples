--
-- Mapping of Logic to LUTs with the LUT_MAP constraint
-- Mapped to 2 distinct LUT2s
-- Mapped to 1 single LUT3 if LUT_MAP constraints are removed
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: FPGA_Optimization/lut_mapping/lut_map_1.vhd
--

library ieee;
use ieee.std_logic_1164.all;
entity and_one is
    port (A, B : in std_logic;
          REZ : out std_logic);

    attribute LUT_MAP: string;
    attribute LUT_MAP of and_one: entity is "yes";
end and_one;

architecture beh of and_one is
begin
    REZ <= A and B;
end beh;

--------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity and_two is
    port(A, B : in std_logic;
         REZ : out std_logic);

    attribute LUT_MAP: string;
    attribute LUT_MAP of and_two: entity is "yes";
end and_two;

architecture beh of and_two is
begin
    REZ <= A or B;
end beh;

--------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity lut_map_1 is
    port(A,B,C : in std_logic;
         REZ : out std_logic);
end lut_map_1;

architecture beh of lut_map_1 is

    component and_one
    port(A, B : in std_logic;
         REZ : out std_logic);
    end component;

    component and_two
    port(A, B : in std_logic;
         REZ : out std_logic);
    end component;

signal tmp: std_logic;
begin
    inst_and_one: and_one port map (A => A, B => B, REZ => tmp);
    inst_and_two: and_two port map (A => tmp, B => C, REZ => REZ);
end beh;
