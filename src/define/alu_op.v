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
`define ALU_SRA_OP      4'b1101
`define ALU_ADDU_OP     4'b1010 //扩展不是标准实现,与add区别在标志寄存器的溢出和进位判断上
`define ALU_SUBU_OP     4'b1011 //扩展不是标准实现,与sub区别在标志寄存器的溢出和进位判断上
`define ALU_UNVALID_OP  4'b1111
