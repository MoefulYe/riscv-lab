`timescale 1ns/1ps
module RegHeapTester();

reg clk;
reg w_en;
reg rst;
reg [4:0] r_addr_a;
wire [31:0] r_data_a;
reg [4:0] r_addr_b;
wire [31:0] r_data_b;
reg [4:0] w_addr;
reg [31:0] w_data;


RegHeap gh(
    clk,
    w_en,
    rst,
    1'b1,
    r_addr_a,
    r_data_a,
    r_addr_b,
    r_data_b,
    w_addr,
    w_data
);

parameter PERIOD = 10;
initial begin
    clk = 0;
    forever begin
        #(PERIOD/2) clk = ~clk;
    end
end

initial begin
    rst = 0;
    w_en = 0;
    r_addr_a = 5'b0;
    r_addr_b = 5'b0;
    w_addr = 5'b0;
    w_data = 5'b0; 
    #10
    rst = 1;
    #10
    rst = 0;
    #10
    r_addr_a = 5'b00000;
    r_addr_b = 5'b00001;
    #70
    w_en = 1;
    w_addr = 5'b00000;
    w_data = 32'hffff_ffff;
    #50
    w_addr = 5'b00001;
    w_data = 32'hffff_ffff;
    #50
    w_en = 0;
    r_addr_a = 5'b00010;
    w_addr = 5'b00010;
    w_data = 32'hffff_ffff;
    #50
    $finish;
end

endmodule