//
// Initialization of a N-bit register
// Initial value specified in binary
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/registers/register_init_2.v
//
module v_register_init_2 (C, D, Q);
    input         C;
    input  [15:0] D;
    output [15:0] Q;
    
    reg    [15:0] temp = 16'b1111111011011100;

    always @(posedge C)
    begin
        temp <= D;
    end

   assign Q = temp;
   
endmodule
