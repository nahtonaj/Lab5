module adder(A, B, CI, C, Y, N, V, Z);

  // inputs
  input [7:0] A;
  input [7:0] B;
  input CI;
  
  // outputs
  output [7:0] Y;
  output N;
  output V;
  output Z;
  output C;

  wire c1, c2, c3, c4, c5, c6, c7;
  
  full zero(
		.A(A[0]),
		.B(B[0]),
		.CI(CI),
		.C(c1),
		.S(Y[0])
  );
  
  full one(
		.A(A[1]),
		.B(B[1]),
		.CI(c1),
		.C(c2),
		.S(Y[1])
  );
  
  full two(
		.A(A[2]),
		.B(B[2]),
		.CI(c2),
		.C(c3),
		.S(Y[2])
  );
  
  full three(
		.A(A[3]),
		.B(B[3]),
		.CI(c3),
		.C(c4),
		.S(Y[3])
  );
  
  full four(
		.A(A[4]),
		.B(B[4]),
		.CI(c4),
		.C(c5),
		.S(Y[4])
  );
  
  full five(
		.A(A[5]),
		.B(B[5]),
		.CI(c5),
		.C(c6),
		.S(Y[5])
  );
  
  full six(
		.A(A[6]),
		.B(B[6]),
		.CI(c6),
		.C(c7),
		.S(Y[6])
  );
  
  full seven(
		.A(A[7]),
		.B(B[7]),
		.CI(c7),
		.C(C),
		.S(Y[7])
  );
  
  // check negative
  assign N = Y[7];
  
  // overflow detection
  assign V = (c7 == C) ? 1'b0 : 1'b1;
  
  // set zero flag
  assign Z = ~(Y[7] | Y[6] | Y[5] | Y[4] | Y[3] | Y[2] | Y[1] | Y[0]); 
  
endmodule