//
// Mixing of blocking and non-blocking assignments to the same signal
// Not rejected, but should be avoided
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Verilog_Language_Support/rejected/blockingmix1.v
//
module blockingmix1 (clk, sel, i1, i2, o);

  input       clk, sel, i1, i2;
  output reg  o;
  
  always @ (posedge clk)
  begin
    if (sel)
      o = i1;
    else
      o <= i2;
  end

endmodule
