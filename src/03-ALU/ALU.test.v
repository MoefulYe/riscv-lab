`timescale 1ps/1ps
module ALUTester();

reg [3:0] op;
reg [31:0] lhs, rhs, res;
reg ZF,SF,CF,OF;

ALU alu(
    lhs,
    rhs,
    op,
    res,
    { ZF, SF, CF, OF }
);

initial begin
    op = 4'b0000; //add
    lhs = 32'hffff_ffff;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h7000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'hf000_0001;
    #20
    op = 4'b0001; //sll
    lhs = 32'h000f_0000;
    rhs = 32'h0000_0002;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h0000_0004;
    #20
    op = 4'b0010; //slt
    lhs = 32'h0005_0000;
    rhs = 32'h0003_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h7009_0003;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'hf000_0001;
    #20
    op = 4'b0011; //sltu
    lhs = 32'h0000_0000;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h7000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'hf000_0001;
    #20
    op = 4'b0100; //xor
    lhs = 32'h0000_0000;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h7000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'hf000_0001;
    #20
    op = 4'b0101; //srl
    lhs = 32'h0000_00f0;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h0000_0003;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h0000_0001;
    #20
    op = 4'b0110; //or
    lhs = 32'h0000_0000;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h7000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'hf000_0001;
    #20
    op = 4'b0111; //and
    lhs = 32'h0000_0000;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h7000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'hf000_0001;
    #20
    op = 4'b1000; //sub
    lhs = 32'h0000_0000;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h7000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'hf000_0001;
    #20
    op = 4'b1001; //sra
    lhs = 32'h0000_00f0;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h0000_0003;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h0000_0001;
    #20
    op = 4'b1010; //add unsigned
    lhs = 32'h0000_0000;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h7000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'hf000_0001;
    #20
    op = 4'b1011; //sub unsigned
    lhs = 32'h0000_0000;
    rhs = 32'h0000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'h7000_0001;
    #20
    lhs = 32'h7fff_ffff;
    rhs = 32'hf000_0001;
end

endmodule