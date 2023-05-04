module InstDecoder1(
  input [31:0] inst,
  output reg [4:0] rs1, rs2, rd,
  output reg [31:0] imm32,
  output reg [6:0] opcode,
  output reg [2:0] funct3, 
  output reg [6:0] funct7 
);

parameter INST_R = 7'b0110011;
parameter INST_I = 7'b0010011;
parameter INST_L = 7'b0000011;
parameter INST_S = 7'b0100011;
parameter INST_B = 7'b1100011;
parameter INST_U1 = 7'b0110111;
parameter INST_U2 = 7'b0010111;
parameter INST_J1 = 7'b1101111;
parameter INST_J2 = 7'b1100111;

always @(*) begin
  opcode <= inst[6:0];
  rs1 <= inst[19:15];
  rs2 <= inst[24:20];
  rd <= inst[11:7];
  funct3 <= inst[14:12];
  funct7 <= inst[31:25];
  
  case(opcode)
  INST_R: begin imm32 <= 0; end
  //这里做了点取巧并不是完全地遵守riscv32规范 对于移位运算的立即数拓展应该是u32(shamt) 而不是i32(inst[31:20])
  //这样做逻辑左移和右移是没有区别的，但是算术右移的高第二位变成了1,用这1位可以区分算术右移和逻辑右移
  //要区分逻辑右移和算术右移要额外考虑funct3,大大增加了逻辑复杂度
  INST_I: begin imm32 <= {{20{inst[31]}}, inst[31:20]} ;end 
  INST_L: begin imm32 <= {{20{inst[31]}}, inst[31:20]} ;end
  INST_S: begin imm32 <= {{20{inst[31]}}, inst[31:25], inst[11:7]} ;end
  INST_B: begin imm32 <= {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0} ;end
  INST_U1: begin imm32 <= {inst[31:12], 12'b0} ;end
  INST_U2: begin imm32 <= {inst[31:12], 12'b0} ;end
  INST_J1: begin imm32 <= {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0} ;end
  INST_J2: begin imm32 <= {{20{inst[31]}}, inst[31:20]} ;end
  default: begin imm32 <= 0;end
  endcase

end

endmodule