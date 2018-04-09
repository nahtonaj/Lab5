module shifter(A, Y, LA, LR, C, V); // add all inputs and outputs inside parentheses

  // inputs
  input 				 LA, LR;
  input [7:0]  	 A;

  // outputs
  output 			 C, V
  output reg [7:0] Y;
  
  // reg and internal variable definitions
  wire SI;

  // implement module here
  
  // if arithmetic shift, assign SI as MSB, 
  // otherwise SI is 0.
  assign SI = LA ? A[7] : 1'b0;
  
  // if right shift, assign LSB to SO,
  // otherwise SO is MSB.
  assign C = LR ? A[0] : A[7];
  
  // shifting left and shifting right
  always @(*)begin
	if(LR) begin // right shift
		Y[7] <= SI;
		Y[6] <= A[7];
		Y[5] <= A[6];			
		Y[4] <= A[5];
		Y[3] <= A[4];
		Y[2] <= A[3];
		Y[1] <= A[2];
		Y[0] <= A[1];
	end
	else begin // left shift
		Y[7] <= A[6];
		Y[6] <= A[5];
		Y[5] <= A[4];
		Y[4] <= A[3];
		Y[3] <= A[2];
		Y[2] <= A[1];
		Y[1] <= A[0];
		Y[0] <= SI;
	 end
  end
  
  // overflow detection
  assign V = 0;
  
endmodule
