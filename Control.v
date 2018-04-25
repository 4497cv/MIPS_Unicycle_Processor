/*
	TITLE: CONTROL VALUES MODULE
	CODED BY CÉSAR VILLARREAL & GUILLERMO ROLDÁN

	Description:

	this module contains the values needed for the control of the whole processor
	according to the input 6-bit operation value of the instruction.
*/

/*
   ALU OPERATIONS:
		AND = 3'b000;
		OR  = 3'b001;
		NOR = 3'b010;
		ADD = 3'b011;
		SUB = 3'b100;
		LUI = 3'b101;
		JAL = 3'b110;

		RegDest:
		00: Rt
		01: Rd
		10: ra
*/

module Control
(
	input [5:0]OP,

	output [1:0] RegDst, //REGISTER DESTINATION
	output BranchEQ,     //BRANCH IF EQUAL
	output BranchNE,     //BRANCH IF NOT EQUAL
	output MemRead,      //MEMORY READ
	output [1:0] MemtoReg,		 //MEMORY TO REGISTER
	output MemWrite,     //WRITE TO MEMORY
	output ALUSrc,       //ALU INPUT SOURCE B SELECTOR
	output RegWrite,		 //REGISTER WRITE
	output Jump,				 //JUMP
	output JumpAndLink,	 //JUMP AND LINK
	output ZeroImm,			 //ZERO IMMEDIATE
	output LUI,					 //LOAD UPPER IMMEDIATE
	output [2:0]ALUOp		 //ARITHMETIC LOGIC UNIT OPERATION
);

reg [16:0] ControlValues; //CONTROL VALUES OUTPUT

/*OP CODES: Instruction[31:26]*/

localparam R_Type      = 6'h00;
localparam I_Type_ADDI = 6'h08;
localparam I_Type_ORI  = 6'h0d;
localparam I_Type_LUI  = 6'h0f;
localparam I_Type_ANDI = 6'h0c;
localparam I_Type_LW   = 6'h23;
localparam I_Type_SW   = 6'h2b;
localparam I_Type_BEQ  = 6'h04;
localparam I_Type_BNE  = 6'h05;
localparam I_Type_J    = 6'h02;
localparam I_Type_JAL  = 6'h03;

always@(OP) begin
	casex(OP)
		R_Type:       ControlValues= 17'b01_0_00_1_00_00000_0_111; //RegDest:Rd,RegWrite; FunctField(111)
		I_Type_ADDI:  ControlValues= 17'b00_1_00_1_00_00000_0_011; //RegDest:Rt,ALUSRC; ADD(011)
		I_Type_ORI:   ControlValues= 17'b00_0_00_1_00_00001_0_001; //RegDest:Rt,RegWrite,ZeroImm; OR(001)
		I_Type_ANDI:  ControlValues= 17'b00_0_00_1_00_00001_0_000; //RegDest:Rt,RegWrite, ZeroImm; AND(000)
		I_Type_LUI:   ControlValues= 17'b00_0_00_1_00_00000_1_101; //RegDest:Rt,RegWrite, ;LUI(101)
		I_Type_LW:	  ControlValues= 17'b00_1_01_1_10_00000_0_011; //ALUSrc,MemtoReg,RegWrite,MemRead;ADD(011)
		I_Type_SW:	  ControlValues= 17'b00_1_00_0_01_00000_0_011; //AlUSrc,MemWrite;ADD(011)
		I_Type_BEQ:	  ControlValues= 17'b00_0_00_0_00_01000_0_100; //BranchEQ;SUB(100)
		I_Type_BNE:	  ControlValues= 17'b00_0_00_0_00_10000_0_100; //BranchNE;SUB(100)
		I_Type_J: 	  ControlValues= 17'b00_0_00_0_00_00100_0_xxx; //JumpADDR, Jump; NO-ALU
		I_Type_JAL:	  ControlValues= 17'b10_0_10_0_00_00010_0_110; //Jump; JAL(110)
		default:			ControlValues= 17'b00_0_00_0_00_00000_0_000;
	endcase
end

assign RegDst      = ControlValues[16:15];
assign ALUSrc      = ControlValues[14];
assign MemtoReg    = ControlValues[13:12];
assign RegWrite    = ControlValues[11];
assign MemRead     = ControlValues[10];
assign MemWrite    = ControlValues[9];
assign BranchNE    = ControlValues[8];
assign BranchEQ    = ControlValues[7];
assign Jump        = ControlValues[6];
assign JumpAndLink = ControlValues[5];
assign ZeroImm     = ControlValues[4];
assign LUI         = ControlValues[3];
assign ALUOp       = ControlValues[2:0];

endmodule
