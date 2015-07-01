//
// Single-Port BRAM with Byte-wide Write Enable (2 bytes) in Write-First Mode
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_25.v
//
module v_rams_25 (clk, we, addr, di, do);

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
    reg    [DI_WIDTH-1:0]   do0, do1;
    
    always @(we or di or addr or RAM)
    begin
        if (we[1]) 
            begin
                di1 = di[2*DI_WIDTH-1:1*DI_WIDTH];
                do1 = di[2*DI_WIDTH-1:1*DI_WIDTH];
            end
        else
            begin
                di1 = RAM[addr][2*DI_WIDTH-1:1*DI_WIDTH];
                do1 = RAM[addr][2*DI_WIDTH-1:1*DI_WIDTH];
            end

        if (we[0]) 
            begin
                di0 <= di[DI_WIDTH-1:0];
                do0 <= di[DI_WIDTH-1:0];
            end
        else
            begin
                di0 <= RAM[addr][DI_WIDTH-1:0];
                do0 <= RAM[addr][DI_WIDTH-1:0];
            end

    end
    
    always @(posedge clk)
    begin
        do <= {do1,do0};
        RAM[addr]<={di1,di0};
    end

endmodule
