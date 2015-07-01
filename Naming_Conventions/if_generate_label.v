//
// A primitive instantiation in a labelled if-generate
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Naming_Conventions/if_generate_label.v
//
module top (
    input   clk,
    input   rst,
    input   di,
    output  do
);
    
  // parameter TEST_COND = 1;
  parameter TEST_COND = 0;

  generate
  
      if (TEST_COND)
          begin : myifname
              FDR myinst (.C(clk), .D(di), .Q(do), .R(rst)); 
	      // Post-synthesis name : myifname.myinst
          end
      else
          begin : myelsename
              FDS myinst (.C(clk), .D(di), .Q(do), .S(rst)); 
	      // Post-synthesis name : myelsename.myinst
          end
      
  endgenerate

endmodule
