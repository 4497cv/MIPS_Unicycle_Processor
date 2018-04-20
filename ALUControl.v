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

	output [3:0] ALUOperation

);

//add, addi,sub, or, ori, and, andi, lui, nor, sll, srl, lw, sw, beq, bne, j, jal, jr
localparam R_Type_AND    = 9'b111_100100;  //funct = 6'h24
localparam R_Type_SUB    = 9'b111_100010;	 //funct = 6'h22
localparam R_Type_OR     = 9'b111_100101;  //funct = 6'h25
localparam R_Type_NOR    = 9'b111_100111;  //funct = 6'h27
localparam R_Type_ADD    = 9'b111_100000;  //funct = 6'h20
localparam R_Type_SLL		 = 9'b111_000000;  //funct = 6'h00
localparam R_Type_SRL    = 9'b111_000010;	 //funct = 6'h02
localparam R_Type_JR		 = 9'b111_001000;	 //funct = 6'h08
localparam I_Type_ADDI   = 9'b100_xxxxxx;	 //R[rt] = R[rs] + SignExtImm
localparam I_Type_ORI    = 9'b_xxxxxx;	   //R[rt] = R[rs] | ZeroExtImm
localparam I_Type_ANDI   = 9'b_xxxxxx;		 //R[rt] = R[rs] & ZeroExtImm
localparam I_Type_LUI    = 9'b_xxxxxx;		 //R[rt] = {imm, 16’b0}
localparam I_Type_LW     = 9'b_xxxxxx;		 //R[rt] = M[R[rs]+SignExtImm]
localparam I_Type_SW     = 9'b_xxxxxx;		 //M[R[rs]+SignExtImm] = R[rt]
localparam I_Type_BEQ	   = 9'b_xxxxxx;     //if(R[rs]==R[rt]): PC=PC+4+BranchAddr
localparam I_Type_BNE    = 9'b_xxxxxx;     //if(R[rs]!=R[rt]): PC=PC+4+BranchAddr
localparam J_Type_JAL    = 9'bxxx_xxxxxx;  //R[31]=PC+8;PC=JumpAddr

reg [3:0] ALUControlValues;
wire [8:0] Selector;

assign Selector = {ALUOp, ALUFunction};

/*
AND = 4'b0000;
OR  = 4'b0001;
NOR = 4'b0010;
ADD = 4'b0011;
SUB = 4'b0100;
LUI = 4'b0101;
JAL = 4'b0110;
*/

always@(Selector)begin
	casex(Selector)
		R_Type_AND:    ALUControlValues = 4'b0000;
		R_Type_SUB:		 ALUControlValues = 4'b0100;
		R_Type_OR:     ALUControlValues = 4'b0001;
		R_Type_NOR:    ALUControlValues = 4'b0010;
		R_Type_ADD:    ALUControlValues = 4'b0011;
		R_Type_SLL: 	ALUControlValues = 4'b1110;
		R_Type_SRL: 	ALUControlValues = 4'b1100;
		R_Type_JR: 	   ALUControlValues = 4'b0110;


		

		I_Type_ADDI:   ALUControlValues = 4'b0011;
		I_Type_ORI:    ALUControlValues = 4'b0001;
		I_Type_BEQ: 	ALUControlValues = 4'b0100;

		
		
		default: ALUControlValues = 4'b1001;
	endcase
end


assign ALUOperation = ALUControlValues;

endmodule
