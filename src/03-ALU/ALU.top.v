//时分复用输入
//运算ALU
//数显 
`include "../include/Divider.v"
`include "../include/LedDisplay.v"
module Mux(
    input [31:0] data,
    input clk_a,
    input clk_b,
    input clk_op,
    input clk,
    output reg [31:0] operandA,
    output reg [31:0] operandB,
    output reg [3:0] op
);
always @(posedge clk_a) operandA <= data;
always @(posedge clk_b) operandB <= data;
always @(posedge clk_op) op <= data[31:28];
endmodule

module ALUTopper(
    input [31:0] data,
    input clk_a,
    input clk_b,
    input clk_op,
    output [3:0] flags,
    output [3:0] sel, 
    output [7:0] seg 
);

wire [31:0] operandA;
wire [31:0] operandB;
wire [3:0] op;
wire [31:0] res;
wire clk2;

Divider #(20000) d2(clk, clk2);

Mux mux(
    data,
    clk_a,
    clk_b,
    clk_op,
    operandA,
    operandB,
    op
);

ALU alu(
    operandA,
    operandB,
    op,
    res,
    flags
);

LedDisplay led(
    clk2,
    res,
    1'b0,
    sel,
    seg
);

endmodule