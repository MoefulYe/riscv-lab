module IM4ls (
    input clk,
    input [31:0] addr,
    output [31:0] data_out
);
ip_inst_ls ls (
  clk,
  addr[7:2],
  data_out
);
endmodule