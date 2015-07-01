//
// Pipeline distributed RAM
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_22.v
//
module v_rams_22 (clk, we, addr, di, do);

    input        clk;
    input        we;
    input  [8:0] addr;
    input  [3:0] di;
    output [3:0] do;
    
    (*ram_style="pipe_distributed"*)
    reg    [3:0] RAM [511:0];
    reg    [3:0] do;
    reg    [3:0] pipe_reg;

    always @(posedge clk)
    begin
        if (we)
          RAM[addr] <= di;
        else
          pipe_reg <= RAM[addr];
	  
        do <= pipe_reg;
    end

endmodule
