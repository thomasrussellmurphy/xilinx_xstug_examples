//
// Single-Port RAM with "False" Synchronous Read with
// an additional reset of the RAM output,
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_06.v
//
module v_rams_06 (clk, we, rst, a, di, do);

    input  clk;
    input  we;
    input  rst;
    input  [5:0] a;
    input  [15:0] di;
    output [15:0] do;
    reg    [15:0] ram [63:0];
    reg    [15:0] do;

    always @(posedge clk) begin
        if (we)
            ram[a] <= di;

        if (rst)
            do <= 4'b0;
        else
            do <= ram[a];
    end

endmodule
