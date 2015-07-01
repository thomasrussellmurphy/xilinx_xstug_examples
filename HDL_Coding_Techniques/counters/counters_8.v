//
// 4-bit Signed Up Counter with Asynchronous Reset and Modulo Maximum
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/counters/counters_8.v
//
module v_counters_8 (C, CLR, Q);
    parameter
        MAX_SQRT = 4,
        MAX = (MAX_SQRT*MAX_SQRT);

    input   C, CLR;
    output [MAX_SQRT-1:0] Q;
    reg    [MAX_SQRT-1:0] cnt;

    always @ (posedge C or posedge CLR)
    begin
        if (CLR)
            cnt <= 0;
        else
            cnt <= (cnt + 1) %MAX;
    end

    assign Q = cnt;

endmodule
