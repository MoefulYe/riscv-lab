`include "../03-ALU/ALU.v"

module ALUwithRegHeap(
      input rst,
      input w_en,
      input [4:0] r_addr_a, r_addr_b, w_addr,
      input [3:0] alu_op,
      input reg_clk, alu_clk,
      output [31:0] res,
      output [3:0] flags 
);

wire [31:0] r_data_a, r_data_b;
wire [31:0] w_data;

assign w_data = res;

RegHeap gh(
    reg_clk,
    w_en,
    rst,
    r_addr_a,
    r_data_a,
    r_addr_b,
    r_data_b,
    w_addr,
    w_data
);

ALU alu(
    r_data_a,
    r_data_b,
    alu_clk,
    alu_op,
    res,
    flags
);

endmodule