`include "../include/LedDisplay.v"
module ALUwithRegHeapToppper(
    input [4:0] r_addr_a, r_addr_b, w_addr, //逻辑开关
    input [3:0] alu_op, //逻辑开关
    input w_en,
    input reg_clk, alu_clk, //用按键模拟
    input rst,    //用按键模拟
    input clk,
    output [3:0] flags,
    output [3:0] sel,
    output [7:0] seg
);

wire [31:0] res;

ALUwithRegHeap ar(
    rst,
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

LedDisplay led(
    clk,
    res,
    1'b1,
    sel,
    seg
);

endmodule