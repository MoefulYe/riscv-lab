//pc更新类型
`define PC_STEP     2'b00 //自增一个指令字
`define PC_JP_R     2'b01 //jal beq
`define PC_JP_F     2'b10 //jalr
`define PC_HOLD     2'b11 //不变