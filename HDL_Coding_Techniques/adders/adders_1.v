//
// Unsigned 8-bit Adder
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/adders/adders_1.v
//
module v_adders_1(A, B, SUM);

    parameter  WIDTH = 8;
    input  [WIDTH-1:0] A;
    input  [WIDTH-1:0] B;
    output [WIDTH-1:0] SUM;

    assign SUM = A + B;
    
endmodule
