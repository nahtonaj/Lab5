module sext(IMM, OUT);

input [5:0] IMM;
output reg [7:0] OUT;

wire SIGN = IMM[5];

always @(*) begin
	if (SIGN) begin
		OUT[7] = 1'b1;
		OUT[6] = 1'b1;
	end
	else begin
		OUT[7] = 1'b0;
		OUT[6] = 1'b0;
	end
	OUT[5:0] = IMM[5:0];
end

endmodule