//
// Specification on an INIT and RLOC values for a flip-flop, 
// described at RTL level
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: FPGA_Optimization/inits_and_rlocs/inits_rlocs_3.v
//
module v_inits_rlocs_3 (clk, di, do);
    input  clk;
    input  [3:0] di;
    output [3:0] do;
    (* RLOC="X3Y0 X2Y0 X1Y0 X0Y0" *)
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
