//
// 4-bit Unsigned Up Accumulator with Synchronous Reset
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/accumulators/accumulators_2.v
//
module v_accumulators_2 (clk, rst, D, Q);

    parameter WIDTH = 4;
    input   clk;
    input   rst;
    input   [WIDTH-1:0] D;
    output  [WIDTH-1:0] Q;
    reg     [WIDTH-1:0] cnt;
    
    always @(posedge clk)
    begin
        if (rst)
            cnt = {WIDTH{1'b0}};
        else
            cnt = cnt + D;
    end
	
    assign Q = cnt;
    
endmodule
