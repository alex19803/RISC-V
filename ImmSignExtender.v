module ImmSignExtender(enable, imm, signextimm, clk);
input enable;
input [11:0] imm;
output wire [31:0] signextimm;
input clk;

reg [19:0] setsign;

always @(posedge clk) begin 

if(enable) begin

setsign = {{20{imm[11]}}, imm};

end
end

assign signextimm = {setsign[19:0], imm[11:0]};

endmodule

