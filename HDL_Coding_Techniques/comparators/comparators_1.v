//
// Unsigned 8-bit Less Than Comparator
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/comparators/comparators_1.v
//
module v_comparators_1 (A, B, CMP);

    parameter  WIDTH = 8;
    input  [WIDTH-1:0] A;
    input  [WIDTH-1:0] B;
    output CMP;

    assign CMP = (A < B) ? 1'b1 : 1'b0;

endmodule
