//
// Asymmetric port RAM
//   Port A is 256x8-bit read-and-write (write-first synchronization)
//   Port B is 64x32-bit read-and-write (write-first synchronization)
//   Compact description with a for-loop statement
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/asymmetric_write_first_2.v
//
module v_asymmetric_write_first_2 (clkA, clkB, enA, enB, weA, weB, addrA, addrB, diA, diB, doA, doB);

  parameter WIDTHA      = 8;
  parameter SIZEA       = 256;
  parameter ADDRWIDTHA  = 8;
  parameter WIDTHB      = 32;
  parameter SIZEB       = 64;
  parameter ADDRWIDTHB  = 6;
  
  input                         clkA;
  input                         clkB;
  input                         enA;
  input                         enB;
  input                         weA;
  input                         weB;
  input       [ADDRWIDTHA-1:0]  addrA;
  input       [ADDRWIDTHB-1:0]  addrB;
  input       [WIDTHA-1:0]      diA;
  input       [WIDTHB-1:0]      diB;
  output reg  [WIDTHA-1:0]      doA;
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
  
  genvar i;

  always @(posedge clkA)
  begin
    if (enA)
      if (weA)
      begin
        RAM[addrA] <= diA;
	doA <= diA;
      end
      else
        doA <= RAM[addrA];
  end

  generate for (i = 0; i < RATIO; i = i+1)
    begin: portb
      localparam [log2RATIO-1:0] lsbaddr = i;
      always @(posedge clkB)
      begin
        if (enB)
	begin
          if (weB)
	    // The following statement is made blocking on purpose. This is one
	    // way to achieve the write-first functionality
            RAM[{addrB, lsbaddr}] = diB[(i+1)*minWIDTH-1:i*minWIDTH];
          doB[(i+1)*minWIDTH-1:i*minWIDTH] <= RAM[{addrB, lsbaddr}];
        end
      end
    end
  endgenerate

endmodule
