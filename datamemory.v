module datamemory(
input [31:0] instruction,
input [31:0] address,
input [31:0] Write_Data,
output reg [31:0] Read_Data,
input clk,
input reset
);
reg Read;
reg Write;
reg [7:0]RegMemory[500:0]; // we cannot directly simulate the 2^32 location as it causes an overflow in the simulation software
wire [5:0]opcode;
assign opcode = instruction[31:26];

always @(opcode)
begin
	if(opcode == 6'b101000)
	begin
	Read = 1'b1;
	Write = 1'b0;
	end
	
	else if(opcode == 6'b100011) 
	begin
	Read = 1'b0;
	Write = 1'b1;
	end
	
	else
	begin
	Read = 1'b0;
	Write = 1'b0;
	end
	


end




always @(posedge clk)
begin
	if(reset)
	begin
	Read_Data <= 32'd0;
	
	end
	
	else
		begin
			if(Read)
			begin
			Read_Data <=  {RegMemory[address],RegMemory[address-1],RegMemory[address-2],RegMemory[address-3]}; 
			end

			if(Write)
			begin
			RegMemory[address] <= Write_Data[31:24];
			RegMemory[address-1] <= Write_Data[23:16];
			RegMemory[address-2] <= Write_Data[15:8];
			RegMemory[address-3] <= Write_Data[7:0];
			end
		end
end

endmodule