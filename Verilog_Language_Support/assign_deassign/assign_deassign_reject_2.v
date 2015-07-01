//
// Unsupported assign and deassign statements
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Verilog_Language_Support/assign_deassign/assign_deassign_reject_2.v
//
module assign_deassign_reject_2 (RST, SET, STATE, CLOCK, DATA_IN);
    input RST;
    input SET;
    input CLOCK;
    input DATA_IN;
    output STATE;
    reg STATE;

    always @ (RST or SET) // block b1
        case ({RST,SET})
            2'b00: assign STATE = 1'b0;
            2'b01: assign STATE = 1'b0;
            2'b10: assign STATE = 1'b1;
            2'b11: deassign STATE;
        endcase

    always @ (posedge CLOCK) // block b2
    begin
        STATE <= DATA_IN;
    end

endmodule
