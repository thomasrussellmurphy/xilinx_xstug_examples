//
// Mixing of blocking and non-blocking assignments for different bits of a bus
// Not rejected, but should be avoided
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Verilog_Language_Support/rejected/blockingmix2.v
//
module blockingmix2 (clk, sel, i1, i2, o);

  input              clk, sel, i1, i2;
  output reg  [1:0]  o;
  
  always @ (posedge clk)
  begin
    if (sel) begin
      o[0] = 1'b0;
      o[1] <= i1;
    end
    else begin
      o[0] = i2;
      o[1] <= 1'b1;
    end
  end

endmodule
