`include "../include/FullAdder1bit.v"

module G( input [3:0]a, input [3:0]b, output [3:0]g);
assign g[0] = a[0] & b[0];
assign g[1] = a[1] & b[1];
assign g[2] = a[2] & b[2];
assign g[3] = a[3] & b[3];
endmodule

module P( input [3:0]a, input [3:0]b, output [3:0]p);
assign p[0] = a[0] | b[0];
assign p[1] = a[1] | b[1];
assign p[2] = a[2] | b[2];
assign p[3] = a[3] | b[3];
endmodule

module CarryLookahead(
  input [3:0] G,
  input [3:0] P,
  input carry_in,
  output [4:0] C
);

assign C[0] = carry_in;
assign C[1] = G[0] | (P[0] & C[0]);
assign C[2] = G[1] | (P[1] & G[0]) | (P[0] & P[1] & C[0]);
assign C[3] = G[2] | (P[2] & G[1]) | (P[1] & P[2] & G[0]) | (P[0] & P[1] & P[2] & C[0]);
assign C[4] = G[3] | (P[3] & G[2]) | (P[2] & P[3] & G[1]) | (P[1] & P[2] & P[3] & G[0]) | (P[0] & P[1] & P[2] & P[3] & C[0]);

endmodule

module CarryLookaheadAdder4bits(
  input [3:0] a,
  input [3:0] b,
  input c_in,
  output [3:0] s,
  output c_out
);

wire [3:0] g;
G _g(a, b, g);
wire [3:0] p;
P _p(a, b, p);
wire [4:0] c;
CarryLookahead _c(g, p, c_in, c);
assign c_out = c[4];

FullAdder1bit _fa0(
  .A(a[0]),
  .B(b[0]),
  .C(s[0]),
  .Sum(s[0]),
  .Cout()
);

FullAdder1bit _fa1(
  .A(a[1]),
  .B(b[1]),
  .C(c[1]),
  .Sum(s[1]),
  .Cout()
);

FullAdder1bit _fa2(
  .A(a[2]),
  .B(b[2]),
  .C(c[2]),
  .Sum(s[2]),
  .Cout()
);

FullAdder1bit _fa3(
  .A(a[3]),
  .B(b[3]),
  .C(c[3]),
  .Sum(s[3]),
  .Cout()
);

endmodule
