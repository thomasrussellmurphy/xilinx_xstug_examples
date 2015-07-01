//
// A primitive instantiation in a if-generate without label
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Naming_Conventions/if_generate_nolabel.v
//
module top (
    input   clk,
    input   di,
    output  do
);
    
  parameter TEST_COND = 1;

  generate
  
      if (TEST_COND) begin
          FD myinst (.C(clk), .D(di), .Q(do));  // Post-synthesis name : myinst
      end
  
  endgenerate

endmodule
