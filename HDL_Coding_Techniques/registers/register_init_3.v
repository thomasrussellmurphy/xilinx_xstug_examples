//
// Initialization of a N-bit register
// Initial value specified in hexadecimal
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/registers/register_init_3.v
//
module v_register_init_3 (C, D, Q);
    input         C;
    input  [15:0] D;
    output [15:0] Q;
    
    reg    [15:0] temp = 16'hFEDC;

    always @(posedge C)
    begin
        temp <= D;
    end

   assign Q = temp;
   
endmodule
