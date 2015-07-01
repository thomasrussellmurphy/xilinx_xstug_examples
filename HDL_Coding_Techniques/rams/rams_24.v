//
// Single-Port BRAM with Byte-wide Write Enable (2 bytes) in Read-First Mode
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_24.v
//
module v_rams_24 (clk, we, addr, di, do);

    parameter SIZE       = 512;
    parameter ADDR_WIDTH = 9;
    parameter DI_WIDTH   = 8;

    input  clk;
    input  [1:0] we;
    input  [ADDR_WIDTH-1:0] addr;
    input  [2*DI_WIDTH-1:0] di;
    output [2*DI_WIDTH-1:0] do;
    reg    [2*DI_WIDTH-1:0] RAM [SIZE-1:0];
    reg    [2*DI_WIDTH-1:0] do;

    reg    [DI_WIDTH-1:0]   di0, di1;
    
    always @(we or di)
    begin
        if (we[1]) 
            di1 = di[2*DI_WIDTH-1:1*DI_WIDTH];
        else       
            di1 = RAM[addr][2*DI_WIDTH-1:1*DI_WIDTH];

        if (we[0]) 
            di0 = di[DI_WIDTH-1:0];
        else       
            di0 = RAM[addr][DI_WIDTH-1:0];

    end
    
    always @(posedge clk)
    begin
        do <= RAM[addr];
        RAM[addr]<={di1,di0};
    end

endmodule
