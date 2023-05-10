//pc更新类型
`define PC_STEP     1'b00 //自增一个指令字
`define PC_JP_R     1'b01 //jal beq
`define PC_JP_F     1'b10 //jalr
`define PC_HOLD     1'b11 //不变