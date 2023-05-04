`include "../include/define.v"

module ALU (
    input [31:0] lhs,
    input [31:0] rhs,
    input clk,
    input [3:0] op, 
    output reg [31:0] res,
    output reg [3:0] flags // [is_zero, is_positive, carry, overflow]
);

reg _c;
always @(negedge clk) begin
    case(op)
        `ALU_ADD_OP :begin { _c, res } = lhs + rhs; flags[0] = _c ^ res[31] ^ lhs[31] ^ rhs[31]; end //add
        `ALU_SLL_OP :begin res = lhs << rhs; end // sll
        `ALU_SLT_OP :begin res = $signed(lhs) < $signed(rhs); end //slt
        `ALU_SLTU_OP:begin res = lhs < rhs; end //sltu
        `ALU_XOR_OP :begin res = lhs ^ rhs; end //xor
        `ALU_SRL_OP :begin res = lhs >> rhs; end //srl
        `ALU_OR_OP  :begin res = lhs | rhs; end //or
        `ALU_AND_OP :begin res = lhs & rhs; end //and
        `ALU_SUB_OP :begin { _c, res } = lhs - rhs; flags[0] = _c ^ res[31] ^ lhs[31] ^ rhs[31]; end //sub
        `ALU_SRA_OP :begin res = $signed(lhs) >>> rhs; end //sra
        `ALU_ADDU_OP:begin { flags[1], res } = lhs + rhs; end //addu
        `ALU_SUBU_OP:begin { flags[1], res } = lhs - rhs; end //subu
        default: begin res = 0; end
    endcase 
    flags[3] <= res == 32'h0000_0000 ? 1 : 0;
    flags[2] <= res[31];
end
endmodule