`include "../include/define.v"

module InstDecoder1(
  input [31:0] inst,
  output reg [4:0] rs1, rs2, rd,
  output reg [31:0] imm32,
  output reg [6:0] opcode,
  output reg [2:0] funct3, 
  output reg [6:0] funct7 
);

always @(*) begin
  opcode <= inst[6:0];
  rs1 <= inst[19:15];
  rs2 <= inst[24:20];
  rd <= inst[11:7];
  funct3 <= inst[14:12];
  funct7 <= inst[31:25];
  
  case(opcode)
  `INST_R: begin imm32 <= 0; end
  `INST_I: begin 
    imm32 <= (inst[14:12]==3'b101 && inst[30]==1'b1) ?
              {27'b0, inst[24:20]}: //对应srai指令
              {{20{inst[31]}}, inst[31:20]};    
   end 
  `INST_L: begin imm32 <= {{20{inst[31]}}, inst[31:20]} ;end
  `INST_S: begin imm32 <= {{20{inst[31]}}, inst[31:25], inst[11:7]} ;end
  `INST_B: begin imm32 <= {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0} ;end
  `INST_LUI: begin imm32 <= {inst[31:12], 12'b0} ;end
  `INST_AUIPC: begin imm32 <= {inst[31:12], 12'b0} ;end
  `INST_JAL: begin imm32 <= {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0} ;end
  `INST_JALR: begin imm32 <= {{20{inst[31]}}, inst[31:20]} ;end
  default: begin imm32 <= 0;end
  endcase

end

endmodule