module muxBRANCH(Z, N, BS, MP);

	input Z, N;
	input [2:0] BS;
	output reg MP;
	
	// branching codes
	parameter [2:0] EQ = 3'b000, // Z flag raised
						 NE = 3'b001, // Z flag not raised
						 GEZ = 3'b010, // N flag not raised
						 LTZ = 3'b011, // N flag raised
						 NOTHING = 3'b100; // 0
						 
	always @(*) begin
		case(BS)
			EQ:      MP = Z;
			NE:      MP = ~Z;
			GEZ:     MP = ~N;
			LTZ:     MP = N;
			default: MP = 1'b0;
		endcase
	end

endmodule
	