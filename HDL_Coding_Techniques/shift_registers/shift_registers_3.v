//
// 8-bit Shift-Left Register with Positive-Edge Clock, 
// Asynchronous Reset, Serial In, and Serial Out
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/shift_registers/shift_registers_3.v
//
module v_shift_registers_3 (C, CLR, SI, SO);

    parameter  WIDTH = 8;
    input   C,SI,CLR;
    output  SO;
    reg     [WIDTH-1:0] tmp;

    always @(posedge C or posedge CLR)
    begin
        if (CLR)
            tmp <= {WIDTH{1'b0}};
        else
            tmp <= {tmp[WIDTH-2:0], SI};
    end

    assign SO = tmp[WIDTH-1];

endmodule
