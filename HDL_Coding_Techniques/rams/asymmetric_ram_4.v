//
// Asymmetric port RAM
//   Port A is 256x8-bit read-only
//   Port B is 64x32-bit write-only
//   Compact description with a generate-for statement
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/asymmetric_ram_4.v
//
module v_asymmetric_ram_4 (clkA, clkB, reA, weB, addrA, addrB, doA, diB);

  parameter WIDTHA      = 8;
  parameter SIZEA       = 256;
  parameter ADDRWIDTHA  = 8;
  parameter WIDTHB      = 32;
  parameter SIZEB       = 64;
  parameter ADDRWIDTHB  = 6;
  
  input                         clkA;
  input                         clkB;
  input                         reA;
  input                         weB;
  input       [ADDRWIDTHA-1:0]  addrA;
  input       [ADDRWIDTHB-1:0]  addrB;
  output reg  [WIDTHA-1:0]      doA;
  input       [WIDTHB-1:0]      diB;

  `define max(a,b) {(a) > (b) ? (a) : (b)}
  `define min(a,b) {(a) < (b) ? (a) : (b)}

  function integer log2;
    input integer value;
    reg [31:0] shifted;
    integer res;
  begin
    if (value < 2)
      log2 = value;
    else
    begin
      shifted = value-1;
      for (res=0; shifted>0; res=res+1)
        shifted = shifted>>1;
      log2 = res;
    end
  end
  endfunction

  localparam maxSIZE   = `max(SIZEA, SIZEB);
  localparam maxWIDTH  = `max(WIDTHA, WIDTHB);
  localparam minWIDTH  = `min(WIDTHA, WIDTHB);
  localparam RATIO     = maxWIDTH / minWIDTH;
  localparam log2RATIO = log2(RATIO);

  reg     [minWIDTH-1:0]  RAM [0:maxSIZE-1];
  
  reg     [WIDTHB-1:0]  readB;
  
  genvar i;

  always @(posedge clkA)
  begin
    if (reA)
      doA <= RAM[addrA];
  end

  generate for (i = 0; i < RATIO; i = i+1)
    begin: ramread
      localparam [log2RATIO-1:0] lsbaddr = i;
      always @(posedge clkB)
      begin
        if (weB)
          RAM[{addrB, lsbaddr}] <= diB[(i+1)*minWIDTH-1:i*minWIDTH];
      end
    end
  endgenerate

endmodule
