`include "../define/pc_jump.v"

//"../07-inst-fetch-decode/ProgramCounter.v"的升级版，使得能够支持跳转指令
module PC (
    input clk,
    input rst,
    input go_next,
    input jump,
    input jump_sel,
    input [31:0] f_data,
    input [31:0] rel_addr,
    output reg [31:0] inst_addr
);

always @(negedge clk or posedge rst) begin
    if(rst) begin
        inst_addr <= 0;
    end else begin
        inst_addr <= inst_addr + 4;
    end
end

always @(*) begin
    if(jump) begin
        case(jp_sel)
            `JP_RELATIVE: begin inst_addr <= inst_addr + rel_addr; end
            `JP_TO_F: begin inst_addr <= f_data; end
        endcase
    end
end

endmodule