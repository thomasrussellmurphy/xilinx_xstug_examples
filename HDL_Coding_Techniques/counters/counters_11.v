//
// 4-bit unsigned up counter with a synchronous reset.
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/counters/counters_11.v
//
module v_counters_11 (clk, rst, Q);

    input         clk;
    input         rst;
    output  [3:0] Q;
    reg     [3:0] cnt;

    always @(posedge clk)
    begin
        if (rst)
            cnt <= 4'b0000;
        else
            cnt <= cnt + 1'b1;
    end

    assign Q = cnt;
    
endmodule
