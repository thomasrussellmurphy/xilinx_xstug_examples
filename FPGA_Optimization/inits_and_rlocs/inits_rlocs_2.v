//
// Specification on an INIT value for a flip-flop, 
// described at RTL level
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: FPGA_Optimization/inits_and_rlocs/inits_rlocs_2.v
//
module v_inits_rlocs_2 (clk, di, do);
    input  clk;
    input  [3:0] di;
    output [3:0] do;
    reg    [3:0] tmp;

    initial begin
        tmp = 4'b1011;
    end

    always @(posedge clk)
    begin
        tmp <= di; 
    end

    assign do = tmp;

endmodule
