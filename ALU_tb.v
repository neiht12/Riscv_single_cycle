module alu_tb;

    // Declare testbench signals
    reg [31:0] A, B;
    reg [3:0] ALUControl;
    wire [31:0] Result;
    wire Z_flag, N_flag, C_flag, V_flag;

    // Instantiate the ALU
    alu uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .Z_flag(Z_flag),
        .N_flag(N_flag),
        .C_flag(C_flag),
        .V_flag(V_flag)
    );

    // Initialize inputs and apply test cases
    initial begin
        // Test Case 1: Addition (ALUControl = 0000)
        A = 32'h00000005; B = 32'h00000003; ALUControl = 4'b0000;  // ADD
        #10;
        $display("ADD: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // Test Case 2: Subtraction (ALUControl = 0001)
        A = 32'h00000005; B = 32'h00000003; ALUControl = 4'b0001;  // SUB
        #10;
        $display("SUB: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // Test Case 3: AND (ALUControl = 0010)
        A = 32'h0000000F; B = 32'h000000F0; ALUControl = 4'b0010;  // AND
        #10;
        $display("AND: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // Test Case 4: OR (ALUControl = 0011)
        A = 32'h0000000F; B = 32'h000000F0; ALUControl = 4'b0011;  // OR
        #10;
        $display("OR: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // Test Case 5: Shift Left Logical (ALUControl = 0100)
        A = 32'h00000001; B = 32'h00000002; ALUControl = 4'b0100;  // SLL
        #10;
        $display("SLL: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // Test Case 6: Set Less Than (ALUControl = 0101)
        A = 32'h00000005; B = 32'h00000010; ALUControl = 4'b0101;  // SLT
        #10;
        $display("SLT: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // Test Case 7: XOR (ALUControl = 0110)
        A = 32'h000000FF; B = 32'h0000000F; ALUControl = 4'b0110;  // XOR
        #10;
        $display("XOR: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // Test Case 8: Shift Right Logical (ALUControl = 0111)
        A = 32'h00000010; B = 32'h00000002; ALUControl = 4'b0111;  // SRL
        #10;
        $display("SRL: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // Test Case 9: Set Less Than Unsigned (ALUControl = 1000)
        A = 32'h00000005; B = 32'h00000010; ALUControl = 4'b1000;  // SLTU
        #10;
        $display("SLTU: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // Test Case 10: Arithmetic Shift Right (ALUControl = 1111)
        A = 32'h80000010; B = 32'h00000002; ALUControl = 4'b1111;  // SRA
        #10;
        $display("SRA: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // Test Case 11: Zero Result (ALUControl = 0000)
        A = 32'h00000000; B = 32'h00000000; ALUControl = 4'b0000;  // ADD (0 + 0)
        #10;
        $display("Zero Result: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // Test Case 12: Negative Result (ALUControl = 0001)
        A = 32'h00000005; B = 32'h0000000A; ALUControl = 4'b0001;  // SUB (5 - 10)
        #10;
        $display("Negative Result: A = %h, B = %h, Result = %h, Z_flag = %b, N_flag = %b, C_flag = %b, V_flag = %b", A, B, Result, Z_flag, N_flag, C_flag, V_flag);

        // End of testbench
        $finish;
    end

endmodule
