//
// Pipelined multiplier
//    The multiplication operation placed outside the
//    always block and the pipeline stages represented 
//    as shift registers.
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/multipliers/multipliers_4.v
//

(*mult_style="pipe_lut"*)
module v_multipliers_4(clk, A, B, MULT);

    input clk;
    input [17:0] A;
    input [17:0] B;
    output [35:0] MULT;
    reg [35:0] MULT;
    reg [17:0] a_in, b_in;
    wire [35:0] mult_res;
    reg [35:0] pipe_regs [2:0];
    integer i;
    
    assign mult_res = a_in * b_in;
    
    always @(posedge clk)
    begin
        a_in <= A; b_in <= B;

        pipe_regs[2] <= mult_res;       
        for (i=0; i<=1; i=i+1) pipe_regs[i] <= pipe_regs[i+1];

        MULT <= pipe_regs[0];
    end
    
endmodule
