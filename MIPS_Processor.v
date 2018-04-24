/*
	CODED BY CESAR VILLARREAL & GUILLERMO ROLDAN
	COMPUTER ARCHITECTURE
	SECOND PRACTICE: UNICYCLE PROCESSOR
*/

/*
	TO-DO:

	MODIFY CONTROL VARIABLES, AND VERIFY BRANCH AND LOAD INSTRUCTIONS

*/
module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 512,
	parameter DATA_WIDTH = 32
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
wire [31:0] PCMUX_OFFSET_wire;

/* INSTRUCTION MEMORY WIRES*/
wire [31:0] Instruction_wire;

/* CONTROL UNIT WIRES */
wire RegDst_wire;
wire BranchNE_wire; //BRANCH IF NOT EQUAL WIRE(1-BIT)
wire BranchEQ_wire; //BRANCH IF EQUAL WIRE (1-BIT)
wire MemRead_wire;
wire MemtoReg_wire;
wire MemWrite_wire;
wire ALUSrc_wire;
wire RegWrite_wire;
wire Jump_wire;
wire BranchTest_1_wire;
wire BranchTest_2_wire;
wire [2:0] ALUOp_wire;

/*ARITHMETIC LOGIC UNIT WIRES */
wire [2:0] ALUOperation_wire;
wire [31:0] ALUResult_wire;
wire [31:0] slltoalu_wire;
wire Zero_wire;

/* REGISTER FILE WIRES */
wire [4:0] WriteRegister_wire;
wire [31:0] ReadData1_wire;
wire [31:0] ReadData2_wire;

/* SIGN-EXTEND WIRES */
wire [31:0] InmmediateExtend_wire;
wire [31:0] ReadData2OrInmmediate_wire;
wire [31:0] InmmediateExtendAnded_wire;
wire [31:0] offsetAdder_wire;

/*DATA MEMORY*/
wire [31:0] RDM_wire;
wire [31:0] Writeback_wire;
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
	.MemRead(MemRead_wire),
	.MemtoReg(MemtoReg_wire),
	.MemWrite(MemWrite_wire),
	.ALUSrc(ALUSrc_wire),
	.RegWrite(RegWrite_wire),
	.Jump(Jump_wire),
	.ALUOp(ALUOp_wire)
);

/*~~~~~~~~~~~PROGRAM COUNTER~~~~~~~~~~*/
PC_Register
PROGRAM_COUNTER
(
	.clk(clk),
	.reset(reset),
	.NewPC(PCMUX_OFFSET_wire),

	.PCValue(PC_wire)
);

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


/*~~~~~~~~~~~32-BIT ADDERS~~~~~~~~~~*/
Adder32bits
PC_4_adder
(
	.Data0(PC_wire),
	.Data1(4),

	.Result(PC_4_wire)
);


Adder32bits
PC_offset_adder
(
	.Data0(PC_4_wire),
	.Data1(slltoalu_wire),

	.Result(offsetAdder_wire)
);
/////////////////////////////////////////////
///////////////////DECODE////////////////////
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
	.WriteData(Writeback_wire),
	.ReadData1(ReadData1_wire),
	.ReadData2(ReadData2_wire)
);

/*~~~~~~~~~~~REG SOURCE DATA SELECTOR (RT[0], RD[1])~~~~~~~~*/
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

/*~~~~~~~~~~~~~~~~~OFFSET DATA SELECTOR~~~~~~~~~~~~~~~~~~~~~*/
Multiplexer2to1
#(
	.NBits(32)
)
MUX_Offset
(
	.Selector(PcSrc_wire),
	.MUX_Data0(PC_4_wire),
	.MUX_Data1(offsetAdder_wire),

	.MUX_Output(PCMUX_OFFSET_wire)
);

/*~~~~~~~~~~~~~~~~~~~~~~~AND GATE~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
///PENDING...
ANDGate
BRANCHEQ_AND_ZERO
(
	.A(BranchEQ_wire),
	.B(Zero_wire),

	.C(BranchTest_1_wire)
);

ANDGate
BRANCHNE_AND_ZERO
(
	.A(BranchNE_wire),
	.B(~(Zero_wire)),

	.C(BranchTest_2_wire)
);

ORGate
BranchEqOrBranchNE
(
	.A(BranchTest_1_wire),
	.B(BranchTest_2_wire),

	.C(PcSrc_wire)
);

/*~~~~~~~~~~~~~~~~~~SIGN-EXTEND UNIT~~~~~~~~~~~~~~~~~~~~~~~*/
SignExtend
SignExtender
(
	.DataInput(Instruction_wire[15:0]),
   .SignExtendOutput(InmmediateExtend_wire)
);


/*~~~~~~INMMEDIATE EXTEND/READDATA2 DATA SELECTOR~~~~~~~~~~*/
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


/*~~~~~~~~~SHIFT LEFT MODULE~~~~~~~~~~*/
ShiftLeft2
ShiftLeft
(
	.DataInput(InmmediateExtend_wire), //32-bit input:sign extender-output
	.DataOutput(slltoalu_wire) //32-bit output
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

////////////WRITE BACK////////////////
/*~~~~~~~~~~DATA MEMORY~~~~~~~~~~*/
DataMemory
DataMemory
(
	.clk(clk),
	.Address(ALUResult_wire),
	.WriteData(ReadData2_wire),
	.MemWrite(MemWrite_wire),
	.MemRead(MemRead_wire),
	.ReadData(RDM_wire)
);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_MemtoReg
(
	.Selector(MemtoReg_wire),
	.MUX_Data0(ALUResult_wire),
	.MUX_Data1(RDM_wire),

	.MUX_Output(Writeback_wire)
);


assign ALUResultOut = ALUResult_wire;

endmodule
