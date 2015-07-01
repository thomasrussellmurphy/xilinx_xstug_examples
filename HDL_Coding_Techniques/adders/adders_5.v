//
// Signed 8-bit Adder
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/adders/adders_5.v
//
module v_adders_5 (A, B, SUM);

    parameter  WIDTH = 8;
    input signed   [WIDTH-1:0] A;
    input signed   [WIDTH-1:0] B;
    output signed  [WIDTH-1:0] SUM;

    assign SUM = A + B;

endmodule
