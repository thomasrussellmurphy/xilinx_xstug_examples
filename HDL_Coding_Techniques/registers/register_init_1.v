//
// Initialization of a 1-bit register
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/registers/register_init_1.v
//
module v_register_init_1 (C, D, Q);
    input  C;
    input  D;
    output Q;
    
    reg    temp = 'b1;

    always @(posedge C)
    begin
        temp <= D;
    end

   assign Q = temp;
   
endmodule
