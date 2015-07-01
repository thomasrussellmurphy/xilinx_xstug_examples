//
// 4-bit unsigned down counter with a synchronous load.
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/counters/counters_31.v
//
module v_counters_31 (clk, load, Q);

    parameter  WIDTH = 4;
    input   clk;
    input   load;
    output  [WIDTH-1:0] Q;
    reg     [WIDTH-1:0] cnt;

    always @(posedge clk)
    begin
        if (load)
            cnt <= {WIDTH{1'b1}};
        else
            cnt <= cnt - 1'b1;
    end

    assign Q = cnt;
    
endmodule
