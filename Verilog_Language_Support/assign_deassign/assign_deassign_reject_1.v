//
// Unsupported assign and deassign statements 
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Verilog_Language_Support/assign_deassign/assign_deassign_reject_1.v
//
module assign_deassign_reject_1 (RST, SET, STATE, CLOCK, DATA_IN);
    input RST;
    input SET;
    input CLOCK;
    input DATA_IN;
    output STATE;
    reg STATE;

    always @ (RST) // block b1
        if(RST)
            assign STATE = 1'b0;
        else
            deassign STATE;

    always @ (SET) // block b1
        if(SET)
            assign STATE = 1'b1;
        else
            deassign STATE;

    always @ (posedge CLOCK) // block b2
    begin
        STATE <= DATA_IN;
    end

endmodule
