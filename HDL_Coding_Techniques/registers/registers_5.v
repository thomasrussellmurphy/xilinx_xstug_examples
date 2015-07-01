//
// 4-bit Register with Positive-Edge Clock, Asynchronous Set and Clock Enable
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/registers/registers_5.v
//
module v_registers_5 (C, D, CE, PRE, Q);
    input  C, CE, PRE;
    input  [3:0] D;
    output [3:0] Q;
    reg    [3:0] Q;

    always @(posedge C or posedge PRE)
    begin
        if (PRE)
            Q <= 4'b1111;
        else
            if (CE)
                Q <= D;
    end

endmodule
