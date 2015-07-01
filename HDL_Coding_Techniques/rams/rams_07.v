//
// Single-Port RAM with Synchronous Read (Read Through)
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_07.v
//
module v_rams_07 (clk, we, a, di, do);

    input  clk;
    input  we;
    input  [5:0] a;
    input  [15:0] di;
    output [15:0] do;
    reg    [15:0] ram [63:0];
    reg    [5:0] read_a;

    always @(posedge clk) begin
        if (we)
            ram[a] <= di;
        read_a <= a;
    end

    assign do = ram[read_a];

endmodule
