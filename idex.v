module idex (
input clk,   /// wrong 
input reset, // more inputs
input [31:0] addressin,  // sorrect 
input [31:0] regdata1in,
input [31:0] regdata2in,
input [31:0] signextendedin,
input [4:0] writeregin,
input [31:0] instructionin,

output reg [31:0] addressout,
output reg [31:0] regdata1out,
output reg [31:0] regdata2out,
output reg [31:0] signextendedout,
output reg [4:0] writeregout,
output reg [31:0] instructionout


);


always @(posedge clk or posedge reset)
begin
	if(reset)
	begin
	addressout <= 32'b00000000000000000000000000000000;
	regdata1out <= 32'b00000000000000000000000000000000;
	regdata2out <= 32'b00000000000000000000000000000000;
	signextendedout <= 32'b00000000000000000000000000000000;
	writeregout <= 5'b00000;
	instructionout <= 32'b00000000000000000000000000000000;
	end
	
	else
	begin
	addressout <= addressin;
	regdata1out <= regdata1in;
	regdata2out <= regdata2in;
	signextendedout <= signextendedin ;
	writeregout <= writeregin;
	instructionout <= instructionin;
	end
	
end
endmodule