module FullAdder1bit (
  input A,
  input B,
  input Cin,
  output Sum,
  output Cout
);
  wire AxorB, AandB, AxorBandCin;
  xor (Sum, A, B, Cin);
  and (AandB, A, B);
  xor (AxorB, A, B);
  and (AxorBandCin, AxorB, Cin);
  or (Cout, AandB, AxorBandCin);
endmodule