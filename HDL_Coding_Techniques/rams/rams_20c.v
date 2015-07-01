//
// Initializing Block RAM from external data file
// Binary data
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_20c.v
//
module v_rams_20c (clk, we, addr, din, dout); 
    input  clk; 
    input  we; 
    input  [5:0] addr; 
    input  [31:0] din; 
    output [31:0] dout; 

    reg [31:0] ram [0:63]; 
    reg [31:0] dout;

    initial
    begin
        // $readmemb("rams_20c.data",ram, 0, 63);
        $readmemb("rams_20c.data",ram);
    end

    always @(posedge clk) 
    begin 
        if (we) 
            ram[addr] <= din; 
        dout <= ram[addr];
    end
   
endmodule
