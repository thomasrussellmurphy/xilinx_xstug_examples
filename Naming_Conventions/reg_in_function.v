//
// A reg in a function
//
// Download: ftp://ftp.xilinx.com/pub/documentation/misc/xstug_examples.zip
// File: Naming_Conventions/reg_in_function.v
//
module top (
    input   di1, di2,
    output  do
);

    wire    data;
        
    function myfunc;
        input fdi1, fdi2;
        reg tmp;
	begin
            tmp = ~fdi1;       // Post-synthesis name : myfunc.tmp
            myfunc = ~tmp | fdi2;
        end
    endfunction

    assign data = myfunc(di1, di2);
    assign do = ~data;

endmodule

