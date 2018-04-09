module alu(A, B, OP, Y, C, V, N, Z);
  input  [7:0]  A;
  input  [7:0]  B;
  input  [2:0]  OP;

  output [7:0]  Y;
  output        C;
  output        V;
  output reg    N;
  output reg    Z;
  
  wire [7:0]	 LOGIC_Y, SHIFT_Y, ADD_Y;
  wire 			 LOGICAL_OP, LOGIC_C, LOGIC_V;
  wire 			 SHIFT_LA, SHIFT_LR, SHIFT_C, SHIFT_V;
  wire			 CISEL, CI, BSEL; 
  wire			 ADD_C, ADD_V;
  wire [1:0]	 OSEL;
  
  // comment out each implemented modules to test them one at a time
  // ADD YOUR CODE BELOW THIS LINE
  
 
	adder a(
		.A(A),
		.B(B),
		.CI(CI),
		.Y(ADD_Y), 
		.V(ADD_V),
		.C(ADD_C)
	);
	
	shifter s(
		.A(A), 
		.Y(SHIFT_Y), 
		.LA(SHIFT_LA), 
		.LR(SHIFT_LR), 
		.C(SHIFT_C), 
		.V(SHIFT_V)
	);
	
	logical l(
		.A(A), 
		.B(B), 
		.OP(LOGICAL_OP), 
		.Y(LOGIC_Y), 
		.C(LOGIC_C), 
		.V(LOGIC_V)
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
		.ADD_V(ADD_V), 
		.SHIFT_Y(SHIFT_Y), 
		.SHIFT_C(SHIFT_C),  
		.SHIFT_V(SHIFT_V), 
		.LOGIC_Y(LOGIC_Y), 
		.LOGIC_C(LOGIC_C),  
		.LOGIC_V(LOGIC_V), 
		.OSEL(OSEL), 
		.Y(Y), 
		.C(C), 
		.V(V)
	)
	
	assign N = Y[7];
	assign Z = ~(Y[7] | Y[6] | Y[5] | Y[4] | Y[3] | Y[2] | Y[1] | Y[0]);
	
  // ADD YOUR CODE ABOVE THIS LINE


endmodule
