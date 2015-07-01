//
// Flip-Flop with Negative-Edge Clock and Asynchronous Reset
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/registers/registers_2.v
//
module v_registers_2 (C, D, CLR, Q);
    input  C, D, CLR;
    output Q;
    reg    Q;

    always @(negedge C or posedge CLR)
    begin
        if (CLR)
            Q <= 1'b0;
        else
            Q <= D;
    end

endmodule
