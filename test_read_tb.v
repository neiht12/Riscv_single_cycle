`timescale 1ns/1ps
module lw_test_tb;

    // Inputs
    reg clk, rst, WE3;
    reg [4:0] A1, A2, A3;
    reg [31:0] WD3;

    // Outputs
    wire [31:0] RD1, RD2;

    // Memory
    wire [31:0] alu_out, data_out;

    // ALU (simulate effective address)
    assign alu_out = RD1 + 0; // offset = 0 for lw

    // Instantiate Register File
    Reg_file rf (
        .A1(A1),    // source register for address (x2)
        .A2(A2),    // unused
        .A3(A3),    // destination register (x1)
        .WD3(WD3),
        .WE3(WE3),
        .clk(clk),
        .rst(rst),
        .RD1(RD1),
        .RD2(RD2)
    );

    // Instantiate Data Memory
    Data_Memory mem (
        .clk(clk),
        .rst(~rst),
        .WE(1'b0),
        .WD(32'b0),
        .A(alu_out),
        .RD(data_out)
    );

    // Clock generator
    always #5 clk = ~clk;

    initial begin
        $display("== Test lw x1, 0(x2) ==");

        // Initialization
        clk = 0; rst = 1; WE3 = 0;
        A1 = 5'd0; A2 = 5'd0; A3 = 5'd0; WD3 = 32'b0;

        #10;
        rst = 0;

        // Step 1: Write 40 to x2
        A3 = 5'd2;        // x2
        WD3 = 32'd40;     // address 40
        WE3 = 1;
        #10;
        WE3 = 0;
        #10;

        // Step 2: Setup A1 to read x2 (source address)
        A1 = 5'd2;        // x2
        #10;              // wait for RD1 to update

        $display("x2 = %h", RD1);
        $display("alu_out = %h", alu_out);

        // Step 3: Wait for memory read
        #10;

        $display("Memory Read @%h = %h", alu_out, data_out);

        // Step 4: Write data_out to x1
        A3 = 5'd1;        // x1
        WD3 = data_out;
        WE3 = 1;
        #10;
        WE3 = 0;
        #10;

        // Step 5: Read back x1
        A1 = 5'd1;
        #10;
        $display("x1 = %h (expected 0x12345678)", RD1);

        $finish;
    end
endmodule
