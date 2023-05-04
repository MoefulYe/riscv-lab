`define INST_R 7'b0110011 //R-type
`define INST_I 7'b0010011 //I-type
`define INST_L 7'b0000011 //L-type
`define INST_S 7'b0100011 //S-type
`define INST_B 7'b1100011 //B-type
`define INST_LUI  7'b0110111 //lui
`define INST_AUIPC  7'b0010111 //auipc
`define INST_JAL  7'b1101111 //jal
`define INST_JALR  7'b1100111 //jalr


/// input | op      | description
/// 0000  | add     | 
/// 0001  | sll     | 
/// 0010  | slt     |
/// 0011  | sltu    |
/// 0100  | xor     |
/// 0101  | srl     |
/// 0110  | or      |
/// 0111  | and     |
/// 1000  | sub     |
/// 1001  | sra     |
/// 1010  | addu    | 扩展不是标准实现,与add区别在标志寄存器的溢出和进位判断上
/// 1011  | subu    | 扩展不是标准实现,与sub区别在标志寄存器的溢出和进位判断上
/// ****  | unvalid | 
`define ALU_ADD_OP 4'b0000
`define ALU_SLL_OP 4'b0001
`define ALU_SLT_OP 4'b0010
`define ALU_SLTU_OP 4'b0011
`define ALU_XOR_OP 4'b0100
`define ALU_SRL_OP 4'b0101
`define ALU_OR_OP 4'b0110
`define ALU_AND_OP 4'b0111
`define ALU_SUB_OP 4'b1000
`define ALU_SRA_OP 4'b1001
`define ALU_ADDU_OP 4'b1010
`define ALU_SUBU_OP 4'b1011