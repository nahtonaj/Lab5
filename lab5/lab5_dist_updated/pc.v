module pc(CLK, RESET, PC, NEXT_PC);

	input        RESET, CLK;
	output [7:0] PC, NEXT_PC;
	reg 	 [7:0] PC, NEXT_PC;
	
	always @(posedge CLK) begin
		if(RESET) begin
			PC = 0;
		end
		else begin
			PC = NEXT_PC;
			NEXT_PC = PC + 8'd2;
			
		end
	end

endmodule