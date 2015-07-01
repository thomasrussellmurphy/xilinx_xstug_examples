//
// 8-to-1 1-bit MUX using a Case statement.
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/multiplexers/multiplexers_2.v
//
module v_multiplexers_2 (di, sel, do);
    input [7:0] di;
    input [2:0] sel;
    output reg  do;
    
    always @(sel or di)
    begin
        case (sel)
            3'b000  : do = di[7];
            3'b001  : do = di[6];
            3'b010  : do = di[5];
            3'b011  : do = di[4];
            3'b100  : do = di[3];
            3'b101  : do = di[2];
            3'b110  : do = di[1];
            default : do = di[0];
        endcase
    end
endmodule
