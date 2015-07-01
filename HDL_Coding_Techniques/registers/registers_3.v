//
// Flip-Flop with Positive-Edge Clock and Synchronous Set
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/registers/registers_3.v
//
module v_registers_3 (C, D, S, Q);
    input  C, D, S;
    output Q;
    reg    Q;

    always @(posedge C)
    begin
        if (S)
            Q <= 1'b1;
        else
            Q <= D;
        end

endmodule
