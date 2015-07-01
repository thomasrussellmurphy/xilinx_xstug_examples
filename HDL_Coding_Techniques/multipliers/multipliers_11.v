//
// Unsigned 32x24-bit Multiplier
//     1 latency stage on operands
//     3 latency stage after the multiplication
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/multipliers/multipliers_11.v
//
module v_multipliers_11 (clk, A, B, RES);

    parameter  WIDTHA = 32;
    parameter  WIDTHB = 24;
    input                        clk;
    input   [WIDTHA-1:0]         A;
    input   [WIDTHB-1:0]         B;    
    output  [WIDTHA+WIDTHB-1:0]  RES;
      
    reg     [WIDTHA-1:0]         rA;
    reg     [WIDTHB-1:0]         rB;
    reg     [WIDTHA+WIDTHB-1:0]  M  [3:0];   
    integer i;

    always @(posedge clk)
    begin
        rA <= A;
	rB <= B;
        M[0] <= rA * rB;
	for (i = 0; i < 3; i = i+1)
	  M[i+1] <= M[i];
    end 
    assign RES = M[3];
      
endmodule
