//
// Asymmetric port RAM
//   Port A is 256x8-bit write-only
//   Port B is 64x32-bit read-only
//   Compact description with a generate-for statement
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/v_asymmetric_ram_1b.v
//
module v_asymmetric_ram_1b (clkA, clkB, weA, reB, addrA, addrB, diA, doB);

  parameter WIDTHA      = 8;
  parameter SIZEA       = 256;
  parameter ADDRWIDTHA  = 8;
  parameter WIDTHB      = 32;
  parameter SIZEB       = 64;
  parameter ADDRWIDTHB  = 6;
  
  input                         clkA;
  input                         clkB;
  input                         weA;
  input                         reB;
  input       [ADDRWIDTHA-1:0]  addrA;
  input       [ADDRWIDTHB-1:0]  addrB;
  input       [WIDTHA-1:0]      diA;
  output reg  [WIDTHB-1:0]      doB;

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
    if (weA)
      RAM[addrA] <= diA;
  end

  always @(posedge clkB)
  begin
    if (reB)
      doB <= readB;
  end

  generate for (i = 0; i < RATIO; i = i+1)
    begin: ramread
      localparam [log2RATIO-1:0] lsbaddr = i;
      always @(posedge clkB)
      begin
        readB[(i+1)*minWIDTH-1:i*minWIDTH] <= RAM[{addrB, lsbaddr}];
      end
    end
  endgenerate

endmodule
