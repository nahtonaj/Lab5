module decoder(INST, DR, SA, SB, IMM, MB, FS, MD, LD, MW, BS, OFF, HALT);

// instruction to be parsed
input [15:0] INST;
output 		 OFF, HALT, BS;

output reg
	// ALU input mux select (0=DataB, 1=IMM)
	MB, 
	// output mux select (0=ALU, 1=data ram)
	MD, 
	// register file write enable
	LD, 
	// data ram write enable
	MW;
output reg [5:0] 
	// 6-bit signed immediate
	IMM;
output reg [2:0]  
	// register file write address
	DR, 
	// register file read address A 
	SA, 
	// register file read address B 
	SB, 
	// ALU function
	FS;
	
reg [3:0] OP;
reg [2:0] RS, RT, RD, FUNCT;

// OP codes
parameter [3:0] NOP = 4'b0000,
					 LB = 4'b0010,
					 SB_OP = 4'b0100,
					 ADDI = 4'b0101,
					 ANDI = 4'b0110,
					 ORI = 4'b0111,
					 R2R = 4'b1111;
					 
// instruction format
// register to register
// OP [15:12], RS [11:9], RT [8:6], RD [5:3], FUNCT [2:0]
// immediate
// OP [15:12], RS [11:9], RT [8:6], IMM [5:0]

always @(*) begin
		OP = INST[15:12];
		RS = INST[11:9];
		RT = INST[8:6];
		IMM = INST[5:0];
		RD = INST[5:3];
		FUNCT = INST[2:0];
		
		case(OP)
			NOP: 
			begin
				DR = RD; SA = RS; SB = RT; 
				LD = 1'b0; MW = 1'b0;
				FS = FUNCT;
			end
			LB: 
			begin 
				DR = RT; SA = RS; 
				MB = 1'b1; MD = 1'b1; LD = 1'b1; MW = 1'b0;
			end
			SB_OP: 
			begin 
				DR = RT; SA = RS;
				MB = 1'b1; LD = 1'b0; MW = 1'b1;
			end
			ADDI: 
			begin 
				DR = RT; SA = RS;
				MB = 1'b1; MD = 1'b0; LD = 1'b1; MW = 1'b0;
			end
			ANDI: 
			begin 
				DR = RT; SA = RS;
				MB = 1'b1; MD = 1'b0; LD = 1'b1; MW = 1'b0;
			end
			ORI: 
			begin 
				DR = RT; SA = RS;
				MB = 1'b1; MD = 1'b0; LD = 1'b1; MW = 1'b0;
			end
			default: 
			begin 
				DR = RD; SA = RS; SB = RT;
				MB = 1'b0; MD = 1'b0; LD = 1'b1; MW = 1'b0;
				FS = FUNCT;
			end
		endcase
end

endmodule
