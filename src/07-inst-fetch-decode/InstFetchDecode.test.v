module InstFetchDecodeTester();

reg clk = 0;
reg rst_pc = 0;
wire [4:0] rs1, rs2, rd;
wire [31:0] imm32;
wire [6:0] opcode;
wire [2:0] funct3; 
wire [6:0] funct7;

parameter PERIOD  = 10;

initial begin
    forever #(PERIOD/2) clk=~clk;
end

InstFetchDecode ins_fetch_decode(
  .clk(clk),
  .rst_pc(rst_pc),
  .pc_write(1),
  .ir_write(1),
  .rs1(rs1),
  .rs2(rs2),
  .rd(rd),
  .imm32(imm32),
  .opcode(opcode),
  .funct3(funct3),
  .funct7(funct7)
);

initial begin
#20
rst_pc = 1;
#20
rst_pc = 0;
#2000
$finish;
end

endmodule