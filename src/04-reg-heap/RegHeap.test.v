`timescale 1ns/1ps
module RegHeapTester();

reg clk;
reg w_en;
reg rst_n;
reg [4:0] r_addr_a;
wire [31:0] r_data_a;
reg [4:0] r_addr_b;
wire [31:0] r_data_b;
reg [4:0] w_addr;
reg [31:0] w_data;

RegHeap gh(
    clk,
    w_en,
    rst_n,
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
    rst_n = 1;
    w_en = 0;
    r_addr_a = 5'b0;
    r_addr_b = 5'b0;
    w_addr = 5'b0;
    w_data = 5'b0; 
    #10
    rst_n = 0;
    #100
    rst_n = 1;
    #100
    r_addr_a = 5'b0000;
    w_en = 1;
    w_addr = 5'b0000;
    w_data = 32'hffff_ffff;
    #100
    w_addr = 5'b0001;
    w_data = 32'h0000_ffff;
    #100
    w_addr = 5'b0001;
    w_data = 32'h0000_0001;
    #100
    w_addr = 5'b0010;
    w_data = 32'h0000_0002;
    #100
    r_addr_a = 5'b00001;
    r_addr_b = 5'b00010;
    w_addr = 5'b0010;
    w_data = 32'h0000_0002;
    #100
    rst_n = 0;
    #10
    rst_n = 1;
    r_addr_a = 5'b00001;
    r_addr_b = 5'b00010;
end

endmodule