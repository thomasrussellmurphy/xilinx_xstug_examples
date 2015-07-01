//
// 4-bit Unsigned Up/Down counter with Asynchronous Reset
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/counters/counters_6.v
//
module v_counters_6 (C, CLR, UP_DOWN, Q);
    input C, CLR, UP_DOWN;
    output [3:0] Q;
    reg [3:0] tmp;

    always @(posedge C or posedge CLR)
    begin
        if (CLR)
            tmp <= 4'b0000;
        else if (UP_DOWN)
                tmp <= tmp + 1'b1;
            else
                tmp <= tmp - 1'b1;
    end

    assign Q = tmp;

endmodule
