//
// Dual-Port RAM with False Synchronous Read
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_10.v
//
module v_rams_10 (clk, we, a, dpra, di, spo, dpo);

    input  clk;
    input  we;
    input  [5:0] a;
    input  [5:0] dpra;
    input  [15:0] di;
    output [15:0] spo;
    output [15:0] dpo;
    reg    [15:0] ram [63:0];
    reg    [15:0] spo;
    reg    [15:0] dpo;

    always @(posedge clk) begin
        if (we)
            ram[a] <= di;

        spo <= ram[a];
        dpo <= ram[dpra];
    end

endmodule
