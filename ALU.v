module alu(
    input [31:0] A, B,
    input [3:0] ALUControl,
    output [31:0] Result,
    output Z_flag,
    output N_flag,
    output C_flag,
    output V_flag
);

    wire [31:0] a_and_b = A & B; 
    wire [31:0] a_or_b  = A | B;
    wire [31:0] not_b   = ~B;
    

    wire [31:0] b_mux   = (ALUControl[0] == 1'b0) ? B : not_b;
    wire [31:0] sum;
    wire carry_out;

    assign {carry_out, sum} = A + b_mux + ALUControl[0];

    wire [31:0] slt = ($signed(A) < $signed(B)) ? 32'b1 : 32'b0;
    wire [31:0] sll = A << B;

    reg [31:0] mux_out;

    always @* begin
        case (ALUControl)
            4'b0000: mux_out = sum;                // ADD
            4'b0001: mux_out = sum;                // SUB
            4'b0010: mux_out = a_and_b;            // AND
            4'b0011: mux_out = a_or_b;             // OR
            4'b0100: mux_out = sll;                // SLL
            4'b0101: mux_out = slt;                // SLT (signed)
            4'b0110: mux_out = A ^ B;              // XOR
            4'b0111: mux_out = A >> B;             // SRL
            4'b1000: mux_out = ($unsigned(A) < $unsigned(B)) ? 32'b1 : 32'b0; // SLTU
            4'b1111: mux_out = $signed(A) >>> B;   // SRA
            default: mux_out = 32'bx;
        endcase
    end

    assign Result  = mux_out;
    assign Z_flag  = (Result == 32'b0);            // Zero flag
    assign N_flag  = Result[31];                   // Negative flag
    assign C_flag  = carry_out & ~ALUControl[0];   // Carry only for ADD
    assign V_flag  = (~ALUControl[1]) & (A[31] ^ sum[31]) & ~(A[31] ^ B[31] ^ ALUControl[0]); // Overflow


endmodule