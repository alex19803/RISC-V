module regFile(rs2, rs1, rd, datain, clk, reset, enable, reg_write, reg1, reg2);
		
		input [4:0] rs1, rs2, rd; 
		input [31:0] datain; 
		input clk, reset, reg_write, enable; 
		output reg [31:0] reg1, reg2;
		
		reg [31:0] regFile_contents[31:0]; reg[31:0] one, two;
		
		
		integer k;

		always @(posedge clk)
		begin
		if (reset==1'b1)
		begin
			for (k=0; k<31; k=k+1) 
			begin
				regFile_contents[k] = 31'b0;
			end
		end 

		else if (reg_write == 1'b1) begin 
			regFile_contents[rd] <= datain; 
		end
		else begin 
		 one = regFile_contents[rs1];
		 two = regFile_contents[rs2];
		 reg1 = rs1;
		 reg2 = rs2;
		end
		
end

endmodule
		
