//时分复用输入
//运算ALU
//数显 
`include "../include/LedDisplay.v"

module Mux(
    input [31:0] data,
    input clk_a,
    input clk_b,
    input clk_op,
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
    input clk,
    output [3:0] flags,
    output [3:0] sel, 
    output [7:0] seg
);

wire [31:0] operandA;
wire [31:0] operandB;
wire [3:0] op;
wire [31:0] res;
wire alu_clk;
wire led_clk;

IPClock clock(
    // Clock out ports
    .clk_10M(alu_clk),     // output clk_10M
    .clk_100M(led_clk),     // output clk_100M
    // Status and control signals
    .reset(1'b0), // input reset 0时不重置
    .locked(),       // output locked
   // Clock in ports
    .clk_in(clk)      // input clk_in
);


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
    alu_clk,
    op,
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