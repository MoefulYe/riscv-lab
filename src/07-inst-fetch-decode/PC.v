module PC(
  input clk,
  input rst,
  input pc_write,
  output reg [7:0] addr
);

always @(negedge clk or posedge rst) begin
  if(rst)begin
    addr <= 0;
  end else if(pc_write)begin
    addr <= addr + 4;
  end
end
endmodule