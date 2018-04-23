module reg_file(CLK, RESET, SA, SB, LD, DR, D_in, DATA_A, DATA_B);
	input 		 LD, RESET, CLK;
	input  [2:0] SA, SB, DR;
	input  [7:0] D_in;
	output [7:0] DATA_A, DATA_B;
	integer 		 i;

	reg   [7:0] mem [7:0]; // 8-bit wide address
	
	always @(posedge CLK) begin
		if(RESET) begin
			for(i = 0; i < 8; i = i+1) begin
				mem[i] <= 8'b00000000;
			end
		end	
		else begin
			if(LD) begin
			  // i = 0;
				mem[DR] <= D_in;
			end
		end
	end
	
	
	assign DATA_A = mem[SA];
	assign DATA_B = mem[SB];
	
endmodule
