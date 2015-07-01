//
// Unsigned 32x32-bit Multiplier
//     1 latency stage on operands
//     6 latency stage after the multiplication
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/multipliers/multipliers_12.v
//
module v_multipliers_12 (clk, A, B, RES);
    input             clk;
    input      [31:0] A;
    input      [31:0] B;
    output     [63:0] RES;
    
    reg        [31:0] rA;
    reg        [31:0] rB;
    reg        [63:0] M [5:0];
    
    integer i;
    
    always @(posedge clk)
    begin
        rA <= A;
	rB <= B;
	M[0] <= rA * rB;
	for (i = 0; i < 5; i = i+1)
	  M[i+1] <= M[i];
    end

    assign RES = M[5];
    
endmodule
