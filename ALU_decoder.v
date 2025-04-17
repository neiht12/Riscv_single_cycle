module alu_decoder(
    input [1:0] ALUOp,      // ALUOp from control unit
    input [2:0] funct3,     // funct3 from instruction
    input [6:0] funct7,     // funct7 from instruction
    input [6:0] op,         // 7-bit opcode
    output [3:0] ALUControl // 4-bit ALU control signal
);

    assign ALUControl = (ALUOp == 2'b00) ? 4'b0010 :              // ADD for load/store (ALUOp = 00)
                        (ALUOp == 2'b01) ? 4'b0110 :              // SUB for branch (ALUOp = 01)
                        (ALUOp == 2'b10 && funct3 == 3'b000 && {op[6], funct7[5]} == 2'b00) ? 4'b0010 : // ADD for R-type
                        (ALUOp == 2'b10 && funct3 == 3'b000 && {op[6], funct7[5]} == 2'b01) ? 4'b0110 : // SUB for R-type
                        (ALUOp == 2'b10 && funct3 == 3'b000 && {op[6], funct7[5]} == 2'b10) ? 4'b0001 : // ADD for I-type
                        (ALUOp == 2'b10 && funct3 == 3'b001) ? 4'b0100 :                          // SLL
                        (ALUOp == 2'b10 && funct3 == 3'b101 && funct7[5] == 1'b0) ? 4'b0111 :     // SRL
                        (ALUOp == 2'b10 && funct3 == 3'b101 && funct7[5] == 1'b1) ? 4'b0110 :     // SRA
                        (ALUOp == 2'b10 && funct3 == 3'b110) ? 4'b0000 :                          // OR
                        (ALUOp == 2'b10 && funct3 == 3'b111) ? 4'b0001 :                          // AND
                        (ALUOp == 2'b10 && funct3 == 3'b010) ? 4'b1000 :                          // SLT
                        (ALUOp == 2'b10 && funct3 == 3'b011) ? 4'b1001 :                          // SLTU
                                                                 4'bxxxx;                         // Undefined

endmodule
