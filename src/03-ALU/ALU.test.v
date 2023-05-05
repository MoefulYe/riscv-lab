`timescale 1ns/1ps
module ALUTester();

reg [3:0] op;
reg [31:0] lhs, rhs;
wire [31:0] res;
wire ZF,SF,CF,OF;

ALU alu(
    lhs,
    rhs,
    clk,
    op,
    res,
    { ZF, SF, CF, OF }
);

reg clk;

parameter PERIOD = 10;
initial begin
    clk = 0;
    forever begin
        #(PERIOD/2) clk = ~clk;
    end
end

initial begin
    op = 4'b0000; //add
    lhs = 32'hffff_ffff;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h1000_0003;
    #20
    op = 4'b0001; //sll
    lhs = 32'h000f_0000;
    rhs = 32'h0000_0002;
    #20
    op = 4'b0010; //slt
    lhs = 32'hffff_0000;
    rhs = 32'h0003_0001;
    #20
    lhs = 32'h0fff_ffff;
    rhs = 32'h0009_0003;
    #20
    op = 4'b0011; //sltu
    lhs = 32'hf000_0000;
    rhs = 32'h0000_0001;
    #20
    op = 4'b0100; //xor
    lhs = 32'h0000_0000;
    rhs = 32'h0000_0001;
    #20
    op = 4'b0101; //srl
    lhs = 32'hf000_0000;
    rhs = 32'h0000_0002;
    #20
    op = 4'b0110; //or
    lhs = 32'h0000_0000;
    rhs = 32'h0000_0001;
    #20
    op = 4'b0111; //and
    lhs = 32'h0d00_0001;
    rhs = 32'h0f00_0001;
    #20
    op = 4'b1000; //sub
    lhs = 32'h8000_0000;
    rhs = 32'h0fff_ffff;
    #20
    lhs = 32'h0000_0001;
    rhs = 32'h0000_0002;
    #20
    op = 4'b1001; //sra
    lhs = 32'h0000_00f0;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'hffff_ffff;
    rhs = 32'h0000_0003;
    #20
    op = 4'b1010; //addu
    lhs = 32'h0000_0000;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'hffff_ffff;
    rhs = 32'h0000_0001;
    #20
    op = 4'b1011; //subu
    lhs = 32'h0000_0000;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h7000_0001;
end

endmodule