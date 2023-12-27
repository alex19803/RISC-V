module DMEM(        
	 input [12:0] memaddr, 
	 input clk,
	 input rw,
	 input reset,
	 input [31:0] datain, 
	 output reg [31:0]dmem             
	                                 
);

reg [7:0] enable;
wire [31:0] out0;
wire [31:0] out1;
wire [31:0] out2;
wire [31:0] out3;
wire [31:0] out4;
wire [31:0] out5;
wire [31:0] out6;
wire [31:0] out7;

always @(posedge clk)
begin
    case(memaddr[12:10])
        0: begin
		  enable[0] = 1;
		  enable[7:1] = 0;
		  end
        1: begin
		  enable[1] = 1;
		  enable[0] = 0;
		  enable[7:2] = 0;
		  end
        2: begin
		  enable[1:0] = 0;
		  enable[2] = 1;
		  enable[7:3] = 0;
		  end
        3: begin
		  enable[2:0] = 0;
		  enable[3] = 1;
		  enable[7:4] = 0;
		  end 
        4: begin
		  enable[3:0] = 0;
		  enable[4] = 1;
		  enable[7:5] = 0;
		  end
		  5: begin
		  enable[4:0] = 0;
		  enable[5] = 1;
		  enable[7:6] = 0;
		  end
		  6: begin
		  enable[5:0] = 0; 
		  enable[6] = 1;
		  enable[7] = 0;
		  end
		  7: begin
		  enable[6:0] = 0; 
		  enable[7] = 1;
		  end
        default: enable[7:0] = 0;      
    endcase
end

always @(posedge clk)
begin
    case(memaddr[12:10])
        0:dmem <= out0[31:0];
        1:dmem <= out1[31:0];
        2:dmem <= out2[31:0];
        3:dmem <= out3[31:0];
        4:dmem <= out4[31:0];
		  5:dmem <= out5[31:0];
		  6:dmem <= out6[31:0];
		  7:dmem <= out7[31:0];
        default: dmem <= 0;     
    endcase
end

   
//RAM instantiation
RAM M0(clk,memaddr[9:0], enable[0], out0, reset, rw, datain[31:0]);
RAM M1(clk,memaddr[9:0], enable[1], out1, reset, rw, datain[31:0]);
RAM M2(clk,memaddr[9:0], enable[2], out2, reset, rw, datain[31:0]);
RAM M3(clk,memaddr[9:0], enable[3], out3, reset, rw, datain[31:0]);
RAM M4(clk,memaddr[9:0], enable[4], out4, reset, rw, datain[31:0]);
RAM M5(clk,memaddr[9:0], enable[5], out5, reset, rw, datain[31:0]);
RAM M6(clk,memaddr[9:0], enable[6], out6, reset, rw, datain[31:0]);
RAM M7(clk,memaddr[9:0], enable[7], out7, reset, rw, datain[31:0]);

endmodule
