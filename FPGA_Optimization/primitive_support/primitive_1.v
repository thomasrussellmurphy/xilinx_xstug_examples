//
// Instantiating a LUT2 primitive
// The INIT value is specified with an attribute, which is rejected by XST
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: FPGA_Optimization/primitive_support/primitive_1.v
//
module v_primitive_1 (I0,I1,O);
    input I0,I1;
    output O;

    (* INIT="1" *)
	 LUT2 inst (.I0(I0), .I1(I1), .O(O));

endmodule
