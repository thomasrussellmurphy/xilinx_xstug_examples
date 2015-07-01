//
// Unsigned 8-bit Subtractor
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/adders/adders_6.v
//
module v_adders_6(A, B, RES);

    parameter  WIDTH = 8;
    input  [WIDTH-1:0] A;
    input  [WIDTH-1:0] B;
    output [WIDTH-1:0] RES;

    assign RES = A - B;

endmodule
