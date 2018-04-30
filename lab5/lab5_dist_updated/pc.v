module pc(CLK, RESET, PC, NEXT_PC, H, MP, OFF);

	input        RESET, CLK, H;
	input	       MP;
	input  [5:0] OFF;
	output [7:0] PC, NEXT_PC;
	reg 	 [7:0] PC;	 
	wire 	 [7:0] SEXT_IMM, BRANCH_TARGET, REG_BRANCH;
	
	assign BRANCH_TARGET = (SEXT_IMM << 1) + PC;
	assign REG_BRANCH = PC + 8'd2;
	assign NEXT_PC = H ? (MP ? BRANCH_TARGET : REG_BRANCH) : PC;
	
	always @(posedge CLK) begin
		if(RESET) begin
			PC <= 8'b0;
		end
		else begin
			PC <= NEXT_PC;
		end
	end
	
	// sext includes shift
	sext sext_module(
		.IMM(OFF),
		.OUT(SEXT_IMM)
	);
	
endmodule
