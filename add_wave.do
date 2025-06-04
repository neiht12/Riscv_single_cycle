vsim work.Single_cycle_top_tb

add wave -label "PC" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/pc_current
add wave -label "Instruction" -hex /Single_Cycle_Top_Tb/Single_Cycle_Top/instruction
add wave -label "funct3" -bin /Single_Cycle_Top_Tb/Single_Cycle_Top/instruction[14:12]
add wave -label "funct7" -bin /Single_Cycle_Top_Tb/Single_Cycle_Top/instruction[31:25]

add wave -label "A1" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/instruction[19:15]
add wave -label "A2" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/instruction[24:20]
add wave -label "A3" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/instruction[11:7]

add wave -label "RD1" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/reg_data1
add wave -label "RD2" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/reg_data2
add wave -label "WD3" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/result_to_register

add wave -label "ALUControl" -bin /Single_Cycle_Top_Tb/Single_Cycle_Top/alu_control
add wave -label "ALU_A" -hex /Single_Cycle_Top_Tb/Single_Cycle_Top/reg_data1
add wave -label "ALU_B" -hex /Single_Cycle_Top_Tb/Single_Cycle_Top/alu_operand2
add wave -label "ALU_Result" -dec /Single_Cycle_Top_Tb/Single_Cycle_Top/alu_result

add wave -label "RegWrite" /Single_Cycle_Top_Tb/Single_Cycle_Top/reg_write_enable
add wave -label "MemWrite" /Single_Cycle_Top_Tb/Single_Cycle_Top/mem_write_enable
add wave -label "ResultSrc" /Single_Cycle_Top_Tb/Single_Cycle_Top/result_src_select
add wave -label "ALUSrc" /Single_Cycle_Top_Tb/Single_Cycle_Top/alu_src_select
add wave -label "ImmSrc" /Single_Cycle_Top_Tb/Single_Cycle_Top/immediate_source

add wave -label "Immediate" /Single_Cycle_Top_Tb/Single_Cycle_Top/immediate_extended
add wave -label "DataMemOut" /Single_Cycle_Top_Tb/Single_Cycle_Top/data_memory_output

run 500ns
