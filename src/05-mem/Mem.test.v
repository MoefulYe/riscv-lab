`timescale  1ns / 1ps
module MemTester();
// Mem Parameters
parameter PERIOD  = 10;

reg clk = 0;
reg w_en = 0 ;
reg [7:0] addr = 0 ;
reg [31:0] data_in = 0 ;
wire [31:0] data_out;

initial begin
    forever #(PERIOD/2) clk=~clk;
end

Mem mem(
    .clk(clk),
    .w_en(w_en),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    #(PERIOD*2)
    w_en = 1;
    addr = 1;
    data_in = 32'h12345678;
    #(PERIOD*2)
    w_en = 0;
    addr = 1;
    #(PERIOD*2)
    w_en = 1;
    addr = 2;
    data_in = 32'h87654321;
    #(PERIOD*2)
    w_en = 0;
    addr = 2;
    $finish;
end

endmodule