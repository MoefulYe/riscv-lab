module DataMem(
    input clk,
    input mem_write,
    input [31:0] addr, //addr[7:2]读写地址
    input [31:0] data_in, //写入数据
    output reg [31:0] mdr //读出数据
);
endmodule