`timescale 1ns / 1ps

`include "./riu/im_riu.v"
module test4riu();

reg clk = 0;
reg rst = 0;

initial begin
    forever begin
        #2 clk = ~clk;
    end
end

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
    clk,
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
    clk,
    inst_addr,
    inst
);

DM dm(
    clk,
    dm_write,
    dm_addr,
    dm_data_in,
    dm_data_out
);

initial begin
    #10 rst = 1;
    #10 rst = 0;
    #4000 $finish;
end

endmodule
