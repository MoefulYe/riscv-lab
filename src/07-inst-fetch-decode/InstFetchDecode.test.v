module InstFetchDecodeTester();

reg clk = 0;
reg rst_pc = 0;
wire [4:0] rs1, rs2, rd;
wire [31:0] imm32;
wire [6:0] opcode;
wire [2:0] funct3; 
wire [6:0] funct7;
wire [7:0] watch_pc;
wire [31:0] watch_ir;

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
  .funct7(funct7),
  .watch_pc(watch_pc),
  .watch_ir(watch_ir)
);

initial begin
rst_pc = 1;
#20
rst_pc = 0;
#200
$finish;
end

endmodule