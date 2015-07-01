//
// Multiple-Port RAM Descriptions
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_17.v
//
module v_rams_17 (clk, we, wa, ra1, ra2, di, do1, do2);

    input  clk;
    input  we;
    input  [5:0] wa;
    input  [5:0] ra1;
    input  [5:0] ra2;
    input  [15:0] di;
    output [15:0] do1;
    output [15:0] do2;
    reg    [15:0] ram [63:0];

    always @(posedge clk)
    begin
        if (we)
            ram[wa] <= di;
    end

    assign do1 = ram[ra1];
    assign do2 = ram[ra2];

endmodule
