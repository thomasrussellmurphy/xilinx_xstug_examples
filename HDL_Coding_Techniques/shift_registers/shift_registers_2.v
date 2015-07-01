//
// 8-bit Shift-Left Register with Negative-Edge Clock, Clock Enable, 
// Serial In, and Serial Out
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/shift_registers/shift_registers_2.v
//
module v_shift_registers_2 (C, CE, SI, SO);
    parameter  WIDTH = 8;
    input   C,SI, CE;
    output  SO;
    reg     [WIDTH-1:0] tmp;

    always @(negedge C)
    begin
        if (CE)
        begin
            tmp = {tmp[WIDTH-2:0], SI};
        end
    end

    assign SO = tmp[WIDTH-1];

endmodule
