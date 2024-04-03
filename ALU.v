module alu (
input [31:0] instalu, // instruction
input [31:0] PC,
input [31:0] Read_Data_1,
input [31:0] Read_Data_2,
input tofwd1,
input tofwd2,
input reset,
input clk,
output reg [31:0] newPC,
output reg [31:0] result,
output reg zero,
output reg [31:0] Mem
);
reg jump;
reg datafrmreg;
reg [3:0]control;
wire [5:0]opcode;


assign opcode = instalu[31:26];

always @(opcode)
begin
	case(opcode)
	6'b101000:begin  control = 4'b0000;datafrmreg = 1'b0;jump = 1'b0; end
	6'b100011:begin  control = 4'b0000;datafrmreg = 1'b0;jump = 1'b0; end
	6'b110010:begin  control = 4'b0001;datafrmreg = 1'b1;jump = 1'b0; end
	6'b111011:begin  control = 4'b0010;datafrmreg = 1'b1;jump = 1'b0; end
	6'b000010:begin  jump = 1'b1; end
	default: control = 4'b1111;
	endcase
end





wire [31:0] jumpshiffted;
wire [31:0] secndres;
//assign secndres = datafrmreg ? Read_Data_2:jumpextended;
//assign jumpshiffted = jumpextended<<2;
always @(posedge clk)
begin
 Mem = Read_Data_2 + instalu[15:0]; // this is for loadword storeword

if(jump)
newPC <= PC+instalu[25:0];
else

newPC <= PC;	
//	jmpadd <= jumpshiffted + PC;
	
		case(control)
		//4'b0000: result = Read_Data_1 + secndres;//use this for LW and SW
		4'b0001: result = Read_Data_1<<Read_Data_2;// left shift
		4'b0010: result = Read_Data_1>>Read_Data_2;// Right Shift
		default: result = 32'd0;
		endcase
	if(result == 32'd0)
	zero = 1'b1;
	else
	zero = 1'b0;
	

end






endmodule