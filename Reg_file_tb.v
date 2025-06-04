`timescale 1ns/1ps

module Reg_file_tb;

    // Inputs
    reg clk;
    reg rst;
    reg WE3;
    reg [4:0] A1, A2, A3;
    reg [31:0] WD3;

    // Outputs
    wire [31:0] RD1, RD2;

    // Instantiate the DUT (Design Under Test)
    Reg_file uut (
        .A1(A1), .A2(A2), .A3(A3),
        .WD3(WD3), .WE3(WE3),
        .clk(clk), .rst(rst),
        .RD1(RD1), .RD2(RD2)
    );

    // Clock generator
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        $display("==== START TEST ====");
        clk = 0; rst = 1; WE3 = 0;
        A1 = 0; A2 = 0; A3 = 0; WD3 = 0;

        // Reset registers
        #10;
        rst = 0;

        // Write 0xAAAA_BBBB to x1
        A3 = 5'd1; WD3 = 32'hAAAA_BBBB; WE3 = 1;
        #10;
        // Write 0x1234_5678 to x2
        A3 = 5'd2; WD3 = 32'h1234_5678; WE3 = 1;
        #10;
        // Write 0xDEAD_BEEF to x3
        A3 = 5'd3; WD3 = 32'hDEAD_BEEF; WE3 = 1;
        #10;

        // Attempt to write to x0 (should be ignored)
        A3 = 5'd0; WD3 = 32'hFFFF_FFFF; WE3 = 1;
        #10;

        // Read and display
        WE3 = 0;
        A1 = 5'd1; A2 = 5'd2;
        #10;
        $display("x1 = %h, x2 = %h", RD1, RD2); // Expected: AAAA_BBBB, 1234_5678

        A1 = 5'd3; A2 = 5'd0;
        #10;
        $display("x3 = %h, x0 = %h", RD1, RD2); // Expected: DEAD_BEEF, 0000_0000

        $display("==== END TEST ====");
        $stop;
    end

endmodule
// 