`timescale 1ns / 1ps

module testbench_control_unit_top;

    // Inputs
    reg clk, rst;
    reg [6:0] Op, funct7;
    reg [2:0] funct3;
    reg [31:0] A, B;

    // Outputs
    wire RegWrite, ALUSrc, MemWrite, ResultSrc, branch;
    wire [1:0] ImmSrc;
    wire [3:0] ALUControl;
    wire [31:0] Result;
    wire Z_flag, N_flag, C_flag, V_flag;

    // Instantiate the Control Unit
    Control_Unit_Top dut (
        .Op(Op),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .branch(branch),
        .ImmSrc(ImmSrc),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl)
    );

    // Instantiate the ALU
    alu alu_unit (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .Z_flag(Z_flag),
        .N_flag(N_flag),
        .C_flag(C_flag),
        .V_flag(V_flag)
    );

    // Clock generator
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize
        clk = 0; rst = 0;
        Op = 7'b0000000; funct3 = 3'b000; funct7 = 7'b0000000;
        A = 0; B = 0;

        // Wait some time
        #10;

        // === Case 1: R-type ADD ===
        Op = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0000000;
        A = 32'd15; B = 32'd10; // Expect Result = 25
        #10;

        $display("=== R-type ADD ===");
        $display("Op: %b, funct3: %b, funct7: %b", Op, funct3, funct7);
        $display("RegWrite=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b, branch=%b", 
                  RegWrite, ALUSrc, MemWrite, ResultSrc, branch);
        $display("ImmSrc=%b, ALUControl=%b", ImmSrc, ALUControl);
        $display("A = %d, B = %d, Result = %d", A, B, Result);
        $display("Flags: Z=%b, N=%b, C=%b, V=%b\n", Z_flag, N_flag, C_flag, V_flag);

        // === Case 2: R-type SUB ===
        Op = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0100000;
        A = 32'd20; B = 32'd5; // Expect Result = 15
        #10;

        $display("=== R-type SUB ===");
        $display("A = %d, B = %d, Result = %d", A, B, Result);
        $display("ALUControl = %b", ALUControl);

        // === Case 3: BEQ (SUB) ===
        Op = 7'b1100011; funct3 = 3'b000; funct7 = 7'b0000000;
        A = 32'd40; B = 32'd40; // Expect Result = 0 (Z=1)
        #10;

        $display("=== BEQ branch (SUB) ===");
        $display("A = %d, B = %d, Result = %d", A, B, Result);
        $display("Z_flag = %b (should be 1 if equal)", Z_flag);

        // === Case 4: Load (lw) ===
        Op = 7'b0000011; funct3 = 3'b010; funct7 = 7'b0000000;
        A = 32'd100; B = 32'd8; // Expect Result = 108
        #10;

        $display("=== Load (lw) ===");
        $display("A = %d, B = %d, Result = %d", A, B, Result);
        $display("ALUControl = %b", ALUControl);

        // === Case 5: Store (sw) ===
        Op = 7'b0100011; funct3 = 3'b010; funct7 = 7'b0000000;
        A = 32'd200; B = 32'd16; // Expect Result = 216
        #10;

        $display("=== Store (sw) ===");
        $display("A = %d, B = %d, Result = %d", A, B, Result);
        $display("ALUControl = %b", ALUControl);

        // Done
        #10;
        $finish;
    end

endmodule
