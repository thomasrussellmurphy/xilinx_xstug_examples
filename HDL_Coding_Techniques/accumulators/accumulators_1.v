//
// 4-bit Unsigned Up Accumulator with Asynchronous Reset
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/accumulators/accumulators_1.v
//
module v_accumulators_1 (C, CLR, D, Q);

    parameter WIDTH = 4;
    input   C, CLR;
    input   [WIDTH-1:0] D;
    output  [WIDTH-1:0] Q;
    reg     [WIDTH-1:0] tmp;
    
    always @(posedge C or posedge CLR)
    begin
        if (CLR)
            tmp = {WIDTH{1'b0}};
        else
            tmp = tmp + D;
        end
    assign Q = tmp;
endmodule
