//
// Quad-Port Distibuted RAM
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_23.v
//
module v_rams_23 (clk, weA, addrA, addrB, addrC, addrD, 
                       diA, doA, doB, doC, doD);

                       
                       
    input  clk;
    input  weA;
    input  [5:0]  addrA, addrB, addrC, addrD;
    input  [15:0] diA;
    output [15:0] doA, doB, doC, doD;
    reg    [15:0] RAM [63:0];

    always @(posedge clk)
    begin
        if (weA)
          RAM[addrA] <= diA;
    end

    assign doA = RAM[addrA];
    assign doB = RAM[addrB];
    assign doC = RAM[addrC];
    assign doD = RAM[addrD];

endmodule
