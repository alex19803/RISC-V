module RAM(clk, memaddr, enable, memout, rst, RW, datain); //256 words: 256 x 32

input clk; input enable; input rst; input RW; input [9:0]memaddr; input [31:0] datain;
output reg [31:0]memout; 
//ROM reads input memory address (addr) and sends mem
//concacate memory address location and content into addrout
reg [7:0] imem[1023:0]; //256 words * 4 bits or 1 byte, 
integer i;

always @(posedge clk) begin



    if (rst) begin
            for(i=0; i<1024; i=i+1) begin
                imem[i] = 0;                  //i+1;
            end
				end
				

        else if(RW==0 && enable && rst==0) begin
                memout = {imem[memaddr+3], imem[memaddr+2], imem[memaddr+1], imem[memaddr]};
                end
					 
        else if(RW==1 && enable && rst==0) begin
                    imem[memaddr]       <= datain[7:0];
                    imem[memaddr+1]     <= datain[15:8];
                    imem[memaddr+2]     <= datain[23:16];
                    imem[memaddr+3]     <= datain[31:24];
                end
end
endmodule
