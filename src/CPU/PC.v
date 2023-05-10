`include "../define/pc_update.v"

//"../07-inst-fetch-decode/PC.v"的升级版，使得能够支持跳转指令
module PC (
    input clk,
    input rst,
    input pc_write,
    input [1:0] update_sel,
    input [31:0] alu_f,
    input [31:0] offset,
    output reg [31:0] next_inst_addr,
    output reg [31:0] cur_inst_addr
);

always @(posedge clk) begin
    if(pc_write) begin
        case(update_sel)
        `PC_STEP: cur_inst_addr <= next_inst_addr;
        `PC_JP_R: cur_inst_addr <= pc0 + offset;
        `PC_JP_F: cur_inst_addr <= alu_f;
        `PC_HOLD: cur_inst_addr <= pc0;
        endcase
    end
end

always @(negedge clk or posedge rst) begin
    if(rst) begin
        cur_inst_addr <= 32'hffff_fffc;
        next_inst_addr <= 32'h0000_0000;
    end else if(pc_write) begin
        next_inst_addr <= cur_inst_addr + 4;
    end
end

endmodule