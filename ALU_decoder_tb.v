module alu_decoder_tb;

    // Testbench signals
    reg [1:0] ALUOp;
    reg [2:0] funct3;
    reg [6:0] funct7;
    reg [6:0] op;
    wire [3:0] ALUControl;

    // Instantiate the DUT
    alu_decoder uut (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .op(op),
        .ALUControl(ALUControl)
    );

    // Task for displaying result
    task print_result;
        input [255:0] test_name;
        begin
            $display("%s: ALUOp=%b, funct3=%b, funct7=%b, op=%b => ALUControl=%b", 
                     test_name, ALUOp, funct3, funct7, op, ALUControl);
        end
    endtask

    initial begin
        $display("Starting ALU Decoder Testbench...");
        
        // Test 1: Load (ALUOp = 00 → ADD)
        ALUOp = 2'b00;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        op = 7'b0000011; // Load
        #10 print_result("Test 1 (Load)");

        // Test 2: Branch (ALUOp = 01 → SUB)
        ALUOp = 2'b01;
        op = 7'b1100011;
        #10 print_result("Test 2 (Branch)");

        // Test 3: R-Type ADD
        ALUOp = 2'b10;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        op = 7'b0110011;
        #10 print_result("Test 3 (R-type ADD)");

        // Test 4: R-Type SUB
        funct7 = 7'b0100000;
        #10 print_result("Test 4 (R-type SUB)");

        // Test 5: I-Type ADDI
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        op = 7'b0010011;
        #10 print_result("Test 5 (I-type ADDI)");

        // Test 6: SLL
        funct3 = 3'b001;
        #10 print_result("Test 6 (SLL)");

        // Test 7: SRL
        funct3 = 3'b101;
        funct7[5] = 1'b0;
        #10 print_result("Test 7 (SRL)");

        // Test 8: SRA
        funct7[5] = 1'b1;
        #10 print_result("Test 8 (SRA)");

        // Test 9: OR
        funct3 = 3'b110;
        #10 print_result("Test 9 (OR)");

        // Test 10: AND
        funct3 = 3'b111;
        #10 print_result("Test 10 (AND)");

        // Test 11: SLT
        funct3 = 3'b010;
        #10 print_result("Test 11 (SLT)");

        // Test 12: SLTU
        funct3 = 3'b011;
        #10 print_result("Test 12 (SLTU)");

        // Done
        $display("Finished ALU Decoder Tests.");
        $finish;
    end

endmodule
