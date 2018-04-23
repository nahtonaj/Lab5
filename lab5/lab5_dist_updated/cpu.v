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
  wire [7:0] DATA_A, DATA_B, DATA_C, DATA_D, S_EXT, MUX_B, MUX_D, DATA_RAM;
  
  // ADD YOUR CODE BELOW THIS LINE

  pc pc_mod (
		.CLK(CLK),
		.RESET(RESET),
		.PC(PC),
		.NEXT_PC(NextPC)
		
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
		.D_in(Din),
		.DATA_A(DATA_A),
		.DATA_B(DATA_B)
		
  );
  
  sext sext_mod (
		.IMM(IMM),
		.OUT(S_EXT)
		
  );
  
  alu alu_mod (
		.A(DATA_A),
		.B(MUX_B),
		.OP(FS),
		.Y(DATA_D),
		.C(C),
		.V(V),
		.N(N),
		.Z(Z)
		
  );


  assign MUX_B = MB ? DATA_B : S_EXT;
  assign MUX_D = MD ? DATA_D : DATA_RAM;
  
  
  always @(*) begin
		
  
  end
  
  
  
  // ADD YOUR CODE ABOVE THIS LINE

endmodule
