module main_decoder_tb;

    // Declare testbench signals
    reg [6:0] op;
    wire RegWrite, MemWrite, ResultSrc, ALUSrc, branch;
    wire [1:0] ALUOp, ImmSrc;

    // Instantiate the main_decoder module
    main_decoder uut (
        .op(op),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .ALUOp(ALUOp),
        .branch(branch)
    );

    // Initialize inputs and apply test cases
    initial begin
        // Test Case 1: op = 0000011 (Load)
        op = 7'b0000011;  // opcode for Load
        #10;
        $display("Test Case 1 (Load): op = %b, RegWrite = %b, MemWrite = %b, ResultSrc = %b, ALUSrc = %b, ImmSrc = %b, ALUOp = %b, branch = %b", 
                 op, RegWrite, MemWrite, ResultSrc, ALUSrc, ImmSrc, ALUOp, branch);

        // Test Case 2: op = 0110011 (R-type)
        op = 7'b0110011;  // opcode for R-type
        #10;
        $display("Test Case 2 (R-type): op = %b, RegWrite = %b, MemWrite = %b, ResultSrc = %b, ALUSrc = %b, ImmSrc = %b, ALUOp = %b, branch = %b", 
                 op, RegWrite, MemWrite, ResultSrc, ALUSrc, ImmSrc, ALUOp, branch);

        // Test Case 3: op = 0100011 (Store)
        op = 7'b0100011;  // opcode for Store
        #10;
        $display("Test Case 3 (Store): op = %b, RegWrite = %b, MemWrite = %b, ResultSrc = %b, ALUSrc = %b, ImmSrc = %b, ALUOp = %b, branch = %b", 
                 op, RegWrite, MemWrite, ResultSrc, ALUSrc, ImmSrc, ALUOp, branch);

        // Test Case 4: op = 1100011 (Branch)
        op = 7'b1100011;  // opcode for Branch
        #10;
        $display("Test Case 4 (Branch): op = %b, RegWrite = %b, MemWrite = %b, ResultSrc = %b, ALUSrc = %b, ImmSrc = %b, ALUOp = %b, branch = %b", 
                 op, RegWrite, MemWrite, ResultSrc, ALUSrc, ImmSrc, ALUOp, branch);

        // Test Case 5: op = 0000000 (NOP)
        op = 7'b0000000;  // opcode for NOP (no operation)
        #10;
        $display("Test Case 5 (NOP): op = %b, RegWrite = %b, MemWrite = %b, ResultSrc = %b, ALUSrc = %b, ImmSrc = %b, ALUOp = %b, branch = %b", 
                 op, RegWrite, MemWrite, ResultSrc, ALUSrc, ImmSrc, ALUOp, branch);

        // Test Case 6: op = 1111111 (Undefined)
        op = 7'b1111111;  // opcode for an undefined operation
        #10;
        $display("Test Case 6 (Undefined): op = %b, RegWrite = %b, MemWrite = %b, ResultSrc = %b, ALUSrc = %b, ImmSrc = %b, ALUOp = %b, branch = %b", 
                 op, RegWrite, MemWrite, ResultSrc, ALUSrc, ImmSrc, ALUOp, branch);

        // End of testbench
        $finish;
    end

endmodule
