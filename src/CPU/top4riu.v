`include "./riu/im_riu.v"
`include "../include/LedDisplay.v"

module MuxOut(
    input [3:0]  watch_stat,
    input [31:0] watch_pc,
    input [31:0] watch_ir,
    input [4:0]  watch_rs1,
    input [4:0]  watch_rs2,
    input [4:0]  watch_rd,
    input [31:0] watch_wb_data,
    input [31:0] watch_imm32,
    input [31:0] watch_lhs,
    input [31:0] watch_rhs,
    input [3:0]  watch_alu_op,
    input [31:0] watch_alu_f,
    input [3:0]  watch_alu_flags,
    input [31:0] watch_mdr,
    input [1:0]  watch_wb_data_sel,
    input [1:0]  watch_pc_update_sel,
    input [3:0] sel,
    output reg [31:0] out
);

parameter SHOW_STAT         = 4'b0000;
parameter SHOW_PC           = 4'b0001;
parameter SHOW_IR           = 4'b0010;
parameter SHOW_RS1          = 4'b0011;
parameter SHOW_RS2          = 4'b0100;
parameter SHOW_RD           = 4'b0101;
parameter SHOW_WB_DATA      = 4'b0110;
parameter SHOW_IMM32        = 4'b0111;
parameter SHOW_LHS          = 4'b1000;
parameter SHOW_RHS          = 4'b1001;
parameter SHOW_ALU_OP       = 4'b1010;
parameter SHOW_ALU_F        = 4'b1011;
parameter SHOW_ALU_FLAGS    = 4'b1100;
parameter SHOW_MDR          = 4'b1101;
parameter SHOW_WB_DATA_SEL  = 4'b1110;
parameter SHOW_PC_UPDATE_SEL= 4'b1111;

always @(*)begin
    case(sel)
        SHOW_STAT:          out = watch_stat;
        SHOW_PC:            out = watch_pc;
        SHOW_IR:            out = watch_ir;
        SHOW_RS1:           out = watch_rs1;
        SHOW_RS2:           out = watch_rs2;
        SHOW_RD:            out = watch_rd;
        SHOW_WB_DATA:       out = watch_wb_data;
        SHOW_IMM32:         out = watch_imm32;
        SHOW_LHS:           out = watch_lhs;
        SHOW_RHS:           out = watch_rhs;
        SHOW_ALU_OP:        out = watch_alu_op;
        SHOW_ALU_F:         out = watch_alu_f;
        SHOW_ALU_FLAGS:     out = watch_alu_flags;
        SHOW_MDR:           out = watch_mdr;
        SHOW_WB_DATA_SEL:   out = watch_wb_data_sel;
        SHOW_PC_UPDATE_SEL: out = watch_pc_update_sel;
    endcase
end

endmodule

module top4riu(
    input led_clk,
    input cpu_clk,
    input rst,
    input [3:0] led_mux_sel,
    output [3:0] sel,
    output [7:0] seg
);

wire [3:0] watch_stat;
wire [31:0] watch_pc;
wire [31:0] watch_ir;
wire [4:0] watch_rs1;
wire [4:0] watch_rs2;
wire [4:0] watch_rd;
wire [31:0] watch_wb_data;
wire [31:0] watch_imm32;
wire [31:0] watch_lhs;
wire [31:0] watch_rhs;
wire [3:0] watch_alu_op;
wire [31:0] watch_alu_f;
wire [3:0] watch_alu_flags;
wire [31:0] watch_mdr;
wire [1:0] watch_wb_data_sel;
wire [1:0] watch_pc_update_sel;

wire [31:0] inst_addr;
wire [31:0] inst;
wire dm_write;
wire [31:0] dm_addr;
wire [31:0] dm_data_in;
wire [31:0] dm_data_out;

CPU cpu(
    cpu_clk,
    rst,
    inst_addr,
    inst,
    dm_write,
    dm_addr,
    dm_data_in,
    dm_data_out,
    watch_stat,
    watch_pc,
    watch_ir,
    watch_rs1,
    watch_rs2,
    watch_rd,
    watch_wb_data,
    watch_imm32,
    watch_lhs,
    watch_rhs,
    watch_alu_op,
    watch_alu_f,
    watch_alu_flags,
    watch_mdr,
    watch_wb_data_sel,
    watch_pc_update_sel
);

IM4riu im(
    cpu_clk,
    inst_addr,
    inst
);

DM dm(
    cpu_clk,
    dm_write,
    dm_addr,
    dm_data_in,
    dm_data_out
);

wire [31:0] mux_out;

MuxOut mux(
    watch_stat,
    watch_pc,
    watch_ir,
    watch_rs1,
    watch_rs2,
    watch_rd,
    watch_wb_data,
    watch_imm32,
    watch_lhs,
    watch_rhs,
    watch_alu_op,
    watch_alu_f,
    watch_alu_flags,
    watch_mdr,
    watch_wb_data_sel,
    watch_pc_update_sel,
    led_mux_sel,
    mux_out
);

LedDisplay led(
    led_clk,
    mux_out,
    1'b1,
    sel,
    seg
);

endmodule