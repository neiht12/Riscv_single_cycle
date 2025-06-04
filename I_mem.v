module I_mem(A, rst, RD);
    input [31:0] A;
    input rst;
    output reg [31:0] RD;  // Chuyển sang kiểu reg để tránh sự cố

    reg [31:0] mem [1023:0];  // Mảng bộ nhớ

    always @(*) begin
        if (~rst)  // Nếu reset, gán giá trị bằng 0
            RD = 32'd0;
        else
            RD = mem[A[31:2]];  // Truy xuất bộ nhớ tại vị trí A[31:2]
    end

    initial begin
    // 
    mem[0] = 32'hFFC4A303;
    mem[1]  = 32'h0064A423; 
    mem[2]  = 32'h0062E233;// 


    
    // // Hiển thị thông tin khởi tạo
    // $display("I_mem[0] = %h", mem[0]);
    // $display("I_mem[1] = %h", mem[1]);
    // $display("I_mem[2] = %h", mem[2]);
end
endmodule
