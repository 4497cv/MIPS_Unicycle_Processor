/*
	CODED BY CESAR VILLARREAL & GUILLERMO ROLDAN
	COMPUTER ARCHITECTURE
	SECOND PRACTICE: UNICYCLE PROCESSOR
*/

module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 32
)

(
	// Inputs
	input clk,
	input reset,
	input [7:0] PortIn,
	// Output
	output [31:0] ALUResultOut,
	output [31:0] PortOut
);

assign  PortOut = 0;

//////////WIRE-DECLARATION///////////
/* PROGRAM COUNTER WIRES */
wire [31:0] MUX_PC_wire;
wire [31:0] PC_wire;
wire [31:0] PC_4_wire;
wire [31:0] PCtoBranch_wire;

/* INSTRUCTION MEMORY WIRES*/
wire [31:0] Instruction_wire;

/* CONTROL UNIT WIRES */
wire RegDst_wire;	
wire BranchNE_wire; //BRANCH IF NOT EQUAL WIRE(1-BIT)
wire BranchEQ_wire; //BRANCH IF EQUAL WIRE (1-BIT)
wire MemRead_wire;
wire MemtoReg_wire;
wire [2:0] ALUOp_wire;
wire MemWrite_wire;
wire ALUSrc_wire
wire RegWrite_wire;

/*ARITHMETIC LOGIC UNIT WIRES */
wire [3:0] ALUOperation_wire;
wire [31:0] ALUResult_wire;
wire Zero_wire;

/* REGISTER FILE WIRES */
wire [4:0] WriteRegister_wire;
wire [31:0] ReadData1_wire;
wire [31:0] ReadData2_wire;

/* SIGN-EXTEND WIRES */
wire [31:0] InmmediateExtend_wire;
wire [31:0] ReadData2OrInmmediate_wire;
wire [31:0] InmmediateExtendAnded_wire;

wire NotZeroANDBrachNE;
wire ZeroANDBrachEQ;
wire ORForBranch;

integer ALUStatus;
//////////////////////////////////////
////////////////FETCH/////////////////

/*~~~~~~~~~~~CONTROL UNIT~~~~~~~~~~*/
Control
ControlUnit
(
	.OP(Instruction_wire[31:26]),
	.RegDst(RegDst_wire),
	.BranchNE(BranchNE_wire),
	.BranchEQ(BranchEQ_wire),
	.ALUOp(ALUOp_wire),
	.ALUSrc(ALUSrc_wire),
	.RegWrite(RegWrite_wire)
);

/*~~~~~~~~~~~PROGRAM COUNTER~~~~~~~~~~*/
PC_REGISTER
PROGRAM_COUNTER
(
	.clk(clk),
	.reset(reset),
	.NewPC(PC_4_wire),
	.PCValue(PC_wire)
)

/*~~~~~~~~~~~INSTRUCTION MEMORY~~~~~~~~~~*/
ProgramMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
Instruction_Memory
(
	.Address(PC_wire),
	.Instruction(Instruction_wire)
);


/*~~~~~~~~~~~32-BIT ADDER~~~~~~~~~~*/
Adder32bits
PC_Puls_4
(
	.Data0(PC_wire),
	.Data1(4),
	
	.Result(PC_4_wire)
);

///////////////////DECODE////////////////////
/*~~~~~~~~~~~DATA SELECTORS (2 TO 1)~~~~~~~~~~*/
Multiplexer2to1
#(
	.NBits(5)
)
MUX_RegisterDestinationSelect
(
	.Selector(RegDst_wire),
	.MUX_Data0(Instruction_wire[20:16]),
	.MUX_Data1(Instruction_wire[15:11]),
	
	.MUX_Output(WriteRegister_wire)

);

/*~~~~~~~~~~~REGISTER FILE~~~~~~~~~~*/
RegisterFile
Register_File
(
	.clk(clk),
	.reset(reset),
	.RegWrite(RegWrite_wire),
	.WriteRegister(WriteRegister_wire),
	.ReadRegister1(Instruction_wire[25:21]),
	.ReadRegister2(Instruction_wire[20:16]),
	.WriteData(ALUResult_wire),
	.ReadData1(ReadData1_wire),
	.ReadData2(ReadData2_wire)

);

/*~~~~~~~~~~~SIGN-EXTEND UNIT~~~~~~~~~~*/
SignExtend
SignExtender
(   
	.DataInput(Instruction_wire[15:0]),
   .SignExtendOutput(InmmediateExtend_wire)
);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(ALUSrc_wire),
	.MUX_Data0(ReadData2_wire),
	.MUX_Data1(InmmediateExtend_wire),
	
	.MUX_Output(ReadData2OrInmmediate_wire)

);

/*~~~~~~~~~~~ALU~~~~~~~~~~*/
ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(ALUOp_wire),
	.ALUFunction(Instruction_wire[5:0]),
	.ALUOperation(ALUOperation_wire)

);

ALU
ArithmeticLogicUnit 
(
	.ALUOperation(ALUOperation_wire),
	.A(ReadData1_wire),
	.B(ReadData2OrInmmediate_wire),
	.Zero(Zero_wire),
	.ALUResult(ALUResult_wire)
);

DataMemory
#(	.MEMORY_DEPTH(MEMORY_DEPTH),
	.DATA_WIDTH(DATA_WIDTH)
)
DataMemory
(
	.Address(ALUResult_wire),
	.WriteData(),
	.MemWrite(),
	.MemRead(),
	.ReadData(),
	.clk(clk)
);

assign ALUResultOut = ALUResult_wire;

endmodule
