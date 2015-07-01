//
// RAM initialization with and initial block and a for loop in Verilog
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/raminit_02.v
//
module v_raminit_02 (clk, we, a, di, do);

    parameter ADDR_WIDTH = 7;
    parameter DATA_WIDTH = 16;
    localparam DEPTH = 1<<ADDR_WIDTH;    

    input                       clk;
    input                       we;
    input      [ADDR_WIDTH-1:0] a;
    input      [DATA_WIDTH-1:0] di;
    output reg [DATA_WIDTH-1:0] do;
    reg        [DATA_WIDTH-1:0] ram [DEPTH-1:0];

    integer i;
    initial for (i=0; i<DEPTH; i=i+1) ram[i] = 0; 

    always @(posedge clk) begin
        if (we)
            ram[a] <= di;
        do <= ram[a];
    end


endmodule
