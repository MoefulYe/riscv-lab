`include "./CU.v"
`include "../07-inst-fetch-decode/ProgramCounter.v"
`include "../07-inst-fetch-decode/InstDecoder1.v"
`include "../04-reg-heap/RegHeap.v"
`include "../03-ALU/ALU.v"

module CPU(
    input clk,
    input rst_pc,
    output [31:0] res,
    output zf, sf, cf, of
);

// cu 

endmodule