//
// Single-Port BRAM with Byte-wide Write Enable
//   4x9-bit write
//   Read-First mode
//   Single-process description
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/bytewrite_ram_1a.v
//
module v_bytewrite_ram_1a (clk, we, addr, di, do);

    parameter SIZE        = 1024;
    parameter ADDR_WIDTH  = 10;
    parameter COL_WIDTH   = 9;
    parameter NB_COL      = 4;

    input                              clk;
    input      [NB_COL-1:0]            we;
    input      [ADDR_WIDTH-1:0]        addr;
    input      [NB_COL*COL_WIDTH-1:0]  di;
    output reg [NB_COL*COL_WIDTH-1:0]  do;
    
    reg        [NB_COL*COL_WIDTH-1:0]  RAM [SIZE-1:0];
    
    always @(posedge clk)
    begin
        do <= RAM[addr];
        if (we[3]) 
            RAM[addr][4*COL_WIDTH-1:3*COL_WIDTH] <= di[4*COL_WIDTH-1:3*COL_WIDTH];
        if (we[2]) 
            RAM[addr][3*COL_WIDTH-1:2*COL_WIDTH] <= di[3*COL_WIDTH-1:2*COL_WIDTH];
        if (we[1]) 
            RAM[addr][2*COL_WIDTH-1:1*COL_WIDTH] <= di[2*COL_WIDTH-1:1*COL_WIDTH];
        if (we[0]) 
            RAM[addr][COL_WIDTH-1:0] <= di[COL_WIDTH-1:0];
    end
    
endmodule
