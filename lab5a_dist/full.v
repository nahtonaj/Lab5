module full(A, B, CI, C, S);
	input A, B, CI;
	output C, S;
	
	assign S = A ^ B ^ CI;
	assign C = (A & B) | (CI & (A ^ B));

endmodule