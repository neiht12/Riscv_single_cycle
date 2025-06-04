`timescale 1ns / 1ps

module tb_Single_Cycle_Top;
    reg clk, rst;
    
    wire [31:0] pc_current, instruction, reg_data1, reg_data2, alu_operand2, alu_result;
    wire [31:0] immediate_extended, data_memory_output, result_to_register;
    wire [31:0] pc_next;

    wire reg_write_enable, mem_write_enable, alu_src_select, result_src_select;
    wire [1:0] immediate_source;
    wire [3:0] alu_control;

    // Khởi tạo mô-đun thiết kế
    Single_Cycle_Top uut (
        .clk(clk),
        .rst(rst)
    );

    // Mô phỏng xung đồng hồ
    always begin
        #5 clk = ~clk;  // Tạo xung đồng hồ với chu kỳ 10ns
    end

    // Khởi tạo và reset tín hiệu
    initial begin
        clk = 0;
        rst = 0;
        #10 rst = 1; // Reset hệ thống
        #10 rst = 0; // Bỏ reset
        
        // Gửi lệnh LW vào bộ nhớ
        uut.I_mem.memory[0] = 32'b00000000000100010010000010010011; // LW x1, 32(x2) (Giả sử lệnh này)
        uut.I_mem.memory[1] = 32'b00000000000000000000000000000000; // Dữ liệu tại địa chỉ 32

        // Cập nhật giá trị trong thanh ghi (x2 = 32 để trỏ vào mem[0])
        uut.Reg_file.Register[2] = 32'd32;  // x2 = 32

        // Kiểm tra trước khi bắt đầu
        #20;

        // Kiểm tra giá trị thanh ghi x1 (sau khi thực thi lệnh LW)
        #20;
        $display("x1 = %d", uut.Reg_file.Register[1]); // In giá trị của x1 (nên là 0x00000000)
        
        // Kết thúc mô phỏng
        #100;
        $finish;
    end
endmodule
