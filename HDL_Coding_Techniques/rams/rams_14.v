//
// Dual-Port RAM with Enable on Each Port
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: HDL_Coding_Techniques/rams/rams_14.v
//
module v_rams_14 (clk,ena,enb,wea,addra,addrb,dia,doa,dob);

    input  clk;
    input  ena;
    input  enb;
    input  wea;
    input  [5:0] addra;
    input  [5:0] addrb;
    input  [15:0] dia;
    output [15:0] doa;
    output [15:0] dob;
    reg    [15:0] ram [63:0];
    reg    [5:0] read_addra;
    reg    [5:0] read_addrb;

    always @(posedge clk) begin
        if (ena)
        begin
            if (wea)
                ram[addra] <= dia;
            read_addra <= addra;
        end

        if (enb)
            read_addrb <= addrb;
    end

    assign doa = ram[read_addra];
    assign dob = ram[read_addrb];

endmodule
