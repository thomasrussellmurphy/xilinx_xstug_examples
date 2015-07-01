//
// 8-bit Shift-Left Register with Positive-Edge Clock, Synchronous Set, 
// Serial In, and Serial Out
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/shift_registers/shift_registers_4.v
//
module v_shift_registers_4 (C, S, SI, SO);

    parameter  WIDTH = 8;
    input C,SI,S;
    output SO;
    reg [WIDTH-1:0] tmp;

    always @(posedge C)
    begin
        if (S)
            tmp <= {WIDTH{1'b1}};
        else
            tmp <= {tmp[WIDTH-2:0], SI};
    end

    assign SO = tmp[WIDTH-1];

endmodule
