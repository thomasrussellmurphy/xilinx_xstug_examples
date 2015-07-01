//
// Asymmetric port RAM
//   Port A is 256x8-bit write-only
//   Port B is 64x32-bit read-only
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/asymmetric_ram_1a.v
//
module v_asymmetric_ram_1a (clkA, clkB, weA, reB, addrA, addrB, diA, doB);

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

  localparam maxSIZE  = `max(SIZEA, SIZEB);
  localparam maxWIDTH = `max(WIDTHA, WIDTHB);
  localparam minWIDTH = `min(WIDTHA, WIDTHB);
  localparam RATIO    = maxWIDTH / minWIDTH;

  reg     [minWIDTH-1:0]  RAM [0:maxSIZE-1];
  
  reg     [WIDTHB-1:0]  readB;
  
  always @(posedge clkA)
  begin
    if (weA)
      RAM[addrA] <= diA;
  end

  always @(posedge clkB)
  begin
    if (reB)
    begin
      doB <= readB;
      readB[4*minWIDTH-1:3*minWIDTH] <= RAM[{addrB, 2'd3}];
      readB[3*minWIDTH-1:2*minWIDTH] <= RAM[{addrB, 2'd2}];
      readB[2*minWIDTH-1:minWIDTH]   <= RAM[{addrB, 2'd1}];
      readB[minWIDTH-1:0]            <= RAM[{addrB, 2'd0}];
    end
  end

endmodule
