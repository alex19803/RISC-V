module PROCESSOR_TB;

    reg clk;
    reg toggle;
    reg [31:0]Instr;
	 wire [31:0]P_out;
	 wire [4:0] pcrs1;
	 wire [4:0] pcrs2;
	 wire [4:0] pcrd;
	 wire [31:0] pcImm_OUT;
	 wire [6:0] pcOPcode;
	 wire [3:0] pcALUop;
	 wire BrEQ, BrLt, preg_write, pImmSel, BSeL, BrUN, ASeL, MemRw, WBSeL;

    PROCESSOR P1(
        .clk(clk),
        .toggle(toggle),
		  .Instr(Instr),
		  .pcOPcode(pcOPcode),
		  .pcALUop(pcALUop),
		  .pcrs1(pcrs1),
		  .pcrs2(pcrs2),
		  .pcrd(pcrd),
		  .pcImm_OUT(pcImm_OUT),
		  .P_out(P_out),
		  .BrEQ(BrEQ),
		  .BrLt(BrLt),
		  .preg_write(preg_write),
		  .pImmSel(pImmSel),
		  .BSeL(BSeL),
		  .BrUN(BrUN),
		  .ASeL(ASeL),
		  .MemRw(MemRw),
		  .WBSeL(WBSeL)
    );

    
  //clock signal 
  initial begin
  clk = 0;
  end 
  always begin
    #5 clk = ~clk; //repeating clock signal
  end

  //stim gen and input declaration
    initial begin
        toggle = 1;
		  Instr = 0;
		  #100
		  
	
		  repeat (19) begin
				Instr = Instr + 4;
		  #100;
        	  end
		  #100;
		  
		  $finish;

		  end
endmodule
