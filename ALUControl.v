/*
	TITLE: ARITHMETIC LOGIC UNIT CONTROL
	CODED BY CÉSAR VILLARREAL & GUILLERMO ROLDÁN

	Description:

	this module contains the values needed for the control of the arithmetic logic unit;

*/

module ALUControl
(
	input [3:0] ALUOp,
	input [5:0] ALUFunction,

	output [3:0] ALUOperation
);

//add, addi,sub, or, ori, and, andi, lui, nor, sll, srl, lw, sw, beq, bne, j, jal, jr
localparam R_Type_AND    = 9'b0111_100100;  //funct = 6'h24
localparam R_Type_SUB    = 9'b0111_100010;	 //funct = 6'h22
localparam R_Type_OR     = 9'b0111_100101;  //funct = 6'h25
localparam R_Type_NOR    = 9'b0111_100111;  //funct = 6'h27
localparam R_Type_ADD    = 9'b0111_100000;  //funct = 6'h20
localparam R_Type_SLL	   = 9'b0111_000000;  //funct = 6'h00
localparam R_Type_SRL    = 9'b0111_000010;	 //funct = 6'h02
localparam R_Type_JR	   = 9'b0111_001000;	 //funct = 6'h08
localparam I_Type_ADDI   = 9'b0011_xxxxxx;	 //R[rt] = R[rs] + SignExtImm
localparam I_Type_ORI    = 9'b0001_xxxxxx;	 //R[rt] = R[rs] | ZeroExtImm
localparam I_Type_ANDI   = 9'b0000_xxxxxx;	 //R[rt] = R[rs] & ZeroExtImm
localparam I_Type_LUI    = 9'b0101_xxxxxx;	 //R[rt] = {imm, 16’b0}
localparam I_Type_LW     = 9'b0011_xxxxxx;	 //R[rt] = M[R[rs]+SignExtImm]
localparam I_Type_SW     = 9'b0011_xxxxxx;	 //M[R[rs]+SignExtImm] = R[rt]
localparam I_Type_BEQ	   = 9'b0100_xxxxxx;  //if(R[rs]==R[rt]): PC=PC+4+BranchAddr
localparam I_Type_BNE    = 9'b0100_xxxxxx;  //if(R[rs]!=R[rt]): PC=PC+4+BranchAddr
localparam J_Type_JAL    = 9'b0101_xxxxxx;  //R[31]=PC+8;PC=JumpAddr
localparam J_Type_J      = 9'b0101_xxxxxx;

reg [3:0] ALUControlValues;
wire [9:0] Selector;

assign Selector = {ALUOp, ALUFunction};

/*
AND = 4'b0000;
OR  = 4'b0001;
NOR = 4'b0010;
ADD = 4'b0011;
SUB = 4'b0100;
LUI = 4'b0101;
JAL = 4'b0110;
SRL = 4'b0111;
SLL = 4'b1000;
*/

always@(Selector)begin
	casex(Selector)
		R_Type_AND:    ALUControlValues = 4'b0000;
		R_Type_SUB:    ALUControlValues = 4'b0100;
		R_Type_OR:     ALUControlValues = 4'b0001;
		R_Type_NOR:    ALUControlValues = 4'b0010;
		R_Type_ADD:    ALUControlValues = 4'b0011; //add
	  R_Type_SLL:		 ALUControlValues = 4'b1000;
    R_Type_SRL:    ALUControlValues = 4'b0111;
		R_Type_JR:     ALUControlValues = 4'b1001;
		I_Type_SW:     ALUControlValues = 4'b0011;
		I_Type_ANDI:   ALUControlValues = 4'b0000; //and
		I_Type_LW:  	 ALUControlValues = 4'b0011;
		I_Type_LUI:    ALUControlValues = 4'b0101;
		I_Type_ADDI:  ALUControlValues  = 4'b0011; //add
		I_Type_BNE:   ALUControlValues  = 4'b0100; //sub
		I_Type_ORI:   ALUControlValues  = 4'b0001;
		I_Type_BEQ:   ALUControlValues  = 4'b0100; //sub
		J_Type_J:     ALUControlValues  = 4'b0101; //jal
		J_Type_JAL:   ALUControlValues  = 4'b0101; //jal
		default: ALUControlValues = 4'b111;
	endcase
end

assign ALUOperation = ALUControlValues;

endmodule
