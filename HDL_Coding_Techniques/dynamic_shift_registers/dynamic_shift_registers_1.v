//
// 32-bit dynamic shift register.
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/dynamic_shift_registers/dynamic_shift_registers_1.v
//
module v_dynamic_shift_registers_1 (CLK, CE, SEL, SI, DO);

    parameter  SELWIDTH = 5;   
    input    CLK, CE, SI;
    input    [SELWIDTH-1:0] SEL;
    output   DO;

    localparam  DATAWIDTH = 2**SELWIDTH;   
    reg [DATAWIDTH-1:0] data;

    assign DO = data[SEL];

    always @(posedge CLK)
    begin
        if (CE == 1'b1)
            data <= {data[DATAWIDTH-2:0], SI};
    end

endmodule
