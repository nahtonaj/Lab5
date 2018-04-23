// Prelab 5a test

// sets the granularity at which we simulate
`timescale 1 ns / 1 ps


// name of the top-level module; for us it should always be <module name>_test
// this top-level module should have no inputs or outputs; only internal signals are needed
module alu_test();

  // for all of your input pins, declare them as type reg, and name them identically to the pins
  reg  [7:0]  A;
  reg  [7:0]  B;
  reg  [2:0]  OP;

  // for all of your output pins, declare them as type wire so ModelSim can display them
  wire [7:0]  Y;
  wire        C;
  wire        V;
  wire        N;
  wire        Z;
  
  // variables for tracking stats
  localparam totalTests = 7;
  integer currentTestFailed;
  integer numTestsFailed;
  
  // declare a sub-circuit instance (Unit Under Test) of the circuit that you designed
  // make sure to include all ports you want to see, and connect them to the variables above
  alu UUT(
    .A(A),
    .B(B),
    .OP(OP),
    .Y(Y),
    .C(C),
    .V(V),
    .N(N),
    .Z(Z) // remember - no comma after the last port          
  );

  // ALL of the initial and always blocks below will work in parallel.
  //   Starting at time t = 0, they will all start counting the number
  //   of ticks.

  
  // TEST CASES: add your test cases in the block here
  // REMEMBER: separate each test case by delays that are multiples of #100, so we can see
  //    the output for at least one cycle (since we chose a 10 MHz clock)
  initial
  begin
    // 0 + 0 = 0, CVNZ=0001
    A  = 8'h0;
    B  = 8'h0;
    OP = 3'b000;
    numTestsFailed = 0;
    currentTestFailed = 0;
    
    #100;
    
    $display("MSIM>");
    if(Y == 8'h0 && C == 1'b0 && V == 1'b0 && N == 1'b0 && Z == 1'b1) begin
      $display("MSIM> ADD is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: ADD is incorrect for A = %8b, B = %8b: Y = %8b (should be 0), CVNZ = %1b%1b%1b%1b (should be 0001)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end

    numTestsFailed = numTestsFailed + currentTestFailed;

    // ADD MORE TESTS CASES HERE
	 
	 // 127 + 1 = -128, CNVZ=0110
	 A = 8'b01111111;
	 B = 8'b00000001;
	 OP = 3'b000;
	 
	 #100
	 
	 $display("MSIM>");
    if(Y == 8'b10000000 && C == 1'b0 && V == 1'b1 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> ADD is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: ADD is incorrect for A = %8b, B = %8b: Y = %8b (should be 10000000), CVNZ = %1b%1b%1b%1b (should be 0110)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end

    numTestsFailed = numTestsFailed + currentTestFailed;
	 
	 // -128 + -1 = 127, CVNZ=1100
	 A = 8'b10000000;
	 B = 8'b11111111;
	 OP = 3'b000;
	 
	 #100
	 
	 $display("MSIM>");
    if(Y == 8'b01111111 && C == 1'b1 && V == 1'b1 && N == 1'b0 && Z == 1'b0) begin
      $display("MSIM> ADD is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: ADD is incorrect for A = %8b, B = %8b: Y = %8b (should be 01111111), CVNZ = %1b%1b%1b%1b (should be 1100)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end

    numTestsFailed = numTestsFailed + currentTestFailed;
	 
	 // 1 + 1 = 2, CVNZ=0000
	 A = 8'b00000001;
	 B = 8'b00000001;
	 OP = 3'b000;
	 
	 #100
	 
	 $display("MSIM>");
    if(Y == 8'b00000010 && C == 1'b0 && V == 1'b0 && N == 1'b0 && Z == 1'b0) begin
      $display("MSIM> ADD is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: ADD is incorrect for A = %8b, B = %8b: Y = %8b (should be 00000010), CVNZ = %1b%1b%1b%1b (should be 0000)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end

    numTestsFailed = numTestsFailed + currentTestFailed;
	 
	 // -1 + -1 = -2, CVNZ=1010
	 A = 8'b11111111;
	 B = 8'b11111111;
	 OP = 3'b000;
	 
	 #100
	 
	 $display("MSIM>");
    if(Y == 8'b11111110 && C == 1'b1 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> ADD is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: ADD is incorrect for A = %8b, B = %8b: Y = %8b (should be 11111110), CVNZ = %1b%1b%1b%1b (should be 1010)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end

    numTestsFailed = numTestsFailed + currentTestFailed;
	 
	 // 1 + -1 = 0, CVNZ=1001
	 A = 8'b00000001;
	 B = 8'b11111111;
	 OP = 3'b000;
	 
	 #100
	 
	 $display("MSIM>");
    if(Y == 8'b00000000 && C == 1'b1 && V == 1'b0 && N == 1'b0 && Z == 1'b1) begin
      $display("MSIM> ADD is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: ADD is incorrect for A = %8b, B = %8b: Y = %8b (should be 00000000), CVNZ = %1b%1b%1b%1b (should be 1001)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end

    numTestsFailed = numTestsFailed + currentTestFailed;
	 
    // 11110000 shift left, CVNZ=1010
	 A = 8'b11110000;
	 B = 8'b00000000;
	 
	 // SLL code = 100
	 OP = 3'b100;
	 
	 #100
	 
	 $display("MSIM>");
    if(Y == 8'b11100000 && C == 1'b1 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> SLL is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: SLL is incorrect for A = %8b, B = %8b: Y = %8b (should be 11100000), CVNZ = %1b%1b%1b%1b (should be 1010)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end

    numTestsFailed = numTestsFailed + currentTestFailed;
	 
	 // 11110000 logical shift right, CVNZ=0000
	 A = 8'b11110000;
	 B = 8'b00000000;
	 
	 // SRL code = 011
	 OP = 3'b011;
	 
	 #100
	 
	 $display("MSIM>");
    if(Y == 8'b01111000 && C == 1'b0 && V == 1'b0 && N == 1'b0 && Z == 1'b0) begin
      $display("MSIM> SRL is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: SRL is incorrect for A = %8b, B = %8b: Y = %8b (should be 01111000), CVNZ = %1b%1b%1b%1b (should be 0000)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end
	 
	 numTestsFailed = numTestsFailed + currentTestFailed;
	 
	 // 11110000 arithmetic shift right, CVNZ=0010
	 A = 8'b11110000;
	 B = 8'b00000000;
	 
	 // SRA code = 010
	 OP = 3'b010;
	 
	 #100
	 
	 $display("MSIM>");
    if(Y == 8'b11111000 && C == 1'b0 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> SRA is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: SRA is incorrect for A = %8b, B = %8b: Y = %8b (should be 11111000), CVNZ = %1b%1b%1b%1b (should be 0010)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end

    numTestsFailed = numTestsFailed + currentTestFailed;
	 
	 // 2 - 1 subtraction, CVNZ=1000
	 A = 8'b00000010;
	 B = 8'b00000001;
	 
	 // SUB code = 001
	 OP = 3'b001;
	 
	 #100
	 
	 $display("MSIM>");
    if(Y == 8'b00000001 && C == 1'b1 && V == 1'b0 && N == 1'b0 && Z == 1'b0) begin
      $display("MSIM> SUB is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: SUB is incorrect for A = %8b, B = %8b: Y = %8b (should be 00000001), CVNZ = %1b%1b%1b%1b (should be 1000)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end

    numTestsFailed = numTestsFailed + currentTestFailed;
	 
	 // 11111111 AND 01010101, CVNZ=0000
	 A = 8'b11111111;
	 B = 8'b01010101;
	 
	 // AND code = 101
	 OP = 3'b101;
	 
	 #100
	 
	 $display("MSIM>");
    if(Y == 8'b01010101 && C == 1'b0 && V == 1'b0 && N == 1'b0 && Z == 1'b0) begin
      $display("MSIM> AND is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: AND is incorrect for A = %8b, B = %8b: Y = %8b (should be b01010101), CVNZ = %1b%1b%1b%1b (should be 0000)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end

    numTestsFailed = numTestsFailed + currentTestFailed;
	 
	 // 10101010 OR 01010101, CVNZ=0010
	 A = 8'b10101010;
	 B = 8'b01010101;
	 
	 // OR code = 110
	 OP = 3'b110;
	 
	 #100
	 
	 $display("MSIM>");
    if(Y == 8'b11111111 && C == 1'b0 && V == 1'b0 && N == 1'b1 && Z == 1'b0) begin
      $display("MSIM> OR is correct for A = %8b, B = %8b: Y = %8b, CVNZ = %1b%1b%1b%1b", A, B, Y, C, V, N, Z);
    end
    else begin
      // note that we have to fill in the expected values by hand here, so we can make sure what our outputs should have been
      $display("MSIM> ERROR: OR is incorrect for A = %8b, B = %8b: Y = %8b (should be 11111111), CVNZ = %1b%1b%1b%1b (should be 0010)", A, B, Y, C, V, N, Z);
      currentTestFailed = 1;
    end

    numTestsFailed = numTestsFailed + currentTestFailed;
	 
	 
    // END TEST CASES
    
    // print final score
    $display("MSIM> ");
    $display("MSIM> Number of tests failed: %2d", numTestsFailed);

    // Once our tests are done, we need to tell ModelSim to explicitly stop once we are
    // done with all of our test cases.
    $stop;
  end 

endmodule
