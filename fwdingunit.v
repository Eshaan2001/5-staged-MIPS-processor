module fwding (
input fwdact,
input [4:0] regin1,
input [4:0] regin2,
input [4:0] writereg,
input [31:0] result,
output reg [31:0] fwded,
output reg tofwd1, // act as a flag if to forward or not
output reg tofwd2, // act as a flag if to forward or not
input clk,
input reset
);
always @(posedge clk)
begin
	if(reset)
	fwded<= 32'd0;
	if(fwdact)
	begin
		if(regin1 == writereg)
		begin
		tofwd1 = 1'b1;
		fwded <= result;
		end
		else 
		tofwd1 = 1'b0;
		if(regin2 == writereg)
		begin
		tofwd2 = 1'b1;
		fwded <= result;
		end
		else 
		tofwd2 = 1'b0;
	end
end
endmodule
