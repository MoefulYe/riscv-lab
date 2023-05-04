//回写数据来源
`define WB_FROM_IMM32 2'b00 //imm32立即数
`define WB_FROM_F_REG 2'b01 //alu运算结果F寄存器
`define WB_FROM_M_REG 2'b10 //MDR寄存器
`define WB_FROM_P_REG 2'b11 //PC寄存器