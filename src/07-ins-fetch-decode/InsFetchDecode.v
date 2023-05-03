module PC(
  input clk,
  input rst,
  input pc_write,
  output reg [7:0] addr
);

always @(negedge clk or posedge rst) begin
  if(rst)begin
    addr <= 0;
  end else if(pc_write)begin
    addr <= addr + 4;
  end
end
endmodule

module InsDecoder1(
  input [31:0] ins,
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
  opcode <= ins[6:0];
  rs1 <= ins[19:15];
  rs2 <= ins[24:20];
  rd <= ins[11:7];
  funct3 <= ins[14:12];
  funct7 <= ins[31:25];
  
  case(opcode)
  INST_R: begin imm32 <= 0; end
  INST_I: begin imm32 <= {{20{ins[31]}}, ins[31:20]} ;end
  INST_L: begin imm32 <= {{20{ins[31]}}, ins[31:20]} ;end
  INST_S: begin imm32 <= {{20{ins[31]}}, ins[31:25], ins[11:7]} ;end
  INST_B: begin imm32 <= {{20{ins[31]}}, ins[7], ins[30:25], ins[11:8], 1'b0} ;end
  INST_U1: begin imm32 <= {ins[31:12], 12'b0} ;end
  INST_U2: begin imm32 <= {ins[31:12], 12'b0} ;end
  INST_J1: begin imm32 <= {{12{ins[31]}}, ins[19:12], ins[20], ins[30:21], 1'b0} ;end
  INST_J2: begin imm32 <= {{20{ins[31]}}, ins[31:20]} ;end
  default: begin imm32 <= 0;end
  endcase

end

endmodule


module InsFetchDecode(
  input clk,
  input rst_pc,
  input pc_write,
  input ir_write,
  output [4:0] rs1, rs2, rd,
  output [31:0] imm32,
  output [6:0] opcode,
  output [2:0] funct3, 
  output [6:0] funct7 
);

wire [7:0] ins_addr;
PC pc(
  .clk(clk),
  .rst(rst_pc),
  .pc_write(pc_write),
  .addr(ins_addr)
);

wire [31:0]instruction;
InsStore store(
  .clka(clk),
  .addra(ins_addr[7:2]),
  .douta(instruction)
);
reg [31:0] IR;

always @(negedge clk) begin
  if(pc_write)begin
    IR <= instruction;
  end
end

InsDecoder1 d1(
  .ins(IR),
  .rs1(rs1),
  .rs2(rs2),
  .rd(rd),
  .imm32(imm32),
  .opcode(opcode),
  .funct3(funct3),
  .funct7(funct7)
);


endmodule