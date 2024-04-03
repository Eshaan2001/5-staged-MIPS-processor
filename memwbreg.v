module memwb(
input [31:0] readin,
input [31:0]addressin,
input [4:0]wbin,
input [31:0] instructionin,
output reg [31:0] readout,
output reg [31:0]addressout,
output reg [4:0]wbout,
output reg [31:0] instructionout,
input reset,
input clk
);

always @(posedge clk or posedge reset)
begin
	if(reset)
	begin
	addressout <= 32'b00000000000000000000000000000000;
	readout <= 32'b00000000000000000000000000000000;
	wbout <= 5'b00000;
	instructionout <= 32'b00000000000000000000000000000000;
	end
	
	else
	begin
	addressout <= addressin;
	readout <= readin;
	wbout <= wbin;
	instructionout <= instructionin;
	end
	
end

endmodule



