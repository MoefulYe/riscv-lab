`define INST_R 7'b0110011
`define INST_I 7'b0010011
`define INST_U 7'b0110111

module InstDecoder2 (
  input [6:0] opcode,
  input [2:0] funct3, 
  input [6:0] funct7,
  output is_r,
  output is_i,
  output is_u,  //不包括auipc
    /// input | op
    /// 0000  | add
    /// 0001  | sll
    /// 0010  | slt
    /// 0011  | sltu
    /// 0100  | xor
    /// 0101  | srl
    /// 0110  | or
    /// 0111  | and
    /// 1000  | sub
    /// 1001  | sra
    /// 1010  | addu 
    /// 1011  | subu
    /// ****  | unvalid
  output [3:0] alu_op
);

assign is_r = (opcode == `INST_R);
assign is_i = (opcode == `INST_I);
assign is_u = (opcode == `INST_U);



endmodule