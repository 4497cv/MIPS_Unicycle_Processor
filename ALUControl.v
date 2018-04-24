/******************************************************************
* Description
*	This is the control unit for the ALU. It receves an signal called
*	ALUOp from the control unit and a signal called ALUFunction from
*	the intrctuion field named function.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module ALUControl
(
	input [2:0] ALUOp,
	input [5:0] ALUFunction,

	output [2:0] ALUOperation
);

//add, addi,sub, or, ori, and, andi, lui, nor, sll, srl, lw, sw, beq, bne, j, jal, jr
localparam R_Type_AND    = 9'b111_100100;  //funct = 6'h24
localparam R_Type_SUB    = 9'b111_100010;	 //funct = 6'h22
localparam R_Type_OR     = 9'b111_100101;  //funct = 6'h25
localparam R_Type_NOR    = 9'b111_100111;  //funct = 6'h27
localparam R_Type_ADD    = 9'b111_100000;  //funct = 6'h20
localparam R_Type_SLL	   = 9'b111_000000;  //funct = 6'h00
localparam R_Type_SRL    = 9'b111_000010;	 //funct = 6'h02
localparam R_Type_JR	   = 9'b111_001000;	 //funct = 6'h08
localparam I_Type_ADDI   = 9'b011_xxxxxx;	 //R[rt] = R[rs] + SignExtImm
localparam I_Type_ORI    = 9'b001_xxxxxx;	 //R[rt] = R[rs] | ZeroExtImm
localparam I_Type_ANDI   = 9'b000_xxxxxx;	 //R[rt] = R[rs] & ZeroExtImm
localparam I_Type_LUI    = 9'b101_xxxxxx;	 //R[rt] = {imm, 16’b0}
localparam I_Type_LW     = 9'b000_xxxxxx;	 //R[rt] = M[R[rs]+SignExtImm]
localparam I_Type_SW     = 9'b000_xxxxxx;	 //M[R[rs]+SignExtImm] = R[rt]
localparam I_Type_BEQ	   = 9'b100_xxxxxx;  //if(R[rs]==R[rt]): PC=PC+4+BranchAddr
localparam I_Type_BNE    = 9'b100_xxxxxx;  //if(R[rs]!=R[rt]): PC=PC+4+BranchAddr
localparam J_Type_JAL    = 9'b110_xxxxxx;  //R[31]=PC+8;PC=JumpAddr

reg [2:0] ALUControlValues;
wire [9:0] Selector;

assign Selector = {ALUOp, ALUFunction};

/*
localparam AND = 3'b000;
localparam OR  = 3'b001;
localparam NOR = 3'b010;
localparam ADD = 3'b011;
localparam SUB = 3'b100;
localparam LUI = 3'b101;
localparam JAL = 3'b110;
*/

always@(Selector)begin
	casex(Selector)
		R_Type_AND:    ALUControlValues = 3'b000;
		R_Type_SUB:    ALUControlValues = 3'b100;
		R_Type_OR:     ALUControlValues = 3'b001;
		R_Type_NOR:    ALUControlValues = 3'b010;
		R_Type_ADD:    ALUControlValues = 3'b011; //add
	//	R_Type_SLL:		 ALUControlValues = 4'b;
	//	R_Type_SRL:    ALUControlValues = 4'b;
		I_Type_ANDI:   ALUControlValues = 3'b000; //and
		I_Type_LW:  	 ALUControlValues = 3'b011;
		I_Type_SW:     ALUControlValues = 3'b011;
		I_Type_LUI:    ALUControlValues = 3'b101;
		I_Type_ADDI:  ALUControlValues  = 3'b011; //add
		I_Type_ORI:   ALUControlValues  = 3'b001;
		I_Type_BEQ:   ALUControlValues  = 3'b100; //sub
		I_Type_BNE:   ALUControlValues  = 3'b100; //sub
		J_Type_JAL:   ALUControlValues  = 3'b110; //jal
		default: ALUControlValues = 3'b111;
	endcase
end

assign ALUOperation = ALUControlValues;

endmodule
