`timescale 1ns / 1ps

module SerialAdder4bitsTester();

reg [3:0]A;
reg [3:0]B;
reg Cin;
wire [3:0]C;
wire Cout;

SerialAdder4bits SerialAdder4bits(
    A,
    B,
    Cin,
    C,
    Cout
);

initial begin
  A = 4'b0000;
  B = 4'b0000;
  Cin = 0;
  #100
  A = 4'b0001;
  B = 4'b0100;
  Cin = 0;
  #100
  A = 4'b1111;
  B = 4'b1111;
  Cin = 1;
  #100
  A = 4'b1100;
  B = 4'b0011;
  Cin = 0;
  #100
  A = 4'b1101;
  B = 4'b0011;
  Cin = 1;
  #1000
  $finish;
end
endmodule
