module IM4riu (
    input clk,
    input [31:0] addr,
    output [31:0] data_out
);
ip_inst_riu riu (
  clk,
  addr[7:2],
  data_out
);
endmodule