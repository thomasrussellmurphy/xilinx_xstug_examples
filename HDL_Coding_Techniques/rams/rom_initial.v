//
// ROM modelling with a Verilog array and initial block
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rom_initial.v
//
module rom_initial (clk, en, a, do);

    parameter ADDR_WIDTH = 4;
    parameter DATA_WIDTH = 16;
    localparam DEPTH = 1<<ADDR_WIDTH;    

    input                       clk;
    input                       en;
    input      [ADDR_WIDTH-1:0] a;
    output reg [DATA_WIDTH-1:0] do;
    
    reg  [DATA_WIDTH-1:0] rom [DEPTH-1:0];

    initial begin
        rom[0]  = 16'b0011111100000010;
        rom[1]  = 16'b0000000100001001;
        rom[2]  = 16'b0001000000111000;
        rom[3]  = 16'b0000000000000000;
        rom[4]  = 16'b1100001010011000;
        rom[5]  = 16'b0000000000000000;
        rom[6]  = 16'b0000000110000000;
        rom[7]  = 16'b0111111111110000;
        rom[8]  = 16'b0010000010001001;
        rom[9]  = 16'b0101010101011000;
        rom[10] = 16'b1111111010101010;
        rom[11] = 16'b0000000000000000;
        rom[12] = 16'b1110000000001000;
        rom[13] = 16'b0000000110001010;
        rom[14] = 16'b0110011100010000;
        rom[15] = 16'b0000100010000000;
    end 

    always @(posedge clk) begin
        if (en)
            do <= rom[a];
    end


endmodule
