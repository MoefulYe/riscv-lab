`include "../define/pc_jump.v"

//"../07-inst-fetch-decode/PC.v"的升级版，使得能够支持跳转指令
module PC (
    input clk,
    input rst,
    input step,
    input jump,
    input jump_sel,
    input [31:0] alu_f,
    input [31:0] rel_addr,
    output [31:0] inst_addr,
    output reg [31:0] ret_addr
);

reg [31:0] pc;
reg [31:0] pc0;

assign inst_addr = pc;

always @(negedge clk or posedge rst) begin
    if(rst) begin
        pc = 0;
        pc0 = 0;
        ret_addr = 0;
    end else if(step) begin
        pc0 = pc;
        pc = pc + 4; 
    end
end

always @(*) begin
    if(jump) begin
        case(jump_sel)
            `JP_RELATIVE: begin 
                ret_addr = pc;
                pc = pc0 + rel_addr;
            end
            `JP_TO_F: begin
                ret_addr = pc;
                pc = alu_f;
            end
        endcase
    end
end

endmodule