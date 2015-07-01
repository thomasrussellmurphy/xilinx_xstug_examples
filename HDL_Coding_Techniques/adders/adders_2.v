//
// Unsigned 8-bit Adder with Carry In
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/adders/adders_2.v
//
module v_adders_2 (A, B, CI, SUM);

    parameter  WIDTH = 8;
    input   [WIDTH-1:0]  A;
    input   [WIDTH-1:0]  B;
    input                CI;
    output  [WIDTH-1:0] SUM;

    assign SUM = A + B + CI;

endmodule
