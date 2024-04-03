module main(
input clk,
input reset
);
// wire start

// wire end

// edit list ALU,
wire [31:0]PC;
wire [31:0]jmpammt;
wire jump;
wire [31:0]Instruction_Code;

Instruction_Memory mod1(
PCif,
clk,
reset,
jmpammt,
jump,
Instruction_Code
);	

//wire [31:0] PCif;
wire [31:0] PCid;
wire [31:0] Instruction_Code_id;

ifid reg1(
clk,
reset,
PCif,
Instruction_Code,
PCid,
Instruction_Code_id
);

wire [31:0]Write_Data;
wire RegWrite; // modify it after ALU operation has been done
wire [31:0]Read_Data_1;
wire [31:0]Read_Data_2;
wire [31:0] jumpextended;
wire [4:0]Writeback;
Register_File mod2(
Instruction_Code_id,
Instruction_Code_id[25:21], // RS 
Instruction_Code_id[20:16], // Rt
Writeback, //RD  // need to advance to later see in the main file
Write_Data, //Done    // need to advance to later see in the main file
clk,
RegWrite,
Read_Data_1,
Read_Data_2,
Instruction_Code_id[25:0],  // reduced addrress
jumpextended,
reset
);


wire [31:0]Instruction_Code_ex;
wire [31:0]PCex;
wire [31:0] Read_Data_ALU1;
wire [31:0] Read_Data_ALU2;
wire [31:0] signextendedout;
wire [4:0] writeregout;

idex reg2(
clk,   /// wrong 
reset, // more inputs
PCid,  // sorrect 
Read_Data_1,
Read_Data_2,
jumpextended,
Instruction_Code_id[15:11],
Instruction_Code_id,

PCex,
Read_Data_ALU1,
Read_Data_ALU2,
signextendedout,
writeregout,
Instruction_Code_ex


);




wire fwdact;
wire [31:0]fwded;
assign fwdact = Instruction_Code_ex[31]&Instruction_Code_ex[30];
wire tofwd1;
wire tofwd2;



wire [31:0]Read_Data_A1;
wire [31:0]Read_Data_A2;


assign Read_Data_A1 = tofwd1? fwded:Read_Data_ALU1;
assign Read_Data_A2 = tofwd2? fwded:Read_Data_ALU2;



wire [31:0] jmpadd;
wire [31:0] result;
wire zero;
wire [31:0] Mem;
alu mod3(
Instruction_Code_ex,
signextendedout,
PCex,
Read_Data_A1,
Read_Data_A2,
reset,
clk,
jmpadd,
result,
zero,
Mem
);


fwding forwardingunit(
fwdact,
Instruction_Code_ex[25:21],
Instruction_Code_ex[20:16],
Instruction_Code_id[15:11],
result,
fwded,
tofwd1, // act as a flag if to forward or not
tofwd2, // act as a flag if to forward or not
clk,
reset
);
wire [31:0] PCmem;
wire [31:0] Instruction_Code_mem;
wire [31:0] aluout;
wire zeroout;
wire [31:0]dataout;
wire [31:0]datain;
exmem reg3(
clk,
reset,
Instruction_Code_ex,
PCex,
result,
zero,
datain, // write back stage the yellow line
PCmem,
Instruction_Code_mem,
aluout,
zeroout,
dataout
);
wire [31:0]Read_Data;
datamemory mod4(
Instruction_Code_mem,
PCmem,
Read_Data_ALU1,
Read_Data,
clk,
reset
);
wire [31:0] Instruction_Code_wb; 
memwb reg4(
Read_Data,
PCmem,
Instruction_Code_mem[15:11],
Instruction_Code_mem,
datain,
PC,
Writeback,
Instruction_Code_wb,
reset,
clk
);
endmodule