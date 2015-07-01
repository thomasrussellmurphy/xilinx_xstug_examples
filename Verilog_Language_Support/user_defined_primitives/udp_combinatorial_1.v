//
// Description and instantiation of a user defined primitive
//   Combinatorial function
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Verilog_Language_Support/user_defined_primitives/udp_combinatorial_1.v
//
primitive myand2 (o, a, b);
  input  a, b;
  output o;
  
  table
    // a b : o
    0 0 : 0;
    0 1 : 0;
    1 0 : 0;
    1 1 : 1;
  endtable

endprimitive

module udp_combinatorial_1 (a, b, c, o);
  input  a, b, c;
  output o;
  
  wire   s;
  
  myand2 i1 (.a(a), .b(b), .o(s));
  myand2 i2 (.a(s), .b(c), .o(o));
    
endmodule
