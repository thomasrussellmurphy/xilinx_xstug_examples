//
// 8-bit Shift-Left Register with Positive-Edge Clock, 
// Serial In, and Parallel Out
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/shift_registers/shift_registers_5.v
//
module v_shift_registers_5 (C, SI, PO);

    parameter  WIDTH = 8;
    input   C,SI;
    output  [WIDTH-1:0] PO;
    reg     [WIDTH-1:0] tmp;

    always @(posedge C)

      tmp <= {tmp[WIDTH-2:0], SI};

    assign PO = tmp;

endmodule
