module ControlUnit(instr, clk, wEn, ALUOp, ImmSel, BSel,
MemRW, WBSel, ASel, PCSel, BrUn, BrEq, BrLT);

input [31:0] instr;
input clk;
input BrEq, BrLT;
output reg MemRW, wEn, WBSel, PCSel, ImmSel, ASel, BSel, BrUn;
output reg [3:0] ALUOp;

reg [2:0] funct3;
reg [6:0] funct7, opcode;

always @ (posedge clk) begin
	opcode <= instr[6:0];
	funct3 <= instr[14:12];
	funct7 <= instr[31:25];
	BrUn	 <= 0;
	
	
	 // Control signal generation based on opcode and funct3
			case (opcode)
            7'b0110011: begin// R-type instructions
                ImmSel <= 0; //No imm in R type	
					 wEn    <= 0; //All R type 0->1, FIGURE OUT
					 ASel	  <= 0;
					 BSel	  <= 0;
					 WBSel  <= 1;
					 PCSel  <= 0;
					 
						case (funct3)
							3'b000: ALUOp <= 4'b0000; //ADD
                     3'b001: ALUOp <= 4'b0001; //SUB
							3'b010: ALUOp <= 4'b0010; //AND
							3'b011: ALUOp <= 4'b0011; //OR
							3'b100: ALUOp <= 4'b0100; //XOR
							3'b101: ALUOp <= 4'b0101; //Leftshift
							3'b110: ALUOp <= 4'b0110; //Rightshift
						endcase
					end
						
            7'b0010011: begin// I-type instructions
					ImmSel <= 1; //Imm needed for I type
					wEn    <= 0; //All I type 0->1, FIGURE OUT
					ASel	 <= 0;
					BSel	 <= 1;
					WBSel  <= 1;
					PCSel  <= 0;
					
						case (funct3)
							3'b000: ALUOp <= 4'b0000; //ADD
							3'b001: ALUOp <= 4'b0001; //SUB
							3'b010: ALUOp <= 4'b0010; //AND
							3'b011: ALUOp <= 4'b0011; //OR
							3'b100: ALUOp <= 4'b0100; //XOR
							3'b101: ALUOp <= 4'b0101; //Leftshift
							3'b110: ALUOp <= 4'b0110; //Rightshift
						endcase
					end
						
            7'b1100011: begin // B-type instructions
					ALUOp	 <= 4'b0000; //ADD
					ImmSel <= 1; //Imm needed for B type
					wEn    <= 0; //B type are read only
					ASel	 <= 1;
					BSel	 <= 1;
					//PCSel CONDITIONAL DO IN BRANCH COMPARATOR
						case(funct3)
						  3'b000:
								if (BrEq == 1)
									 PCSel = 1;
								else
									 PCSel = 0;
						  3'b001:
								if (BrEq == 0)
									 PCSel = 1;
								else
									 PCSel = 0;
						  3'b100:
								if (BrLT == 1)
									 PCSel = 1;
								else
									 PCSel = 0;
						  3'b101:
								if (BrLT == 0 && BrEq ==0)
									 PCSel = 1;
						  else
									 PCSel = 0;
						  default:

								PCSel = 0;
					 endcase
						end

        endcase
	
	
	
	
end


       
endmodule 
