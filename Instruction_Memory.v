module Instruction_Memory (
	output reg [31:0]PC,
	input clk,
	input reset,
	input [31:0]jmpammt,
	input jump,
	output reg [31:0]Instruction_Code
	);	
reg [7:0]Mem[36:0];  
always @(reset) 
begin
	if(reset == 1)  // if reset is not zero the data is not specified and depends on what is receved from the 
	begin           // from the decoder
		Mem[0] =  8'b10100000 ;Mem[1] = 8'b00101011;Mem[2] =  8'b00000000;Mem[3] =  8'b00001100;
		Mem[4] =  8'b11101100 ;Mem[5] = 8'b01101000;Mem[6] =  8'b00010000;Mem[7] =  8'b00000000;
		Mem[8] =  8'b11001000 ;Mem[9] = 8'b01000001;Mem[10] = 8'b00011000;Mem[11] = 8'b00000000; 
		Mem[12] = 8'b00001000;Mem[13] = 8'b00000000;Mem[14] = 8'b00000000;Mem[15] = 8'b00010100;
		Mem[16] = 8'b11101100;Mem[17] = 8'b11000110;Mem[18] = 8'b00110000;Mem[19] = 8'b00000000;
		Mem[20] = 8'b11101100;Mem[21] = 8'b10000100;Mem[22] = 8'b00100000;Mem[23] = 8'b00000000;
	end
end
always @(posedge clk)
begin
	if(reset)
	PC<=0;
	else
	begin
		if(jump)
		PC<=PC+4+jmpammt;
		else
		PC<=PC+4;
		Instruction_Code = { Mem[PC], Mem[PC+1], Mem[PC+2], Mem[PC+3] };
	
	
	end
end
endmodule







