module muxOSEL(ADD_Y, ADD_C, ADD_N, ADD_V, ADD_Z,
					SHIFT_Y, SHIFT_C, SHIFT_N, SHIFT_V, SHIFT_Z,
					LOGIC_Y, LOGIC_C, LOGIC_N, LOGIC_V, LOGIC_Z,
					OSEL, Y, C, N, V, Z);

	input [1:0] OSEL;
	input [7:0] ADD_Y, SHIFT_Y, LOGIC_Y;
	input ADD_C, ADD_N, ADD_V, ADD_Z;
	input SHIFT_C, SHIFT_N, SHIFT_V, SHIFT_Z;
	input LOGIC_C, LOGIC_N, LOGIC_V, LOGIC_Z;
	
	output reg C, N, V, Z;
	output [7:0] reg Y;
	
	parameter [1:0] ADD = 2'b00,
						 SHIFT = 2'b01,
						 LOGIC = 2'b10;
						 
	always @(*) begin
		if (OSEL == SHIFT) begin
			C <= SHIFT_C;
			N <= SHIFT_N;
			V <= SHIFT_V;
			Z <= SHIFT_Z;
			Y <= SHIFT_Y;
		end
		else if (OSEL == LOGIC) begin
			C <= LOGIC_C;
			N <= LOGIC_N;
			V <= LOGIC_V;
			Z <= LOGIC_Z;
			Y <= LOGIC_Y;
		end
		else begin // default is adder
			C <= ADD_C;
			N <= ADD_N;
			V <= ADD_V;
			Z <= ADD_Z;
			Y <= ADD_Y;
		end
	end
endmodule