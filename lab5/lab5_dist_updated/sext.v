module sext(IMM, OUT);

input [5:0] IMM;
output [5:0] OUT;

wire SIGN = IMM[5];

assign OUT = SIGN ? (8'b0 | IMM): (8'b11111111 & IMM);

endmodule