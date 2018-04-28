module halt_logic(CLK, HALT, EN_L, H);
	input HALT, EN_L, CLK; // note: EN_L is active low
	output reg H;
	
	wire currEN_L;
	reg prevEN_L;
	
	assign currEN_L = EN_L; 
	
	always @(posedge CLK) begin
		prevEN_L = currEN_L;
	end
	
	always @(*) begin
		if(HALT) begin
			if(prevEN_L == 1'b1 && currEN_L == 1'b0) H = 1'b1;
			else H = 1'b0;	
		end
		else begin
			H = 1'b1;
		end
	end

endmodule