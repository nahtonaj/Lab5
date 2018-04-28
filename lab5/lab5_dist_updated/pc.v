module pc(CLK, RESET, PC, NEXT_PC, H);

	input        RESET, CLK, H;
	output [7:0] PC, NEXT_PC;
	reg 	 [7:0] PC;
	
	assign NEXT_PC = H ? PC + 8'd2 : PC;
	always @(posedge CLK) begin
		if(RESET) begin
			PC = 8'b0;
		end
		else begin
			PC <= NEXT_PC;
		end
	end

endmodule