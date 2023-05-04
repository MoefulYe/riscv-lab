`include "./InstDecoder2.v"


module CU (
    input rst,  //复位信号
    input clk,
    input [6:0] opcode,
    input [2:0] funct3, 
    input [6:0] funct7,
    output reg pc_go_next, pc_jump, //控制pc自增和跳转
    output reg pc_jump_sel, //jump模式选择
    output reg ir_write, //控制ir寄存器写
    output reg regs_write, //控制寄存器堆写操作
    output reg dm_write, //控制数据存储器写
    output [3:0] alu_op, //alu操作码
    output alu_rhs_sel,  //alu右操作数来源
    output [1:0] wb_sel, //回写到rd寄存器的数据来源
);

assign pc_rst = rst;

///IF取指令 
///PI pc inc 
///ID初级译码器译码
///IFID: 上升沿取指令,并译码 下降沿pc自增
///RR读寄存器 到 暂存器 A, B
///EX(I,B) 执行计算指明右操作数是立刻数还是寄存器B
///M(R,W)访存 从F寄存器读取访问地址，从w_data写入存储器/读出数据写入MDR寄存器
///WB(I,F,M,P) 从立刻数/ALU运算结果/数据存储器数据寄存器/PC寄存器写入寄存器堆
///JP(F,R) 旧地址写入rd F写入PC寄存器/相对跳转 


InstDecoder2 id2(opcode, funct3, funct7, alu_op);

//对每一步的操作进行编码并把状态保存在stat和next_stat寄存器
parameter IDLE  = 4'b0000;
parameter IFID  = 4'b0001;
parameter RR    = 4'b0010;
parameter EXI   = 4'b0011;
parameter EXB   = 4'b0101; 
parameter MR    = 4'b0100; 
parameter MW    = 4'b0110; 
parameter WBI   = 4'b0111;
parameter WBF   = 4'b1000;
parameter WBM   = 4'b1001;
parameter WBP   = 4'b1010;
parameter JPF   = 4'b1011;
parameter JPR   = 4'b1100;

reg [3:0] stat, next_stat;

//状态转移
always @(posedge rst or posedge clk) begin
    if(rst) stat <= IDLE;
    else stat <= next_stat;
end

//外部状态 opcode
//内部状态 stat
//R-type:       IFID -> RR -> EXB -> WBF -> IFID
//I-type:       IFID -> RR -> EXI -> WBF -> IFID
//U-type(lui):  IFID -> WBI -> IFID
//L-type(lw):   IFID -> RR -> EXI -> MR -> WBM -> IFID
//S-type(sw):   IFID -> RR -> EXI -> MW -> IFID
//B-type(beq):  IFID -> RR -> EXB -> JPR(使用xor计算，相等时为0,是否真正跳转由PC的jump是否为0决定) -> IFID
//J-type(jal):  IFID -> JPR -> IFID
//J-type(jalr): IFID -> RR -> EXI -> JPF -> IFID

//确定下一个状态
always @(*) begin
    case(stat)
    IDLE: next_stat = IFID; 
    IFID: begin
        case(opcode)
        `INST_R: next_stat = RR;
        `INST_I: next_stat = RR;
        `INST_LUI: next_stat = WBI;
        `INST_L: next_stat = RR;
        `INST_S: next_stat = RR;
        `INST_B: next_stat = RR;
        `INST_JAL: next_stat = JPR;
        `INST_JALR: next_stat = RR;
        default: next_stat = IFID;
        endcase
    end
    RR: begin
        case(opcode)
        `INST_R: next_stat = EXB;
        `INST_I: next_stat = EXI;
        `INST_L: next_stat = EXI;
        `INST_S: next_stat = EXI;
        `INST_B: next_stat = EXB;
        `INST_JALR: next_stat = EXI;
        default: next_stat = IFID;
        endcase
    end
    EXI: begin
        case(opcode)
        `INST_I: next_stat = WBF;
        `INST_L: next_stat = MR;
        `INST_S: next_stat = MW;
        `INST_JALR: next_stat = JPF;
        default: next_stat = IFID;
        endcase
    end
    EXB: begin
        case(opcode)
        `INST_R: next_stat = WBF;
        `INST_B: next_stat = JPR;
        default: next_stat = IFID;
        endcase
    end
    MR: next_stat = WBM;
    MW: next_stat = IFID;
    WBI: next_stat = IFID;
    WBF: next_stat = IFID;
    WBM: next_stat = IFID;
    WBP: next_stat = IFID;
    JPF: next_stat = IFID;
    JPR: next_stat = IFID;
    default: next_stat = IFID;
    endcase
end 

//根据状态执行操作
always @(posedge rst or posedge clk) begin
    if(rst) begin
    pc_write <= 1'b0;
    ir_write <= 1'b0;
    regs_write <= 1'b0;
    end else begin
    case(next_stat)
    endcase
    end
end
    
endmodule