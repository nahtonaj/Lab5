module alu(A, B, OP, Y, C, V, N, Z);
  input  [7:0]  A;
  input  [7:0]  B;
  input  [2:0]  OP;

  output [7:0]  Y;
  output        C;
  output        V;
  output        N;
  output        Z;
  
  wire [7:0]	 LOGIC_Y, SHIFT_Y, ADD_Y;
  wire 			 LOGICAL_OP, LOGIC_C, LOGIC_N, LOGIC_V, LOGIC_Z;
  wire 			 SHIFT_LA, SHIFT_LR, SHIFT_C, SHIFT_N, SHIFT_V, SHIFT_Z;
  wire			 CISEL, CI, BSEL; 
  wire			 ADD_C, ADD_N, ADD_V, ADD_Z;
  wire [1:0]	 OSEL;
  
  // comment out each implemented modules to test them one at a time
  // ADD YOUR CODE BELOW THIS LINE
  
 
	adder a(
		.A(A),
		.B(B),
		.CI(CI),
		.Y(ADD_Y),
		.N(ADD_N), 
		.V(ADD_V),   
		.Z(ADD_Z),
		.C(ADD_C)
	);
	
	shifter s(
		.A(A), 
		.Y(SHIFT_Y), 
		.LA(SHIFT_LA), 
		.LR(SHIFT_LR), 
		.C(SHIFT_C), 
		.N(SHIFT_N), 
		.V(SHIFT_V), 
		.Z(SHIFT_Z)
	);
	
	logical l(
		.A(A), 
		.B(B), 
		.OP(LOGICAL_OP), 
		.Y(LOGIC_Y), 
		.C(LOGIC_C), 
		.V(LOGIC_V), 
		.N(LOGIC_N), 
		.Z(LOGIC_Z)
	);
	
	control c(
		.OP(OP), 
		.CISEL(CISEL), 
		.BSEL(BSEL), 
		.OSEL(OSEL), 
		.SHIFT_LA(SHIFT_LA), 
		.SHIFT_LR(SHIFT_LR), 
		.LOGICAL_OP(LOGICAL_OP)
	);
	
	muxCI mCI(
		.CISEL(CISEL),
		.CIout(CI)
	);
	
	muxOSEL mO(
		.ADD_Y(ADD_Y), 
		.ADD_C(ADD_C), 
		.ADD_N(ADD_N), 
		.ADD_V(ADD_V), 
		.ADD_Z(ADD_Z),
		.SHIFT_Y(SHIFT_Y), 
		.SHIFT_C(SHIFT_C), 
		.SHIFT_N(SHIFT_N), 
		.SHIFT_V(SHIFT_V), 
		.SHIFT_Z(SHIFT_Z),
		.LOGIC_Y(LOGIC_Y), 
		.LOGIC_C(LOGIC_C), 
		.LOGIC_N(LOGIC_N), 
		.LOGIC_V(LOGIC_V), 
		.LOGIC_Z(LOGIC_Z),
		.OSEL(OSEL), 
		.Y(Y), 
		.C(C), 
		.N(N), 
		.V(V), 
		.Z(Z)
	)
	
  // ADD YOUR CODE ABOVE THIS LINE


endmodule
