//
// 4-bit latch with active-high gate
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/latches/latches_4.v
//
module example (G, D, Q);

    input             G;
    input       [3:0] D;
    output reg  [3:0] Q;

    always @(G or D)
    begin
        if (G)
            Q = D;
    end

endmodule
