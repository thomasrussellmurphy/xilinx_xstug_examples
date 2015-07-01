//
// Multiplier Up Accumulate with:
//     Registered operands
//     Registered multiplication
//     Accumulation
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/multipliers/multiply_accum_2.v
//
module v_multiply_accum_2 (clk, rst, A, B, RES);

    parameter  WIDTH = 8;
    input                  clk;
    input                  rst;
    input   [WIDTH-1:0]    A, B;
    output  [2*WIDTH-1:0]  RES;
    
    reg     [WIDTH-1:0]    rA, rB;
    reg     [2*WIDTH-1:0]  mult, accum;   

    always @(posedge clk)
    begin
        if (rst) begin
	    rA     <= {WIDTH{1'b0}};
	    rB     <= {WIDTH{1'b0}};
            mult   <= {2*WIDTH{1'b0}};
            accum  <= {2*WIDTH{1'b0}};
        end
	else begin
	    rA <= A;
	    rB <= B;
            mult <= rA * rB;
            accum <= accum + mult;
        end
    end
    assign RES = accum;

endmodule
