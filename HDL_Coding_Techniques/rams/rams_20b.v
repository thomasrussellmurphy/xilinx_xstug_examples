//
// RAM initial contents described in the Verilog source code
// Specific address positions or ranges initialized to particular values
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_20b.v
//
module v_rams_20b (clk1, clk2, we, addr1, addr2, di, do1, do2); 
    input  clk1, clk2; 
    input  we; 
    input  [7:0]  addr1, addr2; 
    input  [15:0] di; 
    output [15:0] do1, do2; 

    reg [15:0] ram [255:0]; 
    reg [15:0] do1, do2;
    integer index;

    initial begin
        for (index = 0 ; index <= 97 ; index = index + 1)
            ram[index] = 16'h8282;
        ram[98] = 16'h1111;
        ram[99] = 16'h7778;
        for (index = 100 ; index <= 255 ; index = index + 1)
            ram[index] = 16'hB8B8;
    end

    always @(posedge clk1) 
    begin 
        if (we) 
            ram[addr1] <= di; 
        do1 <= ram[addr1];
    end

    always @(posedge clk2) 
    begin 
        do2 <= ram[addr2];
    end
   
endmodule
