module alu_decoder(
    input [1:0] ALUOp,      
    input [2:0] funct3,     
    input [6:0] funct7,     
    input [6:0] op,         
    output reg [3:0] ALUControl 
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 4'b0000; // ADD cho Load/Store
        2'b01: ALUControl = 4'b0001; // SUB cho Branch
        2'b10: begin
            case (funct3)
                3'b000: begin // ADD/SUB
                    if (funct7[5] & op[5])
                        ALUControl = 4'b0001; // SUB
                    else  
                        ALUControl = 4'b0000; // ADD
                end
                3'b111: ALUControl = 4'b0010; // AND
                3'b110: ALUControl = 4'b0011; // OR
                3'b100: ALUControl = 4'b0110; // XOR
                3'b001: ALUControl = 4'b0100; // SLL
                3'b101: begin
                    if (~funct7[5])
                        ALUControl = 4'b0111; // SRL
                    else
                        ALUControl = 4'b1111; // SRA
                end
                3'b010: ALUControl = 4'b0101; // SLT
                3'b011: ALUControl = 4'b1000; // SLTU
                default: ALUControl = 4'b1111; // undefined
            endcase
        end
        default: ALUControl = 4'b1111;
    endcase
end

endmodule
