`include "../include/LedDisplay.v"

module Mux ( //led灯不够用
    input [4:0] rs1, rs2, rd,  //led
    input [6:0] opcode,    //led
    input [2:0] funct3,    //led
    input [6:0] funct7,     //led
    input swtich,
    output reg [23:0] led
);

always @(*) begin
   led <= 0;
   if(swtich)begin
    led[23:19] <= rs1;
    led[15:11] <= rs2;
    led[7:3] <= rd;
   end else begin
    led[23:17] <= opcode;
    led[15:13] <= funct3;
    led[7:1] <= funct7;
   end
end

endmodule

module InsFetchDecodeTopper (
    input led_clk,  
    input clk,      //按钮模拟，一个周期
    input rst_pc,   //pc寄存器指向0地址
    input pc_write, //enable 1
    input ir_write, //enable 1
    input swtich,
    output [3:0] sel,    //数码管
    output [7:0] seg,    //数码管
    output [23:0] led
);
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode;    
    wire [2:0] funct3;    
    wire [6:0] funct7;    
    wire [31:0] imm32;
    InsFetchDecode ifd(
        clk,
        rst_pc,
        pc_write,
        ir_write,
        rs1,
        rs2,
        rd,
        imm32_data,
        opcode,
        funct3,
        funct7
    );  

    LedDisplay _led(
        led_clk,
        imm32_data,
        1,
        sel,
        seg
    );

    Mux mux(
        rs1,
        rs2,
        rd,
        opcode,
        funct3,
        funct7,
        swtich,
        led
    );
endmodule