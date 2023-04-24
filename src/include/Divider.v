module Divider #(
    NUM_DIV
) (
    input clk_in,
    input rst_n,
    output reg clk_div
);

integer cnt;

always @(posedge clk_in or negedge rst_n) begin
    if(!rst_n)begin
        cnt <= 32'h0000_0000
    end else if(cnt < NUM_DIV/2 -1) begin
        cnt <= cnt + 32'h0000_0001
    end else begin
        cnt <= 32'h0000_0000
        clk_div <= ~clk_div
    end
end
    
endmodule