`include "./PC.v"
`include "./InstDecoder1.v"


module InstFetchDecode(
  input clk,
  input rst_pc,
  input pc_write,
  input ir_write,
  output [4:0] rs1, rs2, rd,
  output [31:0] imm32,
  output [6:0] opcode,
  output [2:0] funct3, 
  output [6:0] funct7,
  output [7:0] watch_pc,
  output [31:0] watch_ir
);


wire [7:0] ins_addr;
assign watch_pc = ins_addr;

PC pc(
  .clk(clk),
  .rst(rst_pc),
  .pc_write(pc_write),
  .addr(ins_addr)
);

wire[31:0] inst;
InstStore store(
  .clka(clk),
  .addra(ins_addr[7:2]),
  .douta(inst)
);
reg [31:0] IR;
assign watch_ir = IR;

InstDecoder1 id1(
  .inst(IR),
  .rs1(rs1),
  .rs2(rs2),
  .rd(rd),
  .imm32(imm32),
  .opcode(opcode),
  .funct3(funct3),
  .funct7(funct7)
);

always @(negedge clk) begin
    if(ir_write)IR <= inst;
end

endmodule