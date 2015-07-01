//
// Asymmetric port RAM
//   Port A is 2048x18-bit write-only
//   Port B is 4096x9-bit read-only
//   XST uses parity bits to accomodate data widths
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/asymmetric_ram_3.v
//
module v_asymmetric_ram_3 (clkA, clkB, weA, reB, addrA, addrB, diA, doB);

  parameter WIDTHA      = 18;
  parameter SIZEA       = 2048;
  parameter ADDRWIDTHA  = 11;
  parameter WIDTHB      = 9;
  parameter SIZEB       = 4096;
  parameter ADDRWIDTHB  = 12;
  
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

  generate for (i = 0; i < RATIO; i = i+1)
    begin: ramwrite
      localparam [log2RATIO-1:0] lsbaddr = i;
      always @(posedge clkA)
      begin
        if (weA)
          RAM[{addrA, lsbaddr}] <= diA[(i+1)*minWIDTH-1:i*minWIDTH];
      end
    end
  endgenerate

  always @(posedge clkB)
  begin
    if (reB)
      doB <= RAM[addrB];
  end

endmodule
