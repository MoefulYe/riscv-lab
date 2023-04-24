module CarryLookaheadAdder4bitsTopper(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] C,
    output Cout
);

CarryLookaheadAdder4bits adder(A,B,Cin,C,Cout);

endmodule
