module ALU(ALUOp, opA, opB, clk, result);

input [3:0] ALUOp;
input clk;
input [31:0] opA, opB;
output reg [31:0] result;


always@(posedge clk)
begin
        case(ALUOp)
        4'b0000 : result <= opA +  opB;
        4'b0001 : result <= opA -  opB;
        4'b0010 : result <= opA &  opB;
        4'b0011 : result <= opA |  opB;
        4'b0100 : result <= opA ^  opB;
        4'b0101 : result <= opA << opB;
        4'b0110 : result <= opA >> opB;
        endcase
end
endmodule
