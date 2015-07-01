//
// A reg in a labelled always block
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Naming_Conventions/reg_in_labelled_always.v
//
module top (
    input   clk,
    input   di,
    output  do
);
    
  reg data;

  always @(posedge clk)
  begin : mylabel

    reg tmp;
    
    tmp  <= di;               // Post-synthesis name : mylabel.tmp
    data <= ~tmp;             // Post-synthesis name : data
    
  end

  assign do = ~data;

endmodule

