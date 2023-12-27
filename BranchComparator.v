module BranchComparator(reg1, reg2, BrUn, clk, BrLT, BrEq);

input [31:0] reg1, reg2;
input BrUn, clk;
output reg BrLT, BrEq;

always @ (posedge clk) begin
    if (reg1 < reg2) begin
        BrLT <= 1;
        BrEq <= 0;
    end
    else if (reg1 == reg2) begin
        BrLT <= 0;
        BrEq <= 1;
    end
    else begin
        BrLT <= 0;
        BrEq <= 0;
    end

end
endmodule
