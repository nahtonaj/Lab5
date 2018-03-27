module alu(A, B, OP, Y, C, V, N, Z);
  input  [7:0]  A;
  input  [7:0]  B;
  input  [2:0]  OP;

  output [7:0]  Y;
  output        C;
  output        V;
  output        N;
  output        Z;


  // ADD YOUR CODE BELOW THIS LINE
 
	adder a(
		.A(A),
		.B(B),
		.CI(1'b0),
		.Y(Y),
		.N(N), 
		.V(V),   
		.Z(Z),
		.C(C)
	);

  // ADD YOUR CODE ABOVE THIS LINE


endmodule
