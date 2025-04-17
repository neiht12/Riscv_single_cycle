module Reg_file(A1,A2,A3,WD3,WE3,clk,rst,RD1,RD2);

    input clk,rst,WE3;
    input [4:0] A1,A2,A3;
    input [31:0] WD3;

    output [31:0] RD1,RD2;

    reg [31:0] Register [31:0];
    always @ (posedge clk)
    begin
        if(WE3)
            Register[A3] <= WD3;
    end

    assign RD1 = (rst == 1'b0) ? 32'h00000000 : Register[A1];

    assign RD2 = (rst == 1'b0) ? 32'h00000000 : Register[A2];

    initial begin
        Register[5] = 32'h00000005;
        Register[6] = 32'h00000004;
        
    end
endmodule