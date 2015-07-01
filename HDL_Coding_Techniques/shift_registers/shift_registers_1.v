//
// 8-bit Shift Register
//     Rising edge clock
//     Active high clock enable
//     For-loop based template
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/shift_registers/shift_registers_1.v
//
module v_shift_registers_1 (clk, clken, SI, SO);

    parameter  WIDTH = 8;
    input   clk, clken, SI;
    output  SO;
    reg     [WIDTH-1:0] shreg;

    integer i;

    always @(posedge clk)
    begin
        if (clken)
	begin
	    for (i = 0; i < WIDTH-1; i = i+1)
                shreg[i+1] <= shreg[i];
            shreg[0] <= SI;
        end
    end

    assign SO = shreg[WIDTH-1];

endmodule
