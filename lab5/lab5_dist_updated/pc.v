module pc(CLK, RESET, PC, NEXT_PC, EN_L);

	input        RESET, CLK, EN_L;
	output [7:0] PC, NEXT_PC;
	reg 	 [7:0] PC;
	
	assign NEXT_PC = EN_L ? PC : PC + 8'd2;
	always @(posedge CLK) begin
		if(RESET) begin
			PC = 8'b0;
		end
		else begin
			PC <= NEXT_PC;
			
		end
	end

endmodule