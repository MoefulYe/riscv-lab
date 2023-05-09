`include "../define/opcode.v"
`include "../define/pc_jump.v"
`include "../define/rhs_from.v"
`include "../define/wb_from.v"

`include "./InstDecoder2.v"
`include "./PC.v"

module CU (
    input rst,  //复位信号
    input clk,
    input [6:0] opcode,
    input [2:0] funct3, 
    input [6:0] funct7,
    input zf, //beq命令有用，alu做异或操作，为0则zf=1
    output reg pc_step, pc_jump, //控制pc自增和跳转
    output reg pc_jump_sel, //jump模式选择
    output reg ir_write, //控制ir寄存器写
    output reg regs_write, //控制寄存器堆写操作
    output reg dm_write, //控制数据存储器写
    output [3:0] alu_op, //alu操作码
    output reg alu_rhs_sel,  //alu右操作数来源
    output reg [1:0] wb_sel //回写到rd寄存器的数据来源
);

///IF取指令 
///PI pc inc 
///ID初级译码器译码
///IFID: 取指令,并译码 下降沿pc自增
///RR读寄存器 到 暂存器 A, B
///EX(I,B) 执行计算指明右操作数是立刻数还是寄存器B
///M(R,W)访存 从F寄存器读取访问地址，从w_data写入存储器/读出数据写入MDR寄存器
///WB(I,F,M,P) 从立刻数/ALU运算结果/数据存储器数据寄存器/PC寄存器写入寄存器堆
///JP(F,R) F写入PC寄存器/相对跳转
///BEQ 如果相等则（相对）跳转
///WBP_JPR 从PC寄存器写入rd，然后相对跳转
///WBP_JPF 从PC寄存器写入rd，然后把F寄存器的数据写入PC寄存器

parameter ENABLE    = 1'b1;
parameter DISABLE   = 1'b0;

InstDecoder2 id2(opcode, funct3, funct7, alu_op);

//对每一步的操作进行编码并把状态保存在stat和next_stat寄存器
parameter IDLE      = 4'b0000;
parameter IFID      = 4'b0001;
parameter RR        = 4'b0010;
parameter EXI       = 4'b0011;
parameter EXB       = 4'b0100; 
parameter MR        = 4'b0101; 
parameter MW        = 4'b0110; 
parameter WBI       = 4'b0111;
parameter WBF       = 4'b1000;
parameter WBM       = 4'b1001;
parameter WBP_JPF   = 4'b1010;
parameter WBP_JPR   = 4'b1011;
parameter BEQ       = 4'b1100;

reg [3:0] stat, next_stat;

//状态转移
always @(posedge rst or posedge clk) begin
    if(rst) stat <= IDLE;
    else stat <= next_stat;
end

///外部状态 opcode
///内部状态 stat
///R-type:       IFID -> RR -> EXB -> WBF -> IFID
///I-type:       IFID -> RR -> EXI -> WBF -> IFID
///U-type(lui):  IFID -> WBI -> IFID
///L-type(lw):   IFID -> RR -> EXI -> MR -> WBM -> IFID
///S-type(sw):   IFID -> RR -> EXI -> MW -> IFID
///B-type(beq):  IFID -> RR -> EXB -> BEQ -> IFID
///J-type(jal):  IFID -> WBP_JPR -> IFID
///J-type(jalr): IFID -> RR -> EXI -> WBP_JPF -> IFID

//确定下一个状态
always @(*) begin
    case(stat)
    IDLE: next_stat = IFID; 
    IFID: begin
        case(opcode)
        `INST_R: next_stat      = RR;
        `INST_I: next_stat      = RR;
        `INST_LUI: next_stat    = WBI;
        `INST_L: next_stat      = RR;
        `INST_S: next_stat      = RR;
        `INST_B: next_stat      = RR;
        `INST_JAL: next_stat    = WBP_JPR;
        `INST_JALR: next_stat   = RR;
        default: next_stat      = IFID;
        endcase
    end
    RR: begin
        case(opcode)
        `INST_R: next_stat      = EXB;
        `INST_I: next_stat      = EXI;
        `INST_L: next_stat      = EXI;
        `INST_S: next_stat      = EXI;
        `INST_B: next_stat      = EXB;
        `INST_JALR: next_stat   = EXI;
        default: next_stat      = IFID;
        endcase
    end
    EXI: begin
        case(opcode)
        `INST_I: next_stat      = WBF;
        `INST_L: next_stat      = MR;
        `INST_S: next_stat      = MW;
        `INST_JALR: next_stat   = WBP_JPF;
        default: next_stat      = IFID;
        endcase
    end
    EXB: begin
        case(opcode)
        `INST_R: next_stat      = WBF;
        `INST_B: next_stat      = BEQ;
        default: next_stat      = IFID;
        endcase
    end
    MR: next_stat               = WBM;
    MW: next_stat               = IFID;
    WBI: next_stat              = IFID;
    WBF: next_stat              = IFID;
    WBM: next_stat              = IFID;
    WBP_JPF: next_stat          = IFID;
    WBP_JPR: next_stat          = IFID;
    BEQ: next_stat              = IFID;
    default: next_stat          = IFID;
    endcase
end 

assign pc_rst = rst;

//根据状态执行操作
always @(posedge rst or posedge clk) begin
    if(rst) begin
       pc_step <= DISABLE; 
       pc_jump <= DISABLE;
       ir_write <= DISABLE;
       regs_write <= DISABLE;
       dm_write <= DISABLE;
    end else begin
        case(next_stat)
        IDLE: begin
            pc_step     <= DISABLE; 
            pc_jump     <= DISABLE;
            ir_write    <= DISABLE;
            regs_write  <= DISABLE;
            dm_write    <= DISABLE;
        end
        IFID: begin
            pc_step     <= ENABLE; 
            pc_jump     <= DISABLE;
            ir_write    <= ENABLE;
            regs_write  <= DISABLE;
            dm_write    <= DISABLE;
        end
        RR: begin
            pc_step     <= DISABLE; 
            pc_jump     <= DISABLE;
            ir_write    <= DISABLE;
            regs_write  <= DISABLE;
            dm_write    <= DISABLE;
        end
        EXI: begin
            pc_step     <= DISABLE;
            pc_jump     <= DISABLE;
            ir_write    <= DISABLE;
            regs_write  <= DISABLE;
            alu_rhs_sel <= `RHS_FROM_IMM32;
            dm_write    <= DISABLE;
        end
        EXB: begin
            pc_step     <= DISABLE;
            pc_jump     <= DISABLE;
            ir_write    <= DISABLE;
            regs_write  <= DISABLE;
            alu_rhs_sel <= `RHS_FROM_B_REG;
            dm_write    <= DISABLE;
        end
        MR: begin
            pc_step     <= DISABLE;
            pc_jump     <= DISABLE;
            ir_write    <= DISABLE;
            regs_write  <= DISABLE;
            dm_write    <= DISABLE;
        end
        MW: begin
            pc_step     <= DISABLE;
            pc_jump     <= DISABLE;
            ir_write    <= DISABLE;
            regs_write  <= DISABLE;
            dm_write    <= ENABLE;
        end
        WBI: begin
            pc_step     <= DISABLE;
            pc_jump     <= DISABLE;
            ir_write    <= DISABLE;
            regs_write  <= ENABLE;
            wb_sel      <= `WB_FROM_IMM32;
            dm_write    <= DISABLE;
        end
        WBF: begin
            pc_step     <= DISABLE;
            pc_jump     <= DISABLE;
            ir_write    <= DISABLE;
            regs_write  <= ENABLE;
            wb_sel      <= `WB_FROM_F_REG;
            dm_write    <= DISABLE;
        end
        WBM: begin
            pc_step     <= DISABLE;
            pc_jump     <= DISABLE;
            ir_write    <= DISABLE;
            regs_write  <= ENABLE;
            wb_sel      <= `WB_FROM_M_REG;
            dm_write    <= DISABLE;
        end
        WBP_JPF: begin
            pc_step     <= DISABLE;
            pc_jump     <= ENABLE;
            pc_jump_sel <= `JP_TO_F;
            ir_write    <= DISABLE;
            regs_write  <= ENABLE;
            wb_sel      <= `WB_FROM_P_REG;
            dm_write    <= DISABLE;
        end
        WBP_JPR: begin
            pc_step     <= DISABLE;
            pc_jump     <= ENABLE;
            pc_jump_sel <= `JP_RELATIVE;
            ir_write    <= DISABLE;
            regs_write  <= ENABLE;
            wb_sel      <= `WB_FROM_P_REG;
            dm_write    <= DISABLE;
        end
        BEQ: begin
            pc_step     <= DISABLE;
            pc_jump     <= zf;
            pc_jump_sel <= `JP_RELATIVE;
            ir_write    <= DISABLE;
            regs_write  <= DISABLE;
            dm_write    <= DISABLE;
        end
        default: begin
            pc_step     <= DISABLE; 
            pc_jump     <= DISABLE;
            ir_write    <= DISABLE;
            regs_write  <= DISABLE;
            dm_write    <= DISABLE;
        end
        endcase
    end
end
    
endmodule