//
// ROM modelling with a Verilog case statement
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rom_case.v
//
module rom_case (clk, en, addr, data);

    parameter ADDR_WIDTH = 4;
    parameter DATA_WIDTH = 16;

    input                       clk;                           
    input                       en;                            
    input      [ADDR_WIDTH-1:0] addr;                    
    output reg [DATA_WIDTH-1:0] data;               

    always @(posedge clk) begin          
        if (en)                              
            case (addr)                           
                4'b0000: data <= 16'h200A;
                4'b0001: data <= 16'h0300;
                4'b0010: data <= 16'h8101;
                4'b0011: data <= 16'h4000;
                4'b0100: data <= 16'h8601;
                4'b0101: data <= 16'h233A;
                4'b0110: data <= 16'h0300;
                4'b0111: data <= 16'h8602;
                4'b1000: data <= 16'h2222;
                4'b1001: data <= 16'h4001;
                4'b1010: data <= 16'h0342;
                4'b1011: data <= 16'h232B;
                4'b1100: data <= 16'h0900;
                4'b1101: data <= 16'h0302;
                4'b1110: data <= 16'h0102;
                4'b1111: data <= 16'h4002;
            endcase                              
    end                                  

endmodule                            
