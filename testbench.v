`timescale 1ps / 1ps
module test_main ();
reg clk;
reg reset;
main tb(
clk,
reset
);
initial 
begin
	#200
	reset <= 1'b1;
	#100
	reset <= 1'b0;
	#100
	reset <= 1'b0;
	#100
	reset <= 1'b0;
	#100
	reset <= 1'b0;
	#100
	reset <= 1'b0;
	#100
	reset <= 1'b0;
	#100
	reset <= 1'b0;
	#100
	reset <= 1'b0;
	#100
	reset <= 1'b0;
	#100
	reset <= 1'b0;
end
initial 
begin
	clk =0;
	forever // non-syntasysable
	begin
	#50	clk = !clk;
	end
end

endmodule