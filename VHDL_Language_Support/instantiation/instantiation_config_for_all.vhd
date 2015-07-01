--
-- Component instantiation through basic configuration
--   For all clause
--
-- Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
-- File: VHDL_Language_Support/instantiation/instantiation_config_for_all.vhd
--
entity NAND2 is
    port (
        A,B : in BIT;
        Y : out BIT );
end NAND2;

architecture ARCHI of NAND2 is
begin
    Y <= A nand B;
end ARCHI;

entity HALFADDER is
    port (
        X,Y : in BIT;
        C,S : out BIT );
end HALFADDER;

architecture ARCHI of HALFADDER is
    component NAND2
        port (
            A,B : in BIT;
            Y : out BIT );
    end component;

    for all : NAND2 use entity work.NAND2(ARCHI);

    signal S1, S2, S3 : BIT;
begin
    NANDA : NAND2 port map (X,Y,S3);
    NANDB : NAND2 port map (X,S3,S1);
    NANDC : NAND2 port map (S3,Y,S2);
    NANDD : NAND2 port map (S1,S2,S);
    C <= S3;
end ARCHI;
