//
// Unsigned 8-bit Adder with Carry In and Carry Out
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/adders/adders_4.v
//
module v_adders_4(A, B, CI, SUM, CO);

    parameter  WIDTH = 8;
    input   [WIDTH-1:0] A;
    input   [WIDTH-1:0] B;
    input               CI;
    output  [WIDTH-1:0] SUM;
    output              CO;
    wire    [WIDTH:0]   tmp;

    assign tmp = A + B + CI;
    assign SUM = tmp [WIDTH-1:0];
    assign CO  = tmp [WIDTH];

endmodule
