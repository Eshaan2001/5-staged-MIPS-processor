module exmem (
input clk,
input reset,
input [31:0] instructionin,
input [31:0] addressin,
input [31:0] aluin,
input zeroin,
input [31:0] datain,
output reg [31:0] addressout,
output reg [31:0] instructionout,
output reg [31:0] aluout,
output reg zeroout,
output reg [31:0] dataout

);


always @(posedge clk or posedge reset)
begin
	if(reset)
	begin
	addressout <= 32'b00000000000000000000000000000000;
	instructionout <= 32'b00000000000000000000000000000000;
	aluout <= 32'b00000000000000000000000000000000;
	dataout <= 32'b00000000000000000000000000000000;
	zeroout <= 1'b0;
	end
	
	else
	begin
	addressout <= addressin;
	instructionout <= instructionin;
	aluout <= aluin;
	dataout <= datain;
	zeroout <= zeroin;
	end
	
end
endmodule