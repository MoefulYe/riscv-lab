`include "../include/define.v"

//次级译码模块，主要的功能是从opcode, func3, func7中译出alu_op
module InstDecoder2 (
  input [6:0] opcode,
  input [2:0] funct3, 
  input [6:0] funct7,
  output reg [3:0] alu_op
);

always @(*) begin
  case(opcode)
  `INST_R:begin alu_op <= {funct7[5], funct3}; end
  `INST_I:begin
    alu_op <= (funct3==3'b101)?
                {funct7[5], funct3}: //算术和逻辑移位
                {1'b0, funct3}; //其他
  end
  `INST_L:begin alu_op <= `ALU_ADD_OP; end
  `INST_S:begin alu_op <= `ALU_ADD_OP; end
  `INST_B:begin alu_op <= `ALU_XOR_OP; end
  `INST_JALR:begin alu_op <= `ALU_ADD_OP; end
  default:begin alu_op <= `ALU_UNVALID_OP; end
  endcase 
end

endmodule