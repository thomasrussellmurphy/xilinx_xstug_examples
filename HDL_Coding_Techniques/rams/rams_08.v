//
// Single-Port RAM with Enable
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_08.v
//
module v_rams_08 (clk, en, we, a, di, do);

    input  clk;
    input  en;
    input  we;
    input  [5:0] a;
    input  [15:0] di;
    output [15:0] do;
    reg    [15:0] ram [63:0];
    reg    [5:0] read_a;

    always @(posedge clk) begin
        if (en)
        begin
            if (we)
                ram[a] <= di;
            read_a <= a;
        end
    end

    assign do = ram[read_a];

endmodule
