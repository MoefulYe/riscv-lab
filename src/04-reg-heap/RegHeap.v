module RegHeap(
    input clk,
    input w_en,
    input rst,
    input [4:0] r_addr_a,
    output reg [31:0] r_data_a,
    input [4:0] r_addr_b,
    output reg [31:0] r_data_b,
    input [4:0] w_addr,
    input [31:0] w_data
);

reg [31:0]regs[31:0];
integer i;
always@(negedge clk or posedge rst) begin
    if(rst) begin
       regs[0] <= 0;
       for(i=1;i<32;i=i+1) regs[i] <= 1 << i;
    end else begin
        if(w_en == 1 && w_addr != 0) begin
            regs[w_addr] <= w_data;
        end
    end
end

always@(negedge clk)begin
    r_data_a <= regs[r_addr_a];
    r_data_b <= regs[r_addr_b];
end
endmodule