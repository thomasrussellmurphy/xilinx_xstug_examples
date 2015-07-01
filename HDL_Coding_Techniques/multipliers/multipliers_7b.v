//
// Multiplier Up/Down Accumulate with Register After Multiplication.
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/multipliers/multipliers_7b.v
//
module v_multipliers_7b (clk, reset, add_sub, A, B, RES);

    input  clk, reset, add_sub;
    input  [7:0] A;
    input  [7:0] B;
    output [15:0] RES;
    reg    [15:0] mult, accum;

    always @(posedge clk)
    begin
        if (reset)
            mult <= 16'b0000000000000000;
        else
            mult <= A * B;
    end

    always @(posedge clk)
    begin
        if (reset)
            accum <= 16'b0000000000000000;
        else
            if (add_sub)
                accum <= accum + mult;
            else
                accum <= accum - mult;
    end

    assign RES = accum;

endmodule
