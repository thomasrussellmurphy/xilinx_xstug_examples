//
// Block RAM with Resettable Data Output
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_18.v
//
module v_rams_18 (clk, en, we, rst, addr, di, do);

    input  clk;                                      
    input  en;                                       
    input  we;                                       
    input  rst;                                      
    input  [6:0] addr;                               
    input  [15:0] di;                                 
    output [15:0] do;                                
    reg    [15:0] ram [127:0];                           
    reg    [15:0] do;                                   

    always @(posedge clk)                           
    begin                                           
        if (en) // optional enable                        
        begin                                           
            if (we) // write enable                           
                ram[addr] <= di;                                

            if (rst) // optional reset                        
                do <= 16'b0000111100001101;                              
            else                                            
                do <= ram[addr];                                
        end                                             
    end                                             

endmodule                                       
