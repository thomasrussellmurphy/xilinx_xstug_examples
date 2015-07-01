//
// Unsupported assign and deassign statements 
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Verilog_Language_Support/assign_deassign/assign_deassign_reject_3.v
//
module assign_deassign_reject_3 (RST, SELECT, STATE, CLOCK, DATA_IN);
    input RST;
    input SELECT;
    input CLOCK;
    input [0:7] DATA_IN;
    output [0:7] STATE;
    reg [0:7] STATE;

    always @ (RST) // block b1
        if (RST)
            assign STATE[0:7] = 8'b0;
        else
            deassign STATE[0:7];

    always @ (posedge CLOCK) // block b2
    begin
        if (SELECT)
            STATE [0:3] <= DATA_IN[0:3];
        else
            STATE [4:7] <= DATA_IN[4:7];
    end

endmodule
