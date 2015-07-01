//
// ROMs Using Block RAM Resources.
// Verilog code for a ROM with registered output (template 2)
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_21b.v
//
module v_rams_21b (clk, en, addr, data);

    input      clk;                           
    input      en;                            
    input      [5:0] addr;                    
    output reg [19:0] data;               
    reg        [19:0] rdata;


    always @(addr) begin          
        case(addr)                           
                6'b000000: rdata <= 20'h0200A;   6'b100000: rdata <= 20'h02222;
                6'b000001: rdata <= 20'h00300;   6'b100001: rdata <= 20'h04001;
                6'b000010: rdata <= 20'h08101;   6'b100010: rdata <= 20'h00342;
                6'b000011: rdata <= 20'h04000;   6'b100011: rdata <= 20'h0232B;
                6'b000100: rdata <= 20'h08601;   6'b100100: rdata <= 20'h00900;
                6'b000101: rdata <= 20'h0233A;   6'b100101: rdata <= 20'h00302;
                6'b000110: rdata <= 20'h00300;   6'b100110: rdata <= 20'h00102;
                6'b000111: rdata <= 20'h08602;   6'b100111: rdata <= 20'h04002;
                6'b001000: rdata <= 20'h02310;   6'b101000: rdata <= 20'h00900;
                6'b001001: rdata <= 20'h0203B;   6'b101001: rdata <= 20'h08201;
                6'b001010: rdata <= 20'h08300;   6'b101010: rdata <= 20'h02023;
                6'b001011: rdata <= 20'h04002;   6'b101011: rdata <= 20'h00303;
                6'b001100: rdata <= 20'h08201;   6'b101100: rdata <= 20'h02433;
                6'b001101: rdata <= 20'h00500;   6'b101101: rdata <= 20'h00301;
                6'b001110: rdata <= 20'h04001;   6'b101110: rdata <= 20'h04004;
                6'b001111: rdata <= 20'h02500;   6'b101111: rdata <= 20'h00301;
                6'b010000: rdata <= 20'h00340;   6'b110000: rdata <= 20'h00102;
                6'b010001: rdata <= 20'h00241;   6'b110001: rdata <= 20'h02137;
                6'b010010: rdata <= 20'h04002;   6'b110010: rdata <= 20'h02036;
                6'b010011: rdata <= 20'h08300;   6'b110011: rdata <= 20'h00301;
                6'b010100: rdata <= 20'h08201;   6'b110100: rdata <= 20'h00102;
                6'b010101: rdata <= 20'h00500;   6'b110101: rdata <= 20'h02237;
                6'b010110: rdata <= 20'h08101;   6'b110110: rdata <= 20'h04004;
                6'b010111: rdata <= 20'h00602;   6'b110111: rdata <= 20'h00304;
                6'b011000: rdata <= 20'h04003;   6'b111000: rdata <= 20'h04040;
                6'b011001: rdata <= 20'h0241E;   6'b111001: rdata <= 20'h02500;
                6'b011010: rdata <= 20'h00301;   6'b111010: rdata <= 20'h02500;
                6'b011011: rdata <= 20'h00102;   6'b111011: rdata <= 20'h02500;
                6'b011100: rdata <= 20'h02122;   6'b111100: rdata <= 20'h0030D;
                6'b011101: rdata <= 20'h02021;   6'b111101: rdata <= 20'h02341;
                6'b011110: rdata <= 20'h00301;   6'b111110: rdata <= 20'h08201;
                6'b011111: rdata <= 20'h00102;   6'b111111: rdata <= 20'h0400D;
        endcase                              
    end                                  

    always @(posedge clk) begin          
        if (en)                              
            data <= rdata;
    end
endmodule                            
