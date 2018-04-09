module muxADD(CISEL, CIout, BSEL, Bout, Bin);
  
  // inputs
  input  CISEL;
  input  BSEL;
  input  [7:0] Bin;
  
  // outputs
  output CIout;
  output [7:0] Bout;

  // MUX LOGIC:
  //   if   CISEL == 0 => CIout = 0
  //   else            => CIout = 1
  assign CIout = (CISEL == 1'b0) ? 1'b0 : 1'b1;
  
  // 	 if   BSEL  == 1 => Bout = ~B
  //   else				  => Bout = B
  assign Bout = (CISEL == 1'b1) ? ~B : B;
  
endmodule