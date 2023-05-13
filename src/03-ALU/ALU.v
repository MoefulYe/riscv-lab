`include "../define/alu_op.v"

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
        `ALU_ADD_OP :begin { _c, res } = lhs + rhs; flags[0] = _c ^ res[31] ^ lhs[31] ^ rhs[31]; flags[1] = 0;end
        `ALU_SLL_OP :begin res = lhs << rhs; flags[1:0] = 0; end
        `ALU_SLT_OP :begin res = $signed(lhs) < $signed(rhs); flags[1:0] = 0;end
        `ALU_SLTU_OP:begin res = lhs < rhs; flags[1:0] = 0;end
        `ALU_XOR_OP :begin res = lhs ^ rhs; flags[1:0] = 0;end
        `ALU_SRL_OP :begin res = lhs >> rhs; flags[1:0] = 0;end
        `ALU_OR_OP  :begin res = lhs | rhs; flags[1:0] = 0;end
        `ALU_AND_OP :begin res = lhs & rhs; flags[1:0] = 0;end
        `ALU_SUB_OP :begin { _c, res } = lhs - rhs; flags[0] = _c ^ res[31] ^ lhs[31] ^ rhs[31]; flags[1:0] = 0;end
        `ALU_SRA_OP :begin res = $signed(lhs) >>> rhs; flags[1:0] = 0;end
        `ALU_ADDU_OP:begin { flags[1], res } = lhs + rhs; flags[0] = 0;end
        `ALU_SUBU_OP:begin { flags[1], res } = lhs - rhs; flags[0] = 0;end
        default: begin res = 0; flags[1:0] = 0;end
    endcase 
    flags[3] <= res == 32'h0000_0000 ? 1 : 0;
    flags[2] <= res[31];
end
endmodule