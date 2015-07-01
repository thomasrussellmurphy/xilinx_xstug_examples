//
// 3-Bit 1-of-9 Priority Encoder
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/priority_encoders/priority_encoders_1.v
//
(* priority_extract="force" *)
module v_priority_encoder_1 (sel, code);
    input  [7:0] sel;
    output [2:0] code;
    reg    [2:0] code;

    always @(sel)
    begin
        if      (sel[0]) code = 3'b000;
        else if (sel[1]) code = 3'b001;
        else if (sel[2]) code = 3'b010;
        else if (sel[3]) code = 3'b011;
        else if (sel[4]) code = 3'b100;
        else if (sel[5]) code = 3'b101;
        else if (sel[6]) code = 3'b110;
        else if (sel[7]) code = 3'b111;
        else             code = 3'bxxx;
    end

endmodule
