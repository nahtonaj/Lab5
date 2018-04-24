module cpu(CLK, RESET, EN_L, Iin, Din, PC, NextPC, DataA, DataB, DataC, DataD, MW);
  input         CLK;
  input         RESET;
  input         EN_L;
  input  [15:0] Iin;
  input  [7:0]  Din;
  
  output [7:0]  PC;
  output [7:0]  NextPC;
  output [7:0]  DataA;
  output [7:0]  DataB;
  output [7:0]  DataC;
  output [7:0]  DataD;
  output        MW;
  
  // comment the two lines out below if you use a submodule to generate PC/NextPC
  // reg [7:0] PC;
  // reg [7:0] NextPC;
  
  wire MW, MD, MB, LD, BS, OFF, HALT, C, V, N, Z;
  wire [5:0] IMM;
  wire [2:0] DR, SA, SB, FS;
  wire [7:0] S_EXT, MUX_B;
  
  // ADD YOUR CODE BELOW THIS LINE

  pc pc_mod (
		.CLK(CLK),
		.RESET(RESET),
		.PC(PC),
		.NEXT_PC(NextPC)
		//.EN_L(EN_L)
  );
  
  decoder decoder_mod (
		.INST(Iin),
		.DR(DR),
		.SA(SA),
		.SB(SB),
		.IMM(IMM),
		.MB(MB),
		.FS(FS),
		.MD(MD),
		.LD(LD),
		.MW(MW),
		.BS(BS),
		.OFF(OFF),
		.HALT(HALT)
		
  );
  
  reg_file reg_file_mod (
		.RESET(RESET),
		.SA(SA),
		.SB(SB),
		.LD(LD),
		.DR(DR),
		.D_in(DataC),
		.DATA_A(DataA),
		.DATA_B(DataB),
		.CLK(CLK)
		
  );
  
  sext sext_mod (
		.IMM(IMM),
		.OUT(S_EXT)
		
  );
  
  alu alu_mod (
		.A(DataA),
		.B(MUX_B),
		.OP(FS),
		.Y(DataD),
		.C(C),
		.V(V),
		.N(N),
		.Z(Z)
		
  );

  assign MUX_B = MB ? S_EXT : DataB;
  assign DataC = MD ? Din : DataD;

  // ADD YOUR CODE ABOVE THIS LINE

endmodule
