//
// Dual-Port BRAM Write-First (registered read address template)
// Distinct Clocks
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_12.v
//
module v_rams_12 (clk1, clk2, we, add1, add2, di, do1, do2);

    input  clk1;
    input  clk2;
    input  we;
    input  [6:0] add1;
    input  [6:0] add2;
    input  [15:0] di;
    output [15:0] do1;
    output [15:0] do2;
    
    reg    [15:0] ram [127:0];
    reg    [6:0] read_add1;
    reg    [6:0] read_add2;

    always @(posedge clk1) begin
        if (we)
            ram[add1] <= di;
        read_add1 <= add1;
    end

    assign do1 = ram[read_add1];

    always @(posedge clk2) begin
        read_add2 <= add2;
    end

    assign do2 = ram[read_add2];

endmodule
