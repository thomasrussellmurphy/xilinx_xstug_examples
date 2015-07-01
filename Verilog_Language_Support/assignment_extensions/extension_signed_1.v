//
// Signed extension in an assignment
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Verilog_Language_Support/assignment_extensions/extension_signed_1.v
//
module extension_signed_1 (di, do);
    input  signed [3:0] di;
    output        [7:0] do;

    assign do = di;
    
endmodule
