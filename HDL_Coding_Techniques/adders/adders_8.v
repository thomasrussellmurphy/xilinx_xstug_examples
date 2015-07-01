//
// Unsigned 8-bit Subtractor with Borrow In
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/adders/adders_8.v
//
module v_adders_8(A, B, BI, RES);

    parameter  WIDTH = 8;
    input   [WIDTH-1:0] A;
    input   [WIDTH-1:0] B;
    input               BI;
    output  [WIDTH-1:0] RES;

    assign RES = A - B - BI;
	  
endmodule
