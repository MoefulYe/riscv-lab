`include "./CU.v"
`include "../07-inst-fetch-decode/InstDecoder1.v"
`include "./PC.v"
`include "../04-reg-heap/RegHeap.v"
`include "../03-ALU/ALU.v"

module CPU(
    input clk,
    input rst,
    output [31:0] inst_addr,
    input [31:0] inst,  //IFID阶段从指令存储器中读出的指令
    output dm_write,
    output [31:0] dm_addr,
    output [31:0] dm_data_in,
    input [31:0] dm_data_out
);

wire pc_go_next;
wire pc_jump;
wire pc_jump_sel;

reg [31:0] ir;
wire ir_write;

wire [4:0] rs1, rs2, rd;
wire [31:0] imm32;
wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;

wire regs_write;
wire [31:0] A,B;
wire AeqB = (A == B);
wire [31:0] p_m_f_imm32 [3:0];
assign p_m_f_imm32 = {inst_addr, dm_data_out, alu_f, imm32};
wire [31:0] write_back;
wire [1:0] wb_sel;
assign write_back = p_m_f_imm32[wb_sel];

wire [3:0] alu_op;
wire lhs;
assign lhs = A;
wire [31:0] imm32_B [1:0];
assign imm32_B = {imm32, B};
wire [31:0] rhs;
wire alu_rhs_sel;
assign rhs = imm32_B[alu_rhs_sel]
wire [3:0] alu_op;
wire [31:0] alu_f;
wire [3:0] alu_flags;

CU cu(
  rst,
  clk,
  opcode,
  funct3,
  funct7,
  AeqB,
  pc_go_next,
  pc_jump,
  pc_jump_sel,
  ir_write,
  regs_write,
  dm_write,
  alu_op,
  alu_rhs_sel,
  wb_sel 
);

//PC模块
PC pc(
    clk,
    rst,
    pc_go_next,
    pc_jump,
    pc_jump_sel,
    alu_f,
    imm32,
    inst_addr
);

//IR模块
always @(negedge clk) begin
    if(ir_write)begin
        ir <= inst;
    end
end

//ID1
InstDecoder1 id1(
    ir,
    rs1,
    rs2,
    rd,
    imm32,
    opcode,
    funct3,
    funct7
);

//RegHeap
RegHeap gh(
    clk,
    regs_write,
    rst,
    rs1,
    A,
    rs2,
    B,
    rd,
    w_data
);

//ALU
ALU alu(
    lhs,
    rhs,
    clk,
    alu_op,
    alu_f,
    alu_flags
);

endmodule