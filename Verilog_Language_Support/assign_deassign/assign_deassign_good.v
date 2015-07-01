//
// Supported use of assign and deassign statements
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Verilog_Language_Support/assign_deassign/assign_deassign_good.v
//
module assign_deassign_good (RST, SELECT, STATE, CLOCK, DATA_IN);
    input RST;
    input SELECT;
    input CLOCK;
    input [0:3] DATA_IN;
    output [0:3] STATE;
    reg [0:3] STATE;

    always @ (RST)
        if (RST)
            assign STATE = 4'b0;
        else
            deassign STATE;

    always @ (posedge CLOCK)
    begin
        STATE <= DATA_IN;
    end
endmodule
