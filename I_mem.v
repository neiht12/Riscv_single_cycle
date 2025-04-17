module I_mem(A,rst,RD);

    input [31:0] A;
    input rst;
    output reg [31:0] RD;

    reg [31:0] mem [1023:0];

    assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]]; 
    

endmodule