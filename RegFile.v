module Register_File(
input [31:0] instruction,
input [4:0]Read_Reg_Num1, 
input [4:0]Read_Reg_Num2, 
input [4:0]Write_Reg_Num, //done  // need to advance to later see in the main file
input [31:0]Write_Data, //Done    // need to advance to later see in the main file
input clk,
output reg RegWrite,
output reg [31:0]Read_Data_1,
output reg [31:0]Read_Data_2,
input [25:0] addressred,  // reduced addrress
output [31:0] jumpextended,
input reset
);
wire [5:0]opcode;
integer i;
reg [31:0]RegMemory[31:0];

assign opcode = instruction[31:26];
always @(opcode)
begin
if(opcode == 6'b101000 || opcode == 6'b110010 || opcode == 6'b111011)
RegWrite = 1'b1;
else
RegWrite = 1'b0;
end
assign jumpextended = {addressred[25],addressred[25],addressred[25],addressred[25],addressred[25],addressred[25],addressred[25:0]};

// reset zero to clear all the memory
always @(reset)
begin
	if(reset)
	begin
	for (i = 10;i<32;i = i+1)
	begin
	RegMemory[0] = 32'd0;
	RegMemory[1] = 32'd1;
	RegMemory[2] = 32'd2;
	RegMemory[3] = 32'd3;
	RegMemory[4] = 32'd4;
	RegMemory[5] = 32'd5;
	RegMemory[6] = 32'd6;
	RegMemory[7] = 32'd7;
	RegMemory[8] = 32'd8;
	RegMemory[9] = 32'd9;
	RegMemory[10] = 32'd10;
	RegMemory[11] = 32'd11;
	RegMemory[12] = 32'd12;
	RegMemory[13] = 32'd13;
	RegMemory[14] = 32'd14;
	RegMemory[i] = 32'd0;
	end
	end
end
// reading at the negedge  of clk
always @(negedge clk)
begin
	RegMemory[0] <= 32'd0; // making r0 as 0
	Read_Data_1 <= RegMemory[Read_Reg_Num1];
	Read_Data_2 <= RegMemory[Read_Reg_Num2];
end
// writing on the positive edge
always @(posedge clk)
begin

	if(RegWrite)
	begin
	RegMemory[Write_Reg_Num] = Write_Data;
	RegMemory[0] <= 32'd0;
	end
end
endmodule