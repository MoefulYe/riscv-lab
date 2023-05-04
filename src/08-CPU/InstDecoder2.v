`include "../include/define.v"

module InstDecoder2 (
  input [6:0] opcode,
  input [2:0] funct3, 
  input [6:0] funct7,
  //u只有lui不考虑auipc
  output reg is_r, is_i, is_u, 
  output reg [3:0] alu_op
);

always @(*) begin
  case(opcode)
  `INST_R:begin 
    {is_r, is_i, is_u} <= 3'b100;
    alu_op <= {funct7[5], funct3};
  end
  `INST_I:begin
    {is_r, is_i, is_u} <= 3'b010;
    alu_op <= (funct3==3'b101)?
                {funct7[5], funct3}: //算术和逻辑移位
                {1'b0, funct3}; //其他
  end
  `INST_U1:begin
    {is_r, is_i, is_u} <= 3'b001;
    alu_op <= 4'b0000;
  end

  endcase 
end

endmodule