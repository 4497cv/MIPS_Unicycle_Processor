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
	output [3:0] ALUOp		 //ARITHMETIC LOGIC UNIT OPERATION (3-bit)
);

reg [15:0] ControlValues; //CONTROL VALUES OUTPUT

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
		R_Type:       ControlValues = 16'b01_0_0_0_00_0_00_1_0_0111; //RegDest:Rd(01), ALUSRC:RDATA2(00), RegWrite; FunctField(111) *
		I_Type_ADDI:  ControlValues = 16'b00_0_0_0_00_0_01_1_0_0011; //RegDest:Rt(00), ALUSRC:immediate(01); ADD(011)
		I_Type_ORI:   ControlValues = 16'b00_0_0_0_00_0_10_1_0_0001; //RegDest:Rt(00), ALUSRC:Zeroext(10),RegWrite,ZeroImm; OR(001) *
		I_Type_ANDI:  ControlValues = 16'b00_0_0_0_00_0_10_1_0_0000; //RegDest:Rt(00), RegWrite, ZeroImm; AND(000) *
		I_Type_LUI:   ControlValues = 16'b00_0_0_0_11_0_00_1_0_0101; //RegDest:Rt(00), MemtoReg:IMMLUI(11), RegWrite; *
		I_Type_LW:	  ControlValues = 16'b00_0_0_1_01_0_01_1_0_0011; //ALUSrc:SignExt(01), MemtoReg:MemtoReg(01), RegWrite, MemRead;ADD(011) *
		I_Type_SW:	  ControlValues = 16'bxx_0_0_0_xx_1_01_0_0_0011; //AlUSrc:SignExt(01), MemWrite;ADD(011) *
		I_Type_BEQ:	  ControlValues = 16'bxx_1_0_0_xx_0_00_0_0_0100; //BranchEQ; SUB(100) *
		I_Type_BNE:	  ControlValues = 16'bxx_0_1_0_xx_0_00_0_0_0100; //BranchNE; SUB(100) *
		J_Type_J: 	  ControlValues = 16'bxx_0_0_0_00_0_00_0_1_0101; //JumpADDR, Jump; NO-ALU *
		J_Type_JAL:	  ControlValues = 16'b10_0_0_0_10_0_00_1_1_0101; //RegDest:ra(10),reg write, memtoreg:pc_4(10), Jump; JAL(110) *
		default:			ControlValues = 16'b00_0_0_0_00_0_00_0_0_0000;
	endcase
end

assign RegDst      = ControlValues[15:14];
assign BranchEQ    = ControlValues[13];
assign BranchNE    = ControlValues[12];
assign MemRead     = ControlValues[11];
assign MemtoReg    = ControlValues[10:9];
assign MemWrite    = ControlValues[8];
assign ALUSrc      = ControlValues[7:6];
assign RegWrite    = ControlValues[5];
assign Jump        = ControlValues[4];
assign ALUOp       = ControlValues[3:0];

endmodule
