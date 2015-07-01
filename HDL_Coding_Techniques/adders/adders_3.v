//
// Unsigned 8-bit Adder with Carry Out
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/adders/adders_3.v
//
module v_adders_3 (A, B, SUM, CO);

    parameter  WIDTH = 8;
    input   [WIDTH-1:0] A;
    input   [WIDTH-1:0] B;
    output  [WIDTH-1:0] SUM;
    output              CO;
    wire    [WIDTH:0]   tmp;

    assign tmp = A + B;
    assign SUM = tmp [WIDTH-1:0];
    assign CO  = tmp [WIDTH];

endmodule
