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
    addr = 8'b0000_0000;
    #20
    addr = 8'b0000_0100;
    #20
    addr = 8'b0000_1000;
    #20
    addr = 8'b0000_1100;
    #20
    addr = 8'b0001_0000;
    #20
    addr = 8'b0001_0100;
    #20
    data_in = 32'hffff_ffff;
    w_en = 1;
    #20
    $finish;
end

endmodule