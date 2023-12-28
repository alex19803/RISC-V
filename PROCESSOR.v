module PROCESSOR(
input clk, 
input toggle, 
input [31:0] Instr, 
output [4:0] pcrs1, pcrs2, pcrd, 
output [3:0] pcALUop, 
output [6:0] pcOPcode, 
output [31:0] pcImm_OUT, 
output [31:0] P_out,
output BrEQ, BrLt, preg_write, pImmSel, BSeL, BrUN, ASeL, MemRw, WBSeL
); 
     
	 reg [31:0] opA, opB, datain_reg, datain_dmem;
    wire reset, reg_write;
    wire [3:0] ALUOp;
    wire [4:0] rd, rs1, rs2;
	 wire BSel, ASel, ImmSel, BrUn, memrw, wEn, PCSel, WBSel;
	 wire [31:0] signextimm;
	 wire [11:0] imm;
	 wire BrEq, BrLT;
	 wire [12:0] mem_addr;
	 wire [31:0] reg1, reg2;
	 wire [31:0] dmem, result, memout;
	

    always @(posedge clk) begin
        if (toggle) begin
           opA = BSel?signextimm:reg1;      //opA set with reg1 or imm
			     datain_reg = WBSel?result:dmem;  //datain_reg set with result or dmem from dmem
			     opB = ASel?Instr:reg2;           //opB set with reg2 or instr
			   //pc = PCSel?result:memaddr+4;     //PC iteration performed in testbench
				
        end
    end 

ROMEM            M0(clk, Instr, toggle, rd, rs1, rs2, memout); 

regFile 			   M1(rs2[4:0], rs1[4:0], rd[4:0], datain_reg, clk, reset, toggle, reg_write, reg1[31:0], reg2[31:0]);

ImmSignExtender  M2(ImmSel, memout[31:20], signextimm, clk);

BranchComparator M3(reg1, reg2, BrUn, clk, BrLT, BrEq);

ControlUnit      M4(memout, clk, wEn, ALUOp[3:0], ImmSel, BSel, memrw, WBSel, ASel, PCSel, BrUn, BrEq, BrLT);

ALU 				     M5(ALUOp[3:0], opA[31:0], opB[31:0], clk, result);

DMEM 				     M6(memaddr, clk, memrw, reset, result, dmem);
 


assign P_out = datain_reg;
assign pcrs1 = rs1;
assign pcrs2 = rs2;
assign pcrd = rd;
assign pcOPcode = memout[6:0];
assign pcALUop = ALUOp;
assign pcImm_OUT = signextimm;
assign BrEQ = BrEq;
assign BrLt = BrLT;
assign pImmSel = ImmSel;
assign BSeL = BSel;
assign BrUN = BrUn;
assign ASeL = ASel;
assign MemRw = memrw;
assign WBSeL = WBSel;


endmodule
