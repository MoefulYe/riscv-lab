`include "../include/FullAdder1bit.v"

module CarryLookaheadAdder4bits(
  input [3:0] a,
  input [3:0] b,
  input c0,
  output [3:0] s,
  output c4
);

wire [3:0] g;
wire [3:0] p;
assign g = a & b;
assign p = a | b;
wire [4:0] c;
assign c1 = g[0] | (p[0] & c0);
assign c2 = g[1] | (p[1] & g[0]) | (p[0] & p[1] & c0);
assign c3 = g[2] | (p[2] & g[1]) | (p[1] & p[2] & g[0]) | (p[0] & p[1] & p[2] & c0);
assign c4 = g[3] | (p[3] & g[2]) | (p[2] & p[3] & g[1]) | (p[1] & p[2] & p[3] & g[0]) | (p[0] & p[1] & p[2] & p[3] & c0);


FullAdder1bit _fa0(
  .A(a[0]),
  .B(b[0]),
  .Cin(c0),
  .Sum(s[0]),
  .Cout()
);

FullAdder1bit _fa1(
  .A(a[1]),
  .B(b[1]),
  .Cin(c1),
  .Sum(s[1]),
  .Cout()
);

FullAdder1bit _fa2(
  .A(a[2]),
  .B(b[2]),
  .Cin(c2),
  .Sum(s[2]),
  .Cout()
);

FullAdder1bit _fa3(
  .A(a[3]),
  .B(b[3]),
  .Cin(c3),
  .Sum(s[3]),
  .Cout()
);

endmodule
