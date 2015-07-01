//
// Initializing Block RAM from an external data file
// Hexadecimal data
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_20d.v
//
module v_rams_20d (clk, we, addr, din, dout); 
    input  clk; 
    input  we; 
    input  [5:0] addr; 
    input  [31:0] din; 
    output [31:0] dout; 

    reg [31:0] ram [0:63]; 
    reg [31:0] dout;

    initial
    begin
        $readmemh("rams_20d.data", ram);
    end

    always @(posedge clk) 
    begin 
        if (we) 
            ram[addr] <= din; 
        dout <= ram[addr];
    end
   
endmodule
