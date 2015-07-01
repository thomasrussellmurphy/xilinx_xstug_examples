//
// Description and instantiation of a user defined primitive
//   Sequential function
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Verilog_Language_Support/user_defined_primitives/udp_sequential_2.v
//
primitive mydff (q, d, c);
  input      c, d;
  output reg q;
 
  initial q = 1'b0;
   
  table
  // c  d : q : q+
     r  0  : ? : 0;
     r  1  : ? : 1;
     f  ?  : ? : -;
     ?  *  : ? : -;
  endtable
  
endprimitive

module udp_sequential_2 (clk, si, so);
  input  clk, si;
  output so;
  
  wire   s1, s2;
  
  mydff i1 (.c(clk), .d(si), .q(s1));
  mydff i2 (.c(clk), .d(s1), .q(s2));
  mydff i3 (.c(clk), .d(s2), .q(so));
    
endmodule
