//
// A constant divided by another. None is a power of 2.
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/dividers/dividers_2.v
//
module v_divider_2 (DO);
    output [7:0] DO;

    assign DO = 9 / 3;

endmodule
