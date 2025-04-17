module Mux(
    input [31:0] input_a,
    input [31:0] input_b,
    input select,
    output [31:0] output_c
);

    assign output_c = (select) ? input_b : input_a;

endmodule
