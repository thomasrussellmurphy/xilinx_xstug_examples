//------------------------------------------------------------------------------ 
// Copyright (c) 1996-2009 Xilinx, Inc. 
// All Rights Reserved 
//------------------------------------------------------------------------------ 
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /   Company: Xilinx 
// \   \   \/    Design: AlphaBlender
//  \   \        Version: 1.1
//  /   /        Filename: AlphaBlender.v
// /___/   /\    Date Last Modified:  May 12, 2009
// \   \  /  \   Date Created: May 6, 2009
//  \___\/\___\ 
// 
//Device: Xilinx Spartan-6 and Virtex-6 
//Library: IEEE 
//Purpose: An Alpha Blending function implemented on a single DSP block, taking
//         advantage of available pipelining, preadder, multiplier and postadder
//         features
//         Implements the alpha blender function in a DSP48A1 or DSP48E1, taking
//         care of all needed shifting and padding of the pixel and alpha
//         coefficient inputs, and extracting the proper bits for the blended
//         pixel
//         Top-level design file
//Reference: http://www.xilinx.com
//Tools: Xilinx ISE 11.2, MTI ModelSim-SE 6.3b
//Revision History: 
//    Rev 1.0 - First release, wendling, May 6, 2009 
//    Rev 1.1 - Code and header cleaning, wendling, May 12, 2009 
//------------------------------------------------------------------------------ 

module AlphaBlender (clk, alpha, pixel1, pixel2, pixelout);

  parameter  PixelWidth       = 8;
  parameter  AlphaWidth       = 8;

  input                          clk;
  input        [AlphaWidth-1:0]  alpha;
  input        [PixelWidth-1:0]  pixel1;
  input        [PixelWidth-1:0]  pixel2;
  output       [PixelWidth-1:0]  pixelout;
  
  localparam  DspDataWidth    = 18;
  localparam  DspCascadeWidth = 48;
  
  wire signed      [DspDataWidth-1:0]  ain;
  reg signed       [DspDataWidth-1:0]  ain_r1 = 0;
  reg signed       [DspDataWidth-1:0]  ain_r2 = 0;
  wire signed      [DspDataWidth-1:0]  bin;
  wire signed   [DspCascadeWidth-1:0]  cin;
  wire signed      [DspDataWidth-1:0]  din;
  reg signed       [DspDataWidth-1:0]  bin_r = 0;
  reg signed       [DspDataWidth-1:0]  din_r = 0;
  reg signed    [DspCascadeWidth-1:0]  cin_r1 = 0;
  reg signed    [DspCascadeWidth-1:0]  cin_r2 = 0;
  reg signed    [DspCascadeWidth-1:0]  cin_r3 = 0;
  reg signed       [DspDataWidth-1:0]  preadd_r = 0;
  reg signed     [2*DspDataWidth-1:0]  mult_r = 0;
  wire signed   [DspCascadeWidth-1:0]  mult_sxt;
  reg signed    [DspCascadeWidth-1:0]  sum_r = 0;
  
  wire               [AlphaWidth-1:0]  AlphaPadding = 0;
  
  assign bin = $signed({ 1'b0, pixel1, AlphaPadding });
  assign cin = $signed({ 1'b0, pixel1, AlphaPadding, AlphaPadding });
  assign din = $signed({ 1'b0, pixel2, AlphaPadding });
  assign ain = $signed({ 1'b0, alpha});

  assign mult_sxt = $signed(mult_r);

  always @(posedge clk)
  begin
    ain_r1   <= ain;
    ain_r2   <= ain_r1;
    bin_r    <= bin;
    din_r    <= din;
    cin_r1   <= cin;
    cin_r2   <= cin_r1;
    cin_r3   <= cin_r2;
    preadd_r <= din_r - bin_r;
    mult_r   <= preadd_r * ain_r2; 
    sum_r    <= mult_sxt + cin_r3;   
  end

  assign pixelout = sum_r[2*AlphaWidth+PixelWidth-1:2*AlphaWidth];
  
endmodule
