//
// Single-Port RAM with "False" Synchronous Read
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_05.v
//
module v_rams_05 (clk, we, a, di, do);

    input  clk;
    input  we;
    input  [5:0] a;
    input  [15:0] di;
    output [15:0] do;
    reg    [15:0] ram [63:0];
    reg    [15:0] do;

    always @(posedge clk) begin
        if (we)
            ram[a] <= di;
        do <= ram[a];
    end

endmodule
