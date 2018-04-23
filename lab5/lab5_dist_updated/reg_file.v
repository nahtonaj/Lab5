module reg_file(RESET, SA, SB, LD, DR, D_in, DATA_A, DATA_B);
	input 		 LD;
	input  [2:0] SA, SB, DR;
	input  [7:0] D_in;
	output [7:0] DATA_A, DATA_B;
	integer 		 i;

	wire   [7:0] mem[0:7]; // 8-bit wide address
	
	/*parameter [2:0] zero = 3'b000,
						 one = 3'b001,
						 two = 3'b010,
						 three = 3'b011,
						 four = 3'b100,
						 five = 3'b101,
						 six = 3'b110,
						 seven = 3'b111;
	*/
	
	if(RESET) begin
		for(i = 0; i < 8; i = i+1) begin
			mem[i] <= 8'b00000000;
		end
	end
	
	if(LD) begin
		mem[DR] <= D_in;
	end
	
	assign DATA_A = mem[SA];
	assign DATA_B = mem[SB];
	
	
	
endmodule