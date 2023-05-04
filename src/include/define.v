//opcode编码
`define INST_R      7'b0110011 //R-type
`define INST_I      7'b0010011 //I-type
`define INST_L      7'b0000011 //L-type
`define INST_S      7'b0100011 //S-type
`define INST_B      7'b1100011 //B-type(beq)
`define INST_LUI    7'b0110111 //lui
`define INST_AUIPC  7'b0010111 //auipc 不使用
`define INST_JAL    7'b1101111 //jal
`define INST_JALR   7'b1100111 //jalr

//alu_op编码
`define ALU_ADD_OP      4'b0000
`define ALU_SLL_OP      4'b0001
`define ALU_SLT_OP      4'b0010
`define ALU_SLTU_OP     4'b0011
`define ALU_XOR_OP      4'b0100
`define ALU_SRL_OP      4'b0101
`define ALU_OR_OP       4'b0110
`define ALU_AND_OP      4'b0111
`define ALU_SUB_OP      4'b1000
`define ALU_SRA_OP      4'b1001
`define ALU_ADDU_OP     4'b1010 //扩展不是标准实现,与add区别在标志寄存器的溢出和进位判断上
`define ALU_SUBU_OP     4'b1011 //扩展不是标准实现,与sub区别在标志寄存器的溢出和进位判断上
`define ALU_UNVALID_OP  4'b1111

//pc跳转类型
`define JP_RELATIVE    1'b0    //jal
`define JP_TO_F    1'b1    //jalr

//rhs来自imm32还是B寄存器
`define RHS_FROM_B_REG 1'b0
`define RHS_FROM_IMM32 1'b1

//回写数据来源
`define WB_FROM_IMM32 2'b00 //imm32立即数
`define WB_FROM_F_REG 2'b01 //alu运算结果F寄存器
`define WB_FROM_M_REG 2'b10 //MDR寄存器
`define WB_FROM_P_REG 2'b11 //PC寄存器