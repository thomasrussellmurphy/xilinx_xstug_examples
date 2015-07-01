//
// Unsigned 8x4-bit Multiplier
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/multipliers/multipliers_1.v
//
module v_multipliers_1(A, B, RES);

    parameter  WIDTHA = 8;
    parameter  WIDTHB = 4;
    input   [WIDTHA-1:0]         A;
    input   [WIDTHB-1:0]         B;
    output  [WIDTHA+WIDTHB-1:0]  RES;
    
    assign RES = A * B;
endmodule
