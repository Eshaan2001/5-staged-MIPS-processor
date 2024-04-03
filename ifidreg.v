module ifid (
input clk,
input reset,
input [31:0] addressin,
input [31:0] instructionin,
output reg [31:0] addressout,
output reg [31:0] instructionout
);


always @(posedge clk or posedge reset)
begin
	if(reset)
	begin
	addressout <= 32'b00000000000000000000000000000000;
	instructionout <= 32'b00000000000000000000000000000000;
	
	end
	
	else
	begin
	addressout <= addressin;
	instructionout <= instructionin;
	end
	
end

endmodule

