//
// Description and instantiation of a user defined primitive
//   Sequential function
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Verilog_Language_Support/user_defined_primitives/udp_sequential_1.v
//
primitive myfde (q, d, c, ce);
  input      c, ce, d;
  output reg q;
 
  initial q = 1'b0;
   
  table
  // d  c  ce : q : q+
     0  p  1  : ? : 0;
     1  p  1  : ? : 1;
     ?  n  1  : ? : -;
     0  p  0  : ? : -;
     1  p  0  : ? : -;
     ?  n  0  : ? : -;
  endtable
  
endprimitive

module udp_sequential_1 (clk, clken, si, so);
  input  clk, clken, si;
  output so;
  
  wire   s1, s2;
  
  myfde i1 (.c(clk), .ce(clken), .d(si), .q(s1));
  myfde i2 (.c(clk), .ce(clken), .d(s1), .q(s2));
  myfde i3 (.c(clk), .ce(clken), .d(s2), .q(so));
    
endmodule
