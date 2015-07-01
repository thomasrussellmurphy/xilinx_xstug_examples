//
// Verilog 2001 attribute examples
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Verilog_Language_Support/attributes/vlgattrib2001_1.v
//

(* mux_extract = "no" *)
module vlgattrib2001_1 (clk, we1, we2, sel, re1, re2, waddr, raddr, di, do);

  (* max_fanout = "100", buffer_type = "none" *) input  clk;
  input       [1:0] sel;
  input             we1, we2;
  input             re1, re2;
  input       [7:0] waddr;
  input       [7:0] raddr;
  input      [15:0] di;
  output reg [15:0] do;
  
  (* mux_extract = "yes",
     use_clock_enable = "no" *)
  reg  re;
  
  (*
     ram_extract = "yes",
     ram_style = "block"
  *)
  reg [15:0] RAM [255:0];
  
  (* keep = "true" *) wire    we;
  
  assign we = we1 | we2;
  
  always @ (posedge clk)
  begin
      (* full_case *) (* parallel_case *)
      case (sel)
          2'b00 : re <= re1 & re2;
          2'b01 : re <= re1 | re2;
          2'b10 : re <= re1;
          2'b11 : re <= re2;
      endcase    
  end

  always @ (posedge clk)
  begin
      if (we)
          RAM[waddr] <= di;
      if (re)
          do <= RAM[raddr];
  end
    
endmodule
