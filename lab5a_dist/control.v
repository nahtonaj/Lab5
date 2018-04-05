module control(OP, CISEL, BSEL, OSEL, SHIFT_LA, SHIFT_LR, LOGICAL_OP); // add other inputs and outputs here

  // inputs (add others here)
  input  [2:0]  OP;
  
  // outputs (add others here)
  output        CISEL, BSEL, SHIFT_LA, SHIFT_LR, LOGICAL_OP;
  output reg [1:0] OSEL;
  // reg and internal variable definitions
  
  parameter [2:0] ADD = 3'b000,
						SUB = 3'b001;
						SRA = 3'b010,
						SRL = 3'b011,
						SLL = 3'b100,
						AND = 3'b101,
						OR =  3'b110;
						// PASS_A = 3'b111;
  
  // implement module here (add other control signals below)
  // if substraction, invert B and add 1
  assign CISEL = (OP == SUB) ? 1'b1 : 1'b0;
  assign BSEL = (OP == SUB) ? 1'b1 : 1'b0;
  
  // arithmetic = 1, logical = 0
  // right = 1, left = 0
  assign SHIFT_LA = (OP == SRA) ? 1'b1 : 1'b0;
  assign SHIFT_LR = (OP == SRL) ? 1'b1 : 1'b0;
  
  // AND = 1, OR = 0
  assign LOGICAL_OP = (OP == AND) ? 1'b1 : 1'b0;
  
  always @(*) begin
	if(OP == AND | OP == OR) OSEL <= 2'b10;
	else if(OP == SRA | OP == SRL | OP == SLL) OSEL <= 2'b01;
	else OSEL <= 2'b00; // adder module is default
  end
endmodule