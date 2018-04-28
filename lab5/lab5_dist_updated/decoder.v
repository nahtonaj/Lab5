module decoder(INST, DR, SA, SB, IMM, MB, FS, MD, LD, MW, BS, OFF, HALT);

// instruction to be parsed
input [15:0] INST;

// branch to be taken
output reg [3:0] BS;

output reg
	// ALU input mux select (0=DataB, 1=IMM)
	MB, 
	// output mux select (0=ALU, 1=data ram)
	MD, 
	// register file write enable
	LD, 
	// data ram write enable
	MW,
	OFF, HALT;
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
					 BEQ = 4'b1000,
					 BNE = 4'b1001,
					 BGEZ = 4'b1010,
					 BLTZ = 4'b1011,
					 R2R = 4'b1111;
					 
// branching codes
parameter [2:0] EQ = 3'b000, // Z flag raised
					 NE = 3'b001, // Z flag not raised
					 GEZ = 3'b010, // N flag not raised
					 LTZ = 3'b011, // N flag raised
					 NOTHING = 3'b100; // 0
					 
// instruction format
// register to register
// OP [15:12], RS [11:9], RT [8:6], RD [5:3], FUNCT [2:0]
// immediate
// OP [15:12], RS [11:9], RT [8:6], IMM [5:0]

always @(*) begin
		OP <= INST[15:12];
		RS <= INST[11:9];
		RT <= INST[8:6];
	   IMM <= INST[5:0];
		RD <= INST[5:3];
		FUNCT <= INST[2:0];
		OFF <= IMM;
		
		case(OP)
			NOP: 
			begin
				DR = RD; SA = RS; SB = RT; 
				MB = 1'b0; MD = 1'b0; LD = 1'b0; MW = 1'b0;
				FS = FUNCT; BS = NOTHING; 
				if(FUNCT == 3'b001)begin
					HALT = 1'b1;
				end
				else begin
					HALT = 1'b0;
				end
			end
			LB: 
			begin 
				DR = RT; SA = RS; SB = 3'b000; //don't care
				MB = 1'b1; MD = 1'b1; LD = 1'b1; MW = 1'b0;
				FS = 3'b000; //ADD IMM to RS
				BS = NOTHING; HALT = 1'b0; 
			end
			SB_OP: 
			begin 
				DR = 3'b000; SA = RS; SB = RT; 
				MB = 1'b1; MD = 1'b1; LD = 1'b0; MW = 1'b1;
				FS = 3'b000; //ADD IMM to RS
				BS = NOTHING; HALT = 1'b0; 
			end
			ADDI: 
			begin 
				DR = RT; SA = RS; SB = 3'b000; //don't care
				MB = 1'b1; MD = 1'b0; LD = 1'b1; MW = 1'b0;
				FS = 3'b000; //ADD IMM to RS
				BS = NOTHING; HALT = 1'b0; 
			end
			ANDI: 
			begin 
				DR = RT; SA = RS; SB = 3'b000; //don't care
				MB = 1'b1; MD = 1'b0; LD = 1'b1; MW = 1'b0;
				FS = 3'b101; //AND IMM and RS
				BS = NOTHING; HALT = 1'b0; 
			end
			ORI: 
			begin 
				DR = RT; SA = RS; SB = 3'b000; //don't care
				MB = 1'b1; MD = 1'b0; LD = 1'b1; MW = 1'b0;
				FS = 3'b110; //OR IMM and RS
				BS = NOTHING; HALT = 1'b0; 
			end
			
			// branching operations
			BEQ:
			begin 
				DR = 3'b000; SA = RS; SB = RT; //don't care
				MB = 1'b1; MD = 1'b0; LD = 1'b0; MW = 1'b0;
				FS = 3'b001; //SUB RS and RT
				BS = EQ; HALT = 1'b0; 
			end
			BNE:
			begin 
				DR = 3'b000; SA = RS; SB = RT; //don't care
				MB = 1'b1; MD = 1'b0; LD = 1'b0; MW = 1'b0;
				FS = 3'b001; //SUB RS and RT
				BS = NE; HALT = 1'b0; 
			end
			BGEZ:
			begin 
				DR = 3'b000; SA = RS; SB = RT; //don't care
				MB = 1'b1; MD = 1'b0; LD = 1'b0; MW = 1'b0;
				FS = 3'b001; //SUB RS and RT
				BS = GEZ; HALT = 1'b0; 
			end
			BLTZ:
			begin 
				DR = 3'b000; SA = RS; SB = RT; //don't care
				MB = 1'b1; MD = 1'b0; LD = 1'b0; MW = 1'b0;
				FS = 3'b001; //SUB RS and RT
				BS = LTZ; HALT = 1'b0; 
			end
			default: 
			begin 
				DR = RD; SA = RS; SB = RT;
				MB = 1'b0; MD = 1'b0; LD = 1'b1; MW = 1'b0;
				FS = FUNCT; //function for R-type instructions
				BS = NOTHING; HALT = 1'b0; 
			end
		endcase
		
end

endmodule
