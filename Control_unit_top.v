`include "ALU_decoder.v"
`include "Main_decoder.v"

module Control_Unit_Top(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,branch,funct3,funct7,ALUControl);
    input [6:0] Op,funct7;
    input [2:0] funct3;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,branch;
    output [3:0] ALUControl;
    output [1:0] ImmSrc;

    wire [1:0] ALUOp;
    main_decoder main_decoder(
        .op(Op),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .branch(branch),
        .ALUOp(ALUOp)
    );
    alu_decoder alu_decoder(
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .op(Op),
        .ALUControl(ALUControl)
    );
endmodule