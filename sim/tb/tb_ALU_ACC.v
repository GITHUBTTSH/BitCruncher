`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/27 14:37:40
// Design Name: 
// Module Name: tb_ALU_ACC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps
module tb_ALU_ACC;

  // 信号定义
  reg clk, rst_n;
  reg C8, C9, C13, C15, C16, C17, C18, C19, C20, C21;
  reg [15:0] BR_out;
  wire [15:0] ALU_out;
  wire [3:0] ALUflags;

  // 实例化待测模块
  ALU_ACC uut (
    .clk(clk),
    .rst_n(rst_n),
    .C8(C8),
    .C9(C9),
    .C13(C13),
    .C15(C15),
    .C16(C16),
    .C17(C17),
    .C18(C18),
    .C19(C19),
    .C20(C20),
    .C21(C21),
    .BR_out(BR_out),
    .ALU_out(ALU_out),
    .ALUflags(ALUflags)
  );

  // 时钟生成，每5ns取反一次
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // 测试激励
  initial begin
    // 初始化所有信号
    rst_n = 0;
    C8 = 0; C9 = 0; C13 = 0; C15 = 0; C16 = 0; 
    C17 = 0; C18 = 0; C19 = 0; C20 = 0; C21 = 0;
    BR_out = 16'h0000;

    // 复位后释放复位信号
    #10;
    rst_n = 1;

    // ---------------------------
    // 测试 1: 清零操作 (C8)
    // ---------------------------
    #10;
    C8 = 1;
    #10;
    C8 = 0;

    // ---------------------------
    // 测试 2: 加法操作 (C9)
    // 先通过加法将 ACC 赋值为10
    // ---------------------------
    #10;
    BR_out = 16'd10;
    C9 = 1;
    #10;
    C9 = 0;

    // 再加 5：ACC = 10 + 5 = 15
    #10;
    BR_out = 16'd5;
    C9 = 1;
    #10;
    C9 = 0;

    // ---------------------------
    // 测试 3: 减法操作 (C13)
    // 例如：ACC = 15 - 3 = 12
    // ---------------------------
    #10;
    BR_out = 16'd3;
    C13 = 1;
    #10;
    C13 = 0;

    // ---------------------------
    // 测试 4: 乘法操作 (C15)
    // 例如：ACC = 12 * 2 = 24
    // ---------------------------
    #10;
    BR_out = 16'd2;
    C15 = 1;
    #10;
    C15 = 0;

    // ---------------------------
    // 测试 5: 除法操作 (C16)
    // 例如：ACC = 24 / 3 = 8 （注意：除0情况需额外处理）
    // ---------------------------
    #10;
    BR_out = 16'd3;
    C16 = 1;
    #10;
    C16 = 0;

    // ---------------------------
    // 测试 6: 右移操作 (C17)
    // ACC 右移1位
    // ---------------------------
    #10;
    C17 = 1;
    #10;
    C17 = 0;

    // ---------------------------
    // 测试 7: 左移操作 (C18)
    // ACC 左移1位
    // ---------------------------
    #10;
    C18 = 1;
    #10;
    C18 = 0;

    // ---------------------------
    // 测试 8: 按位与操作 (C19)
    // 例如：将 ACC 与 BR_out 进行按位与
    // ---------------------------
    #10;
    BR_out = 16'hFF00;
    C19 = 1;
    #10;
    C19 = 0;

    // ---------------------------
    // 测试 9: 按位或操作 (C20)
    // 例如：将 ACC 与 BR_out 进行按位或
    // ---------------------------
    #10;
    BR_out = 16'h00FF;
    C20 = 1;
    #10;
    C20 = 0;

    // ---------------------------
    // 测试 10: 按位取反操作 (C21)
    // 例如：ACC 取反
    // ---------------------------
    #10;
    C21 = 1;
    #10;
    C21 = 0;

    // 结束仿真
    #50;
    $finish;
  end



endmodule

