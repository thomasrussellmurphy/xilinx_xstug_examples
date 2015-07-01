//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/multipliers/multipliers_8.v
//
module v_multipliers_8(CLK,A,B,Oper_Load,Oper_AddSub, RES);
    parameter A_WIDTH   = 18;
    parameter B_WIDTH   = 18;
    parameter RES_WIDTH = 48;
    parameter P_WIDTH   = A_WIDTH+B_WIDTH;

    input  CLK;
    input  signed [A_WIDTH-1:0] A, B;

    input  Oper_Load, Oper_AddSub;
    //  Oper_Load  Oper_AddSub  Operation
    //  0          0            R= +A*B   
    //  0          1            R= -A*B   
    //  1          0            R=R+A*B   
    //  1          1            R=R-A*B   

    output [RES_WIDTH-1:0] RES;

    reg oper_load0   = 0;
    reg oper_addsub0 = 0;

    reg signed [P_WIDTH-1:0] p1 = 0;
    reg oper_load1   = 0;
    reg oper_addsub1 = 0;

    reg signed [RES_WIDTH-1:0] res0  = 0;
    reg signed [RES_WIDTH-1:0] acc;

    always @(posedge CLK)
    begin
        oper_load0   <= Oper_Load;
        oper_addsub0 <= Oper_AddSub;

        p1 <= A*B;
        oper_load1   <= oper_load0;
        oper_addsub1 <= oper_addsub0;

        if (oper_load1==1'b1)
            acc = res0;
        else
            acc = 0;

        if (oper_addsub1==1'b1)
            res0 <= acc-p1;
        else
            res0 <= acc+p1;

    end

    assign RES = res0;

endmodule
