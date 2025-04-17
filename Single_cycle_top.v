`include "P_C.v"
`include "D_mem.v"
`include "I_mem.v"
`include "Reg_file.v"
`include "alu.v"
`include "Sign_ext.v"
`include "Control_unit_top.v"
`include "Mux.v"

module Single_Cycle_Top (
    input clk,
    input rst
);

    // Internal wires
    wire [31:0] pc_current, instruction, reg_data1, reg_data2, alu_operand2;
    wire [31:0] immediate_extended, alu_result, data_memory_output, result_to_register;
    wire [31:0] pc_next;

    wire reg_write_enable, mem_write_enable, alu_src_select, result_src_select;
    wire [1:0] immediate_source;
    wire [3:0] alu_control;

    // Program Counter
    PC_Module pc_module (
        .clk(clk),
        .rst(rst),
        .PC_NEXT(pc_next),
        .PC(pc_current)
    ); 

    // Instruction Memory
    I_mem instruction_memory (
        .A(pc_current),
        .rst(rst),
        .RD(instruction)
    );

    // Register File
    Reg_file register_file (
        .clk(clk),
        .rst(rst),
        .WE3(reg_write_enable),
        .WD3(result_to_register),
        .A1(instruction[19:15]),
        .A2(instruction[24:20]),
        .A3(instruction[11:7]),
        .RD1(reg_data1),
        .RD2(reg_data2)
    );

    // Immediate Generator
    Sign_Extend sign_extend (
        .In(instruction),
        .ImmSrc(immediate_source[0]),
        .Imm_Ext(immediate_extended)
    );

    // ALU Operand Mux
    Mux alu_operand_mux (
        .input_a(reg_data2),
        .input_b(immediate_extended),
        .select(alu_src_select),
        .output_c(alu_operand2)
    );

    // ALU
    alu alu_instance (
        .A(reg_data1),
        .B(alu_operand2),
        .Result(alu_result),
        .ALUControl(alu_control),
        .Z_flag(),
        .N_flag(),
        .C_flag(),
        .V_flag()
    ); 
    
    // Control Unit
    Control_Unit_Top control_unit (
        .Op(instruction[6:0]),
        .RegWrite(reg_write_enable),
        .ImmSrc(immediate_source),
        .ALUSrc(alu_src_select),
        .MemWrite(mem_write_enable),
        .ResultSrc(result_src_select),
        .branch(),
        .funct3(instruction[14:12]),
        .funct7(instruction[6:0]),
        .ALUControl(alu_control)
    );

    // Data Memory
    D_mem data_memory (
        .A(alu_result),
        .WD(reg_data2),
        .WE(mem_write_enable),
        .clk(clk),
        .rst(rst),
        .RD(data_memory_output)
    );

    // Mux for Write-Back to Register
    Mux result_mux (
        .input_a(alu_result),
        .input_b(data_memory_output),
        .select(result_src_select),
        .output_c(result_to_register)
    );

    // PC increment (for now, assume PC + 4)
    assign pc_next = pc_current + 32'd4;

endmodule
