`include "../include/LedDisplay.v"

module MemTopper (
    input clk,
    input w_en,
    input [5:0] addr,
    input clk_to_change_data_in,
    input [1:0] data_sel,
    output [7:0] seg,
    output [3:0] sel
);


reg [31:0] data_in;
wire [31:0] data_out;

always @(posedge clk_to_change_data_in) begin
    case (data_sel)
        2'b00: data_in <= 32'h12345678;
        2'b01: data_in <= 32'h87654321;
        2'b10: data_in <= 32'hfedcba98;
        2'b11: data_in <= 32'h89abcdef;
    endcase
end

Mem mem (
    .clk(clk),
    .w_en(w_en),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

LedDisplay led(
    clk,
    data_out,
    1'b1,
    sel,
    seg
);

endmodule