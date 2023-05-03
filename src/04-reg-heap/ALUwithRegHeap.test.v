`timescale 1ns/1ps

module ALUwithRegHeapTester();

reg rst_n;
reg w_en;
reg [4:0] r_addr_a, r_addr_b, w_addr;
reg [3:0] alu_op;
reg reg_clk, alu_clk;
wire [31:0] res;
wire [3:0] flags;

ALUwithRegHeap ar(
    rst_n,
    w_en,
    r_addr_a,
    r_addr_b,
    w_addr,
    alu_op,
    reg_clk,
    alu_clk,
    res,
    flags
);

always #5 reg_clk = ~reg_clk;
always #5 alu_clk = ~alu_clk;

initial begin
    reg_clk = 0;
    alu_clk = 0;
    rst_n = 1;
    w_en = 0;
    r_addr_a = 0;
    r_addr_b = 0;
    w_addr = 0;
    alu_op = 0;
    #100
    rst_n = 0;
    #100
    rst_n = 0;
    #100
    w_en = 1;
    r_addr_a = 5'b00000;
    r_addr_b = 5'b00001;
    w_addr = 5'b00010;
    alu_op = 4'b1100;
    #100
    w_en = 1;
    r_addr_a = 5'b00010;
    r_addr_b = 5'b00001;
    w_addr = 5'b00011;
    alu_op = 4'b1010;
    #100
    w_en = 0;
    r_addr_a = 5'b00011;
    r_addr_b = 5'b00010;
    w_addr = 5'b00100;
    alu_op = 4'b0010;
end

endmodule