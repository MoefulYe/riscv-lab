module G( input a, input b, output g);
and (g, a, b);
endmodule

module P( input a, input b, output p);
or (p, a, b);
endmodule

module CarryLookaheadAdder4bits(
  input [3:0] a,
  input [3:0] b,
  input c_in,
  output [3:0] s,
  output c_out
);
