//
// The following example places 8-bit adders with 
// constant in a single block RAM primitive
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: FPGA_Optimization/mapping_logic_onto_block_ram/bram_map_1.v
//

(* bram_map="yes" *)
module v_logic_bram_1 (clk, rst, A, B, RES);            

    input  clk, rst;                                        
    input  [3:0] A, B;                                      
    output [3:0] RES;                                      
    reg    [3:0] RES;                                         

    always @(posedge clk)                                  
    begin                                                  
        if (rst)                                               
            RES <= 4'b0000;                                         
        else                                                   
            RES <= A + B + 8'b0001;                                 
    end                                                    

endmodule                                              
