`include "../include/FullAdder1bit.v"

module SerialAdder4bits (
  input [3:0] A,
  input [3:0] B,
  input Cin,
  output [3:0] Sum,
  output Cout
);

wire carry1, carry2, carry3;

FullAdder1bit FA0 (.A(A[0]), .B(B[0]), .Cin(Cin), .Sum(Sum[0]), .Cout(carry1));
FullAdder1bit FA1 (.A(A[1]), .B(B[1]), .Cin(carry1), .Sum(Sum[1]), .Cout(carry2));
FullAdder1bit FA2 (.A(A[2]), .B(B[2]), .Cin(carry2), .Sum(Sum[2]), .Cout(carry3));
FullAdder1bit FA3 (.A(A[3]), .B(B[3]), .Cin(carry3), .Sum(Sum[3]), .Cout(Cout));

endmodule
