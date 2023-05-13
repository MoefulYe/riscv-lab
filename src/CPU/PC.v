`include "../define/pc_update.v"

//"../07-inst-fetch-decode/PC.v"的升级版，使得能够支持跳转指令
module PC (
    input clk,
    input rst,
    input next_write,
    input cur_write,
    input [1:0] update_sel,
    input [31:0] alu_f,
    input [31:0] offset,
    output reg [31:0] next_addr,
    output reg [31:0] cur_addr
);

always@(posedge rst or negedge clk) begin
    if(rst)begin
        cur_addr <= 0;
        next_addr <= 0;
    end else begin
        if(cur_write)begin
            case(update_sel)
            `PC_STEP: cur_addr <= next_addr;
            `PC_JP_R: cur_addr <= cur_addr + offset;
            `PC_JP_F: cur_addr <= alu_f;
            `PC_HOLD: cur_addr <= cur_addr;
            endcase
        end
        if(next_write)begin
            next_addr <= cur_addr + 4;
        end
    end
end

endmodule