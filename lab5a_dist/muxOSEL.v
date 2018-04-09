module muxOSEL(ADD_Y, ADD_C, ADD_V,
					SHIFT_Y, SHIFT_C, SHIFT_V,
					LOGIC_Y, LOGIC_C, LOGIC_V,
					OSEL, Y, C, N, V, Z);

	input [1:0] OSEL;
	input [7:0] ADD_Y, SHIFT_Y, LOGIC_Y;
	input ADD_C, ADD_V;
	input SHIFT_C, SHIFT_V;
	input LOGIC_C, LOGIC_V;
	
	output reg C, N, V, Z;
	output [7:0] reg Y;
	
	parameter [1:0] ADD = 2'b00,
						 SHIFT = 2'b01,
						 LOGIC = 2'b10;
						 
	always @(*) begin
		if (OSEL == SHIFT) begin
			C <= SHIFT_C;
			V <= SHIFT_V;
			Y <= SHIFT_Y;
		end
		else if (OSEL == LOGIC) begin
			C <= LOGIC_C;
			V <= LOGIC_V;
			Y <= LOGIC_Y;
		end
		else begin // default is adder
			C <= ADD_C;
			V <= ADD_V;
			Y <= ADD_Y;
		end
		N <= Y[7];
		Z <= ~(Y[7] | Y[6] | Y[5] | Y[4] | Y[3] | Y[2] | Y[1] | Y[0]);
	end
endmodule