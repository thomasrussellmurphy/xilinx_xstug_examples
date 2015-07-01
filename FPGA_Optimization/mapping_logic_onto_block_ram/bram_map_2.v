//
// In the following example, an asynchronous reset is used and
// so, the logic is not mapped onto block RAM
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: FPGA_Optimization/mapping_logic_onto_block_ram/bram_map_2.v
//

(* bram_map="yes" *)
module v_logic_bram_2 (clk, rst, A, B, RES);            

    input  clk, rst;                                         
    input  [3:0] A, B;                                       
    output [3:0] RES;                                       
    reg    [3:0] RES; 
                                         
    always @(posedge clk or posedge rst)                    
    begin                                                   
        if (rst)                                                
            RES <= 4'b0000;                                         
        else                                                    
            RES <= A + B + 8'b0001;                                 
    end                                                     

endmodule                                               
