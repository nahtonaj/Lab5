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

  wire c0, c1, c2, c3, c4, c5, c6, c7;
  wire g0, g1, g2, g3, g4, g5, g6, g7;
  wire p0, p1, p2, p3, p4, p5, p6, p7;
  
  // compute bitwise addition
  assign g0 = A[0] & B[0];
  assign p0 = A[0] | B[0];
  assign Y[0] = c0 ^ A[0] ^ B[0];
  
  assign g1 = A[1] & B[1];
  assign p1 = A[1] | B[1];
  assign Y[1] = c1 ^ A[1] ^ B[1];
  
  assign g2 = A[2] & B[2];
  assign p2 = A[2] | B[2];
  assign Y[2] = c2 | A[2] ^ B[2];
  
  assign g3 = A[3] & B[3];
  assign p3 = A[3] | B[3];
  assign Y[3] = c3 ^ A[3] ^ B[3];
  
  assign g4 = A[4] & B[4];
  assign p4 = A[4] | B[4];
  assign Y[4] = c4 ^ A[4] ^ B[4];
  
  assign g5 = A[5] & B[5];
  assign p5 = A[5] | B[5];
  assign Y[5] = c5 ^ A[5] ^ B[5];
  
  assign g6 = A[6] & B[6];
  assign p6 = A[6] | B[6];
  assign Y[6] = c6 ^ A[6] ^ B[6];
  
  assign g7 = A[7] & B[7];
  assign p7 = A[7] | B[7];
  assign Y[7] = c7 ^ A[7] ^ B[7];
  
  // carry-out assignment
  assign c0 = CI;
  assign c1 = g0 | p0 & c0;
  assign c2 = g1 | p1 & c1;
  assign c3 = g2 | p2 & c2;
  assign c4 = g3 | p3 & c3;
  assign c5 = g4 | p4 & c4;
  assign c6 = g5 | p5 & c5;
  assign c7 = g6 | p6 & c6;
  assign C  = g7 | p7 & c7;
  
  // check negative
  assign N = Y[7];
  
  // overflow detection
  assign V = (c7 == C) ? 1'b0 : 1'b1;
  
  // set zero flag
  assign Z = ~(Y[7] | Y[6] | Y[5] | Y[4] | Y[3] | Y[2] | Y[1] | Y[0]); 
  
endmodule