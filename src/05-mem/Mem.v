// module Reader (
//    //  mod | description
//    //  00  | 字访问
//    //  01  | 半字访问
//    //  1X  | 字节访问
//    input [1:0] mod,
//    //  mod | description
//    //  00  | 字访问，addr[1:0]被丢弃
//    //  01  | 半字访问，addr[0]被丢弃
//    //  1X  | 字节访问，addr每一位都是有效的
//    input [1:0] addr,
//    input [31:0] in, //ram输出的字对齐数据，需要进行移位 
//    output [31:0] out//输出数据
// );

// parameter SHIFT00 = 8'd0;
// parameter SHIFT08 = 8'd8;
// parameter SHIFT16 = 8'd16;
// parameter SHIFT24 = 8'd24;

// wire [7:0] shift_n = {                   // mod 
//   SHIFT00, SHIFT08, SHIFT16, SHIFT24,    // 11
//   SHIFT00, SHIFT08, SHIFT16, SHIFT24,    // 10
//   SHIFT00, SHIFT00, SHIFT16, SHIFT16,    // 01
//   SHIFT00, SHIFT00, SHIFT00, SHIFT00     // 00
// // addr 11    10    01    00
// };

// assign out = in << shift_n[{mod, addr}];

// endmodule

// module Aligner (
//     input clk,
//     input [1:0] mod,
//     input [1:0] addr,
//     input [31:0] in,
//     input [31:0] new,
//     output reg [31:0] out
// );

// always @(negedge clk) begin
//   out <= in;
//   case (mod)
//     2'b00: begin out <= new; end 
//     2'b01: begin
//       case(addr[1])
//         1'b0: begin out[15:0] <= new[31:16]; end
//         1'b1: begin out[31:16] <= new[31:16]; end
//       endcase
//     end
//     default: begin
//       case(addr)
//         2'b00: begin out[7:0] <= new[31:24]; end
//         2'b01: begin out[15:8] <= new[31:24]; end
//         2'b10: begin out[23:16] <= new[31:24]; end
//         2'b11: begin out[31:24] <= new[31:24]; end
//       endcase
//     end
//   endcase
// end

// endmodule

//只实现了全字访问, 半字访问和字节访问并没有实现
//这让我深刻地理解为什么c语言结构体内存布局要对齐了
module Mem (
  input clk,
  input w_en,
  //input [1:0] mod,
  input [7:0] addr, //存储器共2^6 = 64个字 ,对字节进行编码后2位会被丢弃
  input [31:0] data_in, 
  output [31:0] data_out 
);

Ram ram (
  .clka(clk),    // input wire clka
  .wea(w_en),      // input wire [0 : 0] wea
  .addra(addr[7:2]),  // input wire [5 : 0] addra
  .dina(data_in),    // input wire [31 : 0] dina
  .douta(data_out)  // output wire [31 : 0] douta
);

endmodule