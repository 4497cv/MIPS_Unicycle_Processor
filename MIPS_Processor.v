/*
	CODED BY CESAR VILLARREAL & GUILLERMO ROLDAN
	COMPUTER ARCHITECTURE
	SECOND PRACTICE: UNICYCLE PROCESSOR
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

/////////////////////////////////////
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
wire [1:0] RegDst_wire;   //Determines which register will be set in write register
wire BranchNE_wire;       //BRANCH IF NOT EQUAL WIRE(1-BIT)
wire BranchEQ_wire;       //BRANCH IF EQUAL WIRE (1-BIT)
wire MemRead_wire;        //Reads from memory
wire [1:0] MemtoReg_wire; //Determines what will be sent into the register's write data
wire MemWrite_wire;       //Determines if it will be a memory write action
wire Branch_wire;         //Branch-target data selector
wire [1:0] ALUSrc_wire;   //Determines ALU's input B
wire RegWrite_wire;       //Writes on Memory
wire Jump_wire; 				  //Jump to Address
wire [3:0] ALUOp_wire;    //ALU OPERATION

wire jr_wire;

/*Branch Operation*/
wire BranchTest_1_wire;
wire BranchTest_2_wire;

/*ARITHMETIC LOGIC UNIT WIRES */
wire [3:0] ALUOperation_wire;
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
wire [31:0] ImmLUIext_wire;
wire [31:0] JumpAddressPC_wire;
/*DATA MEMORY*/
wire [31:0] RDM_wire;
wire [31:0] Writeback_wire;
wire NotZeroANDBrachNE;
wire ZeroANDBrachEQ;
wire ORForBranch;
wire [31:0] MemtoLUI_wire;
wire [31:0] ZeroExtend_wire;
integer ALUStatus;
wire [27:0] JumpAddress_wire;
wire [31:0] JumpAddr_wire;
wire [31:0] LuitoJal_wire;
wire [31:0] PCJR_wire;

/////////////////////////////////////////////////
///////////////////////FETCH/////////////////////
/*~~~~~~~~~~~~~~~~CONTROL UNIT~~~~~~~~~~~~~~~~*/
Control
ControlUnit
(
	.OP(Instruction_wire[31:26]), // 6-bit

	.RegDst(RegDst_wire),         // 2-bit
	.BranchEQ(BranchEQ_wire),     // 1-bit
	.BranchNE(BranchNE_wire),     // 1-bit
	.MemRead(MemRead_wire),       // 1-bit
	.MemtoReg(MemtoReg_wire),     // 2-bit
	.MemWrite(MemWrite_wire),     // 1-bit
	.ALUSrc(ALUSrc_wire),         // 2-bit
	.RegWrite(RegWrite_wire),     // 1-bit
	.Jump(Jump_wire),	            // 1-bit
	.ALUOp(ALUOp_wire)            // 3-bit
);

/*~~~~~~~~~~~~~~~PROGRAM COUNTER~~~~~~~~~~~~~~*/
PC_Register
PROGRAM_COUNTER
(
	.clk(clk),
	.reset(reset),
	.NewPC(PCJR_wire),

	.PCValue(PC_wire)
);

/*~~~~~~~~~~~~~~~~~PC/JAL MUX~~~~~~~~~~~~~~~~~*/
Multiplexer2to1
#(
	.NBits(32)
)
MUX_PCSELJR
(
	.Selector(jr_wire),
	.MUX_Data0(JumpAddressPC_wire),
	.MUX_Data1(ReadData1_wire),

	.MUX_Output(PCJR_wire)
);

/*~~~~~~~~~~~INSTRUCTION MEMORY~~~~~~~~~~~~~~~*/
ProgramMemory
Instruction_Memory
(
	.Address(PC_wire),

	.Instruction(Instruction_wire)
);

/*~~~~~~~~~~~~~32-BIT ADDERS~~~~~~~~~~~~~~~~~*/
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
/*~~~~~~~~~~~~~~~~JUMP~~~~~~~~~~~~~~~~~~*/
ShiftLeft2
ShiftLeftADDR
(
	.DataInput(Instruction_wire[25:0]), //32-bit input:sign extender-output

	.DataOutput(JumpAddress_wire) //32-bit output
);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_JUMPADDRESS
(
	.Selector(Jump_wire),
	.MUX_Data0(PCMUX_OFFSET_wire),
	.MUX_Data1(JumpAddr_wire), //JUMPADDR
	.MUX_Output(JumpAddressPC_wire)
);

/*~~~~~~~~~~JUMP AND LINK~~~~~~~~~~ */
JumpAddrOP
JALMODULE
(
	.PC_4(PC_4_wire[31:28]),
	.address(Instruction_wire[25:0]),
	.JumpAddr(JumpAddr_wire)
);

//////////////////////////////////////////////////////////////////
///////////////////////////////DECODE/////////////////////////////
/*~~~~~~~~~~~~~~~~~~~~~~~~~REGISTER FILE~~~~~~~~~~~~~~~~~~~~~~~*/
RegisterFile
Register_File
(
	.clk(clk),													//INPUT CLOCK
	.reset(reset),											//RESET
	.RegWrite(RegWrite_wire),						//REGISTER WRITE CONTROL
	.WriteRegister(WriteRegister_wire), //R[T]:[20:16] | R[D]:[15:11] | R[31]: R[5'b11111]
	.ReadRegister1(Instruction_wire[25:21]), //CONTENTS OF REGISTER R[S]
	.ReadRegister2(Instruction_wire[20:16]), //CONTENTS OF REGISTER R[T]
	.WriteData(Writeback_wire), //DATA WRITTEN
	.ReadData1(ReadData1_wire), //R[S]
	.ReadData2(ReadData2_wire)  //R[T]
);

/*~~~~~~~~~~~REG SOURCE DATA SELECTOR (RT[0], RD[1], ra)~~~~~~~~*/
Multiplexer3to1
#(
	.NBits(5)
)
MUX_RegisterDestinationSelect
(
	.Selector(RegDst_wire),
	.MUX_Data0(Instruction_wire[20:16]),
	.MUX_Data1(Instruction_wire[15:11]),
	.MUX_Data2(5'b11111), //(31)

	.MUX_Output(WriteRegister_wire)
);

/*~~~~~~~~~~~~~~~~~~~OFFSET DATA SELECTOR~~~~~~~~~~~~~~~~~~~~~*/
Multiplexer2to1
#(
	.NBits(32)
)
MUX_Offset
(
	.Selector(Branch_wire),
	.MUX_Data0(PC_4_wire),
	.MUX_Data1(offsetAdder_wire),

	.MUX_Output(PCMUX_OFFSET_wire)
);

/*~~~~~~~~~~~~~~~~~~~~~~~~AND GATE~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
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

	.C(Branch_wire)
);

/*~~~~~~~~~~~~~~~~~~~SIGN-EXTEND UNIT~~~~~~~~~~~~~~~~~~~~~~*/
SignExtend
SignExtender
(
	.DataInput(Instruction_wire[15:0]),

  .SignExtendOutput(InmmediateExtend_wire)
);

/*~~~~~~INMMEDIATE EXTEND/READDATA2 DATA SELECTOR~~~~~~~~~~*/
Multiplexer3to1
#(
	.NBits(32)
)
MUX_ALUSRC
(
	.Selector(ALUSrc_wire),
	.MUX_Data0(ReadData2_wire),
	.MUX_Data1(InmmediateExtend_wire),
	.MUX_Data2(ZeroExtend_wire),

	.MUX_Output(ReadData2OrInmmediate_wire)
);
/*~~~~~~~~~~~~~~~~~~~~~~ZERO INMMEDIATE~~~~~~~~~~~~~~~~~~~~*/
ZeroImm
ZeroImmExtender
(
	.immediate(Instruction_wire[15:0]),

	.ZeroExtImm(ZeroExtend_wire)
);

/*~~~~~~~~~~~~~~~~~~~~LUI OPERATOR~~~~~~~~~~~~~~~~~~~~~~*/
LUIOp
LUIOPERATION
(
	.immediate(Instruction_wire[15:0]),
	.ImmLUI(ImmLUIext_wire)
);

/*~~~~~~~~~~~~~~~~~~~~SHIFT LEFT MODULE~~~~~~~~~~~~~~~~~~~*/
ShiftLeft2
ShiftLeft_PC
(
	.DataInput(InmmediateExtend_wire), //32-bit input:sign extender-output

	.DataOutput(slltoalu_wire)         //32-bit output:
);

/*~~~~~~~~~~~~~~~~~~~~~~~~ A L U ~~~~~~~~~~~~~~~~~~~~~~~*/
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
	.sh(Instruction_wire[10:6]),
	.Zero(Zero_wire),
	.JR(jr_wire),
	.ALUResult(ALUResult_wire)
);

/////////////////////////////////////////////////////////
/////////////////////// WRITE BACK //////////////////////
/*~~~~~~~~~~~~~~~~~~~~~DATA MEMORY~~~~~~~~~~~~~~~~~~~~~*/
DataMemory
RAMDataMemory
(
	.clk(clk),
	.Address(ALUResult_wire),
	.WriteData(ReadData2_wire),
	.MemWrite(MemWrite_wire),
	.MemRead(MemRead_wire),
	.ReadData(RDM_wire)
);

/*~~~~~~~~~~~~~~~~~ MEMORY TO REGISTER ~~~~~~~~~~~~~~~~*/
Multiplexer4to1
#(
	.NBits(32)
)
MUX_MemtoReg
(
	.Selector(MemtoReg_wire),
	.MUX_Data0(ALUResult_wire), //Result
	.MUX_Data1(RDM_wire),       //DataMemory Read
	.MUX_Data2(PC_4_wire),  //Jump Address
	.MUX_Data3(ImmLUIext_wire), //Immediate LUI op

	.MUX_Output(Writeback_wire) //Write back to Reg
);

assign ALUResultOut = ALUResult_wire;

endmodule
