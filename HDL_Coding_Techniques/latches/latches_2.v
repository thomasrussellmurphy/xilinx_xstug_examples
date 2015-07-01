//
// Latch with Positive Gate and Asynchronous Reset
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/latches/latches_2.v
//
module v_latches_2 (G, D, CLR, Q);
    input G, D, CLR;
    output Q;
    reg Q;
    
    always @(G or D or CLR)
    begin
        if (CLR)
            Q = 1'b0;
        else if (G)
            Q = D;
    end
endmodule
