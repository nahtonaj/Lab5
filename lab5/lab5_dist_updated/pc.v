module pc(CLK, RESET, PC, NEXT_PC);

	input        RESET, CLK;
	output [7:0] PC, NEXT_PC;
	reg 	 [7:0] PC;
	
	always @(posedge CLK) begin
		if (CLK) begin
			PC = 0;
		end
	end
	
	assign NEXT_PC

endmodule