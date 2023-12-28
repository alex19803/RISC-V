module ROMEM(clk, memaddr, enable, rd, rs1, rs2, memout); //256 words: 256 x 32
//no reset in ROM; has enable, clock, memory address, and output addrout
//ROM reads input memory address (addr) and sends mem
//concacate memory address location and content into addrout

input clk; input enable; input [31:0]memaddr;
output reg [4:0] rd, rs1, rs2;
output reg [31:0]memout; 

reg [31:0]temp;
reg [7:0]imem[1023:0]; //256 words *4 bytes  x 8 bits

initial begin
	 //ADD   1+1
	 imem[0] =  8'b00110011; //byte 0
	 imem[1] =  8'b10000000; //byte 1
	 imem[2] =  8'b00010000; //byte 2
	 imem[3] =  8'b00000000; //byte 3

	 //SUB	2-2
	 imem[4] =  8'b10110011; 
	 imem[5] =  8'b00010000;
	 imem[6] =  8'b00100001; 
	 imem[7] =  8'b01000000; 
	 
	 //AND	31&31
	 imem[8] =  8'b00110011; 
	 imem[9] =  8'b10100001; 
	 imem[10] = 8'b11111111; 
	 imem[11] = 8'b00000001; 
	 
	 //OR		2|1
	 imem[12] = 8'b10110011; 
	 imem[13] = 8'b00110001; 
	 imem[14] = 8'b00010001; 
	 imem[15] = 8'b00000000; 
	 
	 //ADDI	1+1
	 imem[16] = 8'b00010011; 
	 imem[17] = 8'b10000010; 
	 imem[18] = 8'b00010000; 
	 imem[19] = 8'b00000000; 
	 
	 //ANDI	31&0
	 imem[20] = 8'b10010011; 
	 imem[21] = 8'b10100010; 
	 imem[22] = 8'b00001111; 
	 imem[23] = 8'b00000000; 
	 
	 //XORI	31^0
	 imem[24] = 8'b00010011; 
	 imem[25] = 8'b11001011; 
	 imem[26] = 8'b00001111; 
	 imem[27] = 8'b00000000; 
	 
	 //SLI	
	 imem[28] = 8'b10010011; 
	 imem[29] = 8'b01010011; 
	 imem[30] = 8'b00010011; 
	 imem[31] = 8'b00000000; 
	 
	 //SRI	
	 imem[32] = 8'b00010011; 
	 imem[33] = 8'b01100100; 
	 imem[34] = 8'b00010011; 
	 imem[35] = 8'b00000000; 
	 
	 //ORI	2|3 
	 imem[36] = 8'b10010011; 
	 imem[37] = 8'b00110100; 
	 imem[38] = 8'b00110001; 
	 imem[39] = 8'b00000000; 
	 
	 //ADD   9+1
	 imem[40] =  8'b00110011; //byte 0
	 imem[41] =  8'b10000000; //byte 1
	 imem[42] =  8'b10010000; //byte 2
	 imem[43] =  8'b00000000; //byte 3

	 //SUB	9-8
	 imem[44] =  8'b10110011; 
	 imem[45] =  8'b10010000;
	 imem[46] =  8'b10000100; 
	 imem[47] =  8'b01000000; 
	 
	 //AND	24&16
	 imem[48] = 8'b00110011; 
	 imem[49] = 8'b00100001; 
	 imem[50] = 8'b10001000; 
	 imem[51] = 8'b00000001; 
	 
	 //OR		4|2
	 imem[52] = 8'b10110011; 
	 imem[53] = 8'b00110001; 
	 imem[54] = 8'b01000001; 
	 imem[55] = 8'b00000000; 
	 
	 //ADDI	1+8
	 imem[56] = 8'b00010011; 
	 imem[57] = 8'b10000010; 
	 imem[58] = 8'b10000000; 
	 imem[59] = 8'b00000000; 
	 
	 //ANDI	31&4
	 imem[60] = 8'b10010011; 
	 imem[61] = 8'b10100010; 
	 imem[62] = 8'b01001111; 
	 imem[63] = 8'b00000000; 
	 
	 //XORI	31^1
	 imem[64] = 8'b00010011; 
	 imem[65] = 8'b11001011; 
	 imem[66] = 8'b00011111; 
	 imem[67] = 8'b00000000; 
	 
	 //SLI	
	 imem[68] = 8'b10010011; 
	 imem[69] = 8'b11010011; 
	 imem[70] = 8'b00100000; 
	 imem[71] = 8'b00000000; 
	 
	 //SRI	
	 imem[72] = 8'b00010011; 
	 imem[73] = 8'b11100100; 
	 imem[74] = 8'b10000000; 
	 imem[75] = 8'b00000000; 
	 
	 //ORI	6|4 
	 imem[76] = 8'b10010011; 
	 imem[77] = 8'b00110100; 
	 imem[78] = 8'b01000011; 
	 imem[79] = 8'b00000000; 
	 end
	 
always @(posedge clk) begin

if (enable == 1) begin
			temp = {imem[memaddr+3], imem[memaddr+2], imem[memaddr+1], imem[memaddr]};
			rd = temp[11:7]; rs1 = temp[19:15]; rs2 = temp[24:20];
			memout = temp[31:0];
end

end

endmodule
