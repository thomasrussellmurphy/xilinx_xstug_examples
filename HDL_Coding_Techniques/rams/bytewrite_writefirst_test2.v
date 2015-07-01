//
// Single-Port BRAM with Byte-wide Write Enable
//   4x9-bit write
//   Write-First mode
//   Single-process description
//   Compact description of the write with a generate-for statement
//   Column width and number of columns easily configurable 
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/bytewrite_writefirst.v
//
module v_bytewrite_writefirst (clk, we, addr, di, do);

  parameter SIZE	= 1024;
  parameter ADDR_WIDTH  = 10;
  parameter COL_WIDTH	= 8;
  parameter NB_COL	= 2;

  input 			     clk;
  input      [NB_COL-1:0]	     we;
  input      [ADDR_WIDTH-1:0]	     addr;
  input      [NB_COL*COL_WIDTH-1:0]  di;
  output reg [NB_COL*COL_WIDTH-1:0]  do;
  
  reg	     [NB_COL*COL_WIDTH-1:0]  RAM [SIZE-1:0];
  
      always @(posedge clk)
      begin
        if (we[i])
	 begin
          RAM[addr][(i+1)*COL_WIDTH-1:i*COL_WIDTH]
	    <= di[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
          do[(i+1)*COL_WIDTH-1:i*COL_WIDTH]
	    <= di[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
         end
        else
          do[(i+1)*COL_WIDTH-1:i*COL_WIDTH]
	    <= RAM[addr][(i+1)*COL_WIDTH-1:i*COL_WIDTH];
      end

      always @(posedge clk)
      begin
        if (we[i])
	 begin
          RAM[addr][(i+1)*COL_WIDTH-1:i*COL_WIDTH]
	    <= di[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
          do[(i+1)*COL_WIDTH-1:i*COL_WIDTH]
	    <= di[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
         end
        else
          do[(i+1)*COL_WIDTH-1:i*COL_WIDTH]
	    <= RAM[addr][(i+1)*COL_WIDTH-1:i*COL_WIDTH];
      end

endmodule
