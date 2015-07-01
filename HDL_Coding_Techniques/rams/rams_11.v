//
// Dual-Port BRAM Write-First Mode (registered read address template)
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_11.v
//
module v_rams_11 (clk, we, a, dpra, di, spo, dpo);

    input  clk;
    input  we;
    input  [6:0] a;
    input  [6:0] dpra;
    input  [15:0] di;
    output [15:0] spo;
    output [15:0] dpo;
    
    reg    [15:0] ram [127:0];
    reg    [6:0] read_a;
    reg    [6:0] read_dpra;

    always @(posedge clk) begin
        if (we)
            ram[a] <= di;
        read_a <= a;
        read_dpra <= dpra;
    end

    assign spo = ram[read_a];
    assign dpo = ram[read_dpra];

endmodule
