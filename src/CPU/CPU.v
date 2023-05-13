`include "../define/flag.v"
`include "../define/wb_from.v"
`include "./CU.v"
`include "../07-inst-fetch-decode/InstDecoder1.v"
`include "./PC.v"
`include "../04-reg-heap/RegHeap.v"
`include "../03-ALU/ALU.v"

module ALURhsMux(
    input [31:0] B,
    input [31:0] inst_imm32,
    input alu_rhs_sel,
    output reg [31:0] alu_rhs
);

always@(*)begin
    case(alu_rhs_sel)
    `RHS_FROM_B_REG: alu_rhs <= B;
    `RHS_FROM_IMM32: alu_rhs <= inst_imm32;
    endcase
end

endmodule

module RegWriteBackMux(
    input [31:0] inst_imm32,
    input [31:0] alu_f,
    input [31:0] mdr,
    input [31:0] next_inst_addr,
    input [1:0] reg_writeback_sel,
    output reg [31:0] wb_data
);

always @(*) begin
    case(reg_writeback_sel)
        `WB_FROM_IMM32: wb_data <= inst_imm32;
        `WB_FROM_F_REG: wb_data <= alu_f;
        `WB_FROM_M_REG: wb_data <= mdr;
        `WB_FROM_P_REG: wb_data <= next_inst_addr;
    endcase
end

endmodule

//
module CPU(
    input clk,
    input rst,
    //与指令存储器相连
    output [31:0] inst_addr,
    input [31:0] inst,  //IFID阶段从指令存储器中读出的指令
    //与数据存储器相连
    output dm_write,
    output [31:0] dm_addr,
    output [31:0] dm_data_in,
    input [31:0] dm_data_out,
    //侵入式接口暴露CPU内部信息
    output [3:0] watch_stat,
    output [31:0] watch_pc,
    output [31:0] watch_ir,
    output [4:0] watch_rs1,
    output [4:0] watch_rs2,
    output [4:0] watch_rd,
    output [31:0] watch_wb_data,
    output [31:0] watch_imm32,
    output [31:0] watch_lhs,
    output [31:0] watch_rhs,
    output [3:0] watch_alu_op,
    output [31:0] watch_alu_f,
    output [3:0] watch_alu_flags,
    output [31:0] watch_mdr,
    output [1:0] watch_wb_data_sel,
    output [1:0] watch_pc_update_sel
);

//控制信号
wire pc_cur_write;
wire pc_next_write;
wire ir_write;
wire regs_write;
//wire dm_write;

//选择信号
wire [1:0] pc_update_sel;
wire alu_rhs_sel;
wire [1:0] reg_writeback_sel;

wire [31:0] pc_cur;
assign inst_addr = pc_cur;
wire [31:0] pc_next;

reg [31:0] ir;

wire [4:0] reg_rs1, reg_rs2, reg_rd;
wire [31:0] reg_wb_data;

wire [6:0] inst_opcode;
wire [2:0] inst_func3;
wire [6:0] inst_func7;
wire [31:0] inst_imm32;

wire [31:0] A, B;

wire [31:0] alu_lhs;
assign alu_lhs = A;
wire [31:0] alu_rhs;
wire [3:0] alu_op;
wire [31:0] alu_f;
wire [3:0] alu_flags;

assign dm_addr = alu_f;
assign dm_data_in = B;

assign  watch_pc = pc_cur;
assign  watch_ir = ir;
assign  watch_rs1 = reg_rs1;
assign  watch_rs2 = reg_rs2;
assign  watch_rd = reg_rd;
assign  watch_wb_data = reg_wb_data;
assign  watch_lhs = alu_lhs;
assign  watch_rhs = alu_rhs;
assign  watch_imm32 = inst_imm32;
assign  watch_alu_op = alu_op;
assign  watch_alu_f = alu_f;
assign  watch_alu_flags = alu_flags;
assign  watch_mdr = dm_data_out;
assign  watch_wb_data_sel = reg_writeback_sel;
assign  watch_pc_update_sel = pc_update_sel;

CU cu(
    rst,
    clk,
    inst_opcode,
    inst_func3,
    inst_func7,
    alu_flags[`FLAG_IS_ZERO],
    pc_cur_write,
    pc_next_write,
    pc_update_sel,
    ir_write,
    regs_write,
    dm_write,
    alu_op,
    alu_rhs_sel,
    reg_writeback_sel,
    watch_stat
);

ALURhsMux alu_rhs_mux(
    B,
    inst_imm32,
    alu_rhs_sel,
    alu_rhs
);

RegWriteBackMux rwbm(
    inst_imm32,
    alu_f,
    dm_data_out,
    pc_next,
    reg_writeback_sel,
    reg_wb_data
);

PC pc(
    clk,
    rst,
    pc_next_write,
    pc_cur_write,
    pc_update_sel,
    alu_f,
    inst_imm32,
    pc_next,
    pc_cur
);

always @(negedge clk) begin
    if(ir_write)begin
        ir <= inst;
    end
end

InstDecoder1 id1(
    ir,
    reg_rs1,
    reg_rs2,
    reg_rd,
    inst_imm32,
    inst_opcode,
    inst_func3,
    inst_func7
);

RegHeap gh(
    clk,
    regs_write,
    rst,
    1'b0,  //no test
    reg_rs1,
    A,
    reg_rs2,
    B,
    reg_rd,
    reg_wb_data
);

ALU alu(
    alu_lhs,
    alu_rhs,
    clk,
    alu_op,
    alu_f,
    alu_flags
);

endmodule
