//
// Dual-Port Block RAM with Different Clocks
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_15.v
//
module v_rams_15 (clka, clkb, wea, addra, addrb, dia, doa, dob);

    input  clka;
    input  clkb;
    input  wea;
    input  [5:0] addra;
    input  [5:0] addrb;
    input  [15:0] dia;
    output [15:0] doa;
    output [15:0] dob;
    reg    [15:0] RAM [63:0];
    reg    [5:0] read_addra;
    reg    [5:0] read_addrb;

    always @(posedge clka)
    begin
        if (wea == 1'b1)
            RAM[addra] <= dia;
        read_addra <= addra;
    end

    always @(posedge clkb)
    begin
        read_addrb <= addrb;
    end

    assign doa = RAM[read_addra];
    assign dob = RAM[read_addrb];

endmodule
