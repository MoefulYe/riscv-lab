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
