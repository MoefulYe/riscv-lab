module DM(
    input clk,
    input mem_write,
    input [31:0] addr, //addr[7:2]读写地址
    input [31:0] data_in, //写入数据
    output [31:0] data_out //读出数据
);

ip_dm mem (
  clk,
  mem_write,
  addr[7:2],
  data_in,
  data_out
);

endmodule