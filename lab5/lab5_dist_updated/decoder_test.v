// Prelab 5a test
// Author: Ritchie Zhao
// Mar 14, 2016

// sets the granularity at which we simulate
`timescale 1 ns / 1 ps


// name of the top-level module; for us it should always be <module name>_test
// this top-level module should have no inputs or wires; only internal signals are needed
module decoder_test();

  // for all of your input pins, declare them as type reg, and name them identically to the pins
  reg         CLK;
  reg         RESET;
  
  // for all of your wire pins, declare them as type wire so ModelSim can display them
  wire [2:0]  DR;
  wire [2:0]  SA;
  wire [2:0]  SB;
  wire [5:0]  IMM;
  wire		    MB;
  wire [2:0]  FS;
  wire 		    MD;
  wire		    LD;
  wire		    MW;
  
  wire [2:0]  DR_REF;
  wire [2:0]  SA_REF;
  wire [2:0]  SB_REF;
  wire [5:0]  IMM_REF;
  wire		    MB_REF;
  wire [2:0]  FS_REF;
  wire 		    MD_REF;
  wire		    LD_REF;
  wire		    MW_REF;
  
  wire [7:0]  PC;
  wire [15:0] INST;
  
  decoder dec(
      .CLK(CLK),
      .RESET(RESET),
      
      .DR(DR),
      .SA(SA),
      .SB(SB),
      .IMM(IMM),
      .MB(MB),
      .FS(FS),
      .MD(MD),
      .LD(LD),
      .MW(MW),
      
//  		.DR_REF(DR_REF),
//      .SA_REF(SA_REF),
//      .SB_REF(SB_REF),
//      .IMM_REF(IMM_REF),
//      .MB_REF(MB_REF),
//      .FS_REF(FS_REF),
//      .MD_REF(MD_REF),
//      .LD_REF(LD_REF),
//      .MW_REF(MW_REF),
      
//      .PC(PC),
      .INST(INST)
  );
  
  // CLK50: generate a 10 MHz clock (rising edge does not start until
  //   50 ticks (50 ns) into simulation, and each clock cycle lasts for
  //   100 ticks (100 ns)
  initial begin
    CLK = 1'b0;
    forever begin
      #50
      CLK = ~CLK;
    end
  end
  
  // variables for tracking stats
  integer i;
  integer totalTests;
  integer currentTestFailed;
  integer numTestsFailed;
  
  // TEST CASES: add your test cases in the block here
  // REMEMBER: separate each test case by delays that are multiples of #100, so we can see
  //    the output for at least one cycle (since we chose a 10 MHz clock)
  initial
  begin
    // wait for rising clock edge
    #50;
    
    RESET = 1;
    numTestsFailed = 0;
    totalTests = 0;
    i = 0;

    #100;
    currentTestFailed = 0;
    
    //---------------------------------------------------------------
    // Main testing loop
    //---------------------------------------------------------------
    while(i <= 38) begin
      RESET = 0;
      #100;
      currentTestFailed = 0;
      $display("MSIM>");
			$display("MSIM> #%2d", totalTests);
			
			// r2r instructions
			if (INST[15] == 1) begin
        case (INST[2:0])
          3'b000: $display("MSIM> ADD");
          3'b001: $display("MSIM> SUB");
          3'b010: $display("MSIM> SRA");
          3'b011: $display("MSIM> SRL");
          3'b100: $display("MSIM> SLL");
          3'b101: $display("MSIM> AND");
          3'b110: $display("MSIM> OR");
        endcase
      
				$display("MSIM> INST = [%4b][%3b][%3b][%3b][%3b] (r2r)", INST[15:12], INST[11:9], INST[8:6], INST[5:3], INST[2:0]);
				
				// Add/Sub/And/Or
				if ((INST[2:0] == 3'b0) || (INST[2:0] == 3'b1) || (INST[2:0] == 3'b101) || (INST[2:0] == 3'b110)) begin
					$display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
					$display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
					$display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
					if((DR!=DR_REF) || (SA!=SA_REF) || (SB!=SB_REF))
						currentTestFailed = 1;
				end
				// Shift
				else begin
					$display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
					$display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
					if((DR!=DR_REF) || (SA!=SA_REF))
						currentTestFailed = 1;
				end
				 
				$display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL"); // ALU mux select
				$display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL"); // ALU func
				$display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL"); // output data mux select
				$display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL"); // rf write enable
				$display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL"); // dram write enable
				
				if((MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
					currentTestFailed = 1;
			end
			
		  // immediate instructions
		  else begin
        case (INST[14:12])
          3'b000: $display("MSIM> NOP");
          3'b010: $display("MSIM> LB");
          3'b100: $display("MSIM> SB");
          3'b101: $display("MSIM> ADDI");
          3'b110: $display("MSIM> ANDI");
          3'b111: $display("MSIM> ORI");
        endcase
        
				$display("MSIM> INST = [%4b][%3b][%3b][%6b] (imm)", INST[15:12], INST[11:9], INST[8:6], INST[5:0]);
			 
				// Addi/Andi/Ori/LB
				if ((INST[15:12] == 4'b0101) || (INST[15:12] == 4'b0110) || (INST[15:12] == 4'b0111) ||(INST[15:12] == 4'b0010)) begin
					$display("MSIM>   DR  = %3b\t\t\t[%s]", DR, DR==DR_REF ? " OK " : "FAIL");
					$display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
					$display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
					if((DR!=DR_REF) || (SA!=SA_REF) || (IMM!=IMM_REF))
						currentTestFailed = 1;
				end
				// SB
				else if (INST[15:12] == 4'b0100) begin
					$display("MSIM>   SA  = %3b\t\t\t[%s]", SA, SA==SA_REF ? " OK " : "FAIL");
					$display("MSIM>   SB  = %3b\t\t\t[%s]", SB, SB==SB_REF ? " OK " : "FAIL");
					$display("MSIM>   IMM = %6b\t\t[%s]",   IMM, IMM==IMM_REF ? " OK " : "FAIL");
					if((SA!=SA_REF) || (SB!=SB_REF) || (IMM!=IMM_REF))
						currentTestFailed = 1;
				end
				// not NOP
				if (INST[15:12] != 4'b0000) begin
					$display("MSIM>   MB  = %1b\t\t\t[%s]", MB, MB==MB_REF ? " OK " : "FAIL"); // ALU mux select
					$display("MSIM>   FS  = %3b\t\t\t[%s]", FS, FS==FS_REF ? " OK " : "FAIL"); // ALU func
					$display("MSIM>   MD  = %1b\t\t\t[%s]", MD, MD==MD_REF ? " OK " : "FAIL"); // output data mux select
					$display("MSIM>   LD  = %1b\t\t\t[%s]", LD, LD==LD_REF ? " OK " : "FAIL"); // rf write enable
					$display("MSIM>   MW  = %1b\t\t\t[%s]", MW, MW==MW_REF ? " OK " : "FAIL"); // dram write enable
					
					if((MB!=MB_REF) || (FS!=FS_REF) || (MD!=MD_REF) || (LD!=LD_REF) || (MW!=MW_REF))
						currentTestFailed = 1;
				end
		  end
        
      numTestsFailed = numTestsFailed + currentTestFailed;
      totalTests = totalTests + 1;
      
      i = i + 1;
    end
    
    // print final score
    $display("MSIM> ");
    $display("MSIM> Prelab 5b Score: %2d / %2d", totalTests-numTestsFailed, totalTests);

    // Once our tests are done, we need to tell ModelSim to explicitly stop once we are
    // done with all of our test cases.
    $stop;
  end

endmodule
