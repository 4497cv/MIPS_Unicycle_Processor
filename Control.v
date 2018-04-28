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

		MemtoReg:
		00: ALUResult_wire
		01: MemtoReg
		10: Jump Address
		11: Immediate LUI op

		ALUSRC:
		00: ReadData2
		01: Immeddiate
		10: Zero Ext.

*/

module Control
(
	input [5:0]OP, 				 //OPERATION (6-bit)

	output [1:0] RegDst,   //REGISTER DESTINATION (2-bit)
	output BranchEQ,       //BRANCH IF EQUAL (1-bit)
	output BranchNE,       //BRANCH IF NOT EQUAL (1-bit)
	output MemRead,        //MEMORY READ (1-bit)
	output [1:0] MemtoReg, //MEMORY TO REGISTER (2-bit)
	output MemWrite,       //WRITE TO MEMORY (1-bit)
	output [1:0] ALUSrc,   //ALU INPUT SOURCE B SELECTOR (2-bit)
	output RegWrite,		   //REGISTER WRITE (1-bit)
	output Jump,				   //JUMP (1-bit)
	output [2:0] ALUOp		 //ARITHMETIC LOGIC UNIT OPERATION (3-bit)
);

reg [14:0] ControlValues; //CONTROL VALUES OUTPUT

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
localparam J_Type_J    = 6'h02;
localparam J_Type_JAL  = 6'h03;

always@(OP) begin
	casex(OP)
		R_Type:       ControlValues = 15'b01_0_0_0_00_0_00_1_0_111; //RegDest:Rd(01), ALUSRC:RDATA2(00), RegWrite; FunctField(111) *
		I_Type_ADDI:  ControlValues = 15'b00_0_0_0_00_0_01_1_0_011; //RegDest:Rt(00), ALUSRC:immediate(01); ADD(011)
		I_Type_ORI:   ControlValues = 15'b00_0_0_0_00_0_10_1_0_001; //RegDest:Rt(00), ALUSRC:Zeroext(10),RegWrite,ZeroImm; OR(001) *
		I_Type_ANDI:  ControlValues = 15'b00_0_0_0_00_0_10_1_0_000; //RegDest:Rt(00), RegWrite, ZeroImm; AND(000) *
		I_Type_LUI:   ControlValues = 15'b00_0_0_0_11_0_00_1_0_101; //RegDest:Rt(00), MemtoReg:IMMLUI(11), RegWrite; *
		I_Type_LW:	  ControlValues = 15'b00_0_0_1_01_0_01_1_0_011; //ALUSrc:SignExt(01), MemtoReg:MemtoReg(01), RegWrite, MemRead;ADD(011) *
		I_Type_SW:	  ControlValues = 15'bxx_0_0_0_xx_1_01_0_0_011; //AlUSrc:SignExt(01), MemWrite;ADD(011) *
		I_Type_BEQ:	  ControlValues = 15'bxx_1_0_0_xx_0_00_0_0_100; //BranchEQ; SUB(100) *
		I_Type_BNE:	  ControlValues = 15'bxx_0_1_0_xx_0_00_0_0_100; //BranchNE; SUB(100) *
		J_Type_J: 	  ControlValues = 15'bxx_0_0_0_00_0_00_0_1_101; //JumpADDR, Jump; NO-ALU *
		J_Type_JAL:	  ControlValues = 15'b10_0_0_0_00_0_00_0_1_101; //Jump; JAL(110) *
		default:			ControlValues = 15'bxx_x_x_x_xx_x_xx_x_x_xxx;
	endcase
end

assign RegDst      = ControlValues[14:13];
assign BranchEQ    = ControlValues[12];
assign BranchNE    = ControlValues[11];
assign MemRead     = ControlValues[10];
assign MemtoReg    = ControlValues[9:8];
assign MemWrite    = ControlValues[7];
assign ALUSrc      = ControlValues[6:5];
assign RegWrite    = ControlValues[4];
assign Jump        = ControlValues[3];
assign ALUOp       = ControlValues[2:0];

endmodule
