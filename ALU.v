/*
	TITLE: ARITHMETIC LOGIC UNIT MODULE
	CODED BY CÉSAR VILLARREAL & GUILLERMO ROLDÁN

	Description:

	this module executes operations of inputs A and B;
	if branch is equal, ALU must return zero.

*/

module ALU
(
	input [2:0] ALUOperation,
	input [31:0] A,
	input [31:0] B,
	output reg Zero,
	output reg [31:0]ALUResult
);

localparam AND  = 3'b000;
localparam OR   = 3'b001;
localparam NOR  = 3'b010;
localparam ADD  = 3'b011;
localparam SUB  = 3'b100;
localparam ZERO = 3'b101;
localparam SSL  = 3'b110;
localparam SRL  = 3'b001;

   always @ (A or B or ALUOperation)
     begin
		case (ALUOperation)
		  ADD: // add
				ALUResult = A + B;
		  SUB: // sub
				ALUResult = A - B;
		  AND:
				ALUResult = A & B;
		  OR:
				ALUResult = A | B;
		  NOR:
				ALUResult = ~(A | B);
			ZERO:
				ALUResult = 0;

		/*	SRL:
				ALUResult = (B >> shamt);
			SLL:
				ALUResult =	(B << shamt);
		*/

		default:
			ALUResult= 0;
		endcase // case(control)
		Zero = (ALUResult==0) ? 1'b1 : 1'b0;
     end // always @ (A or B or control)
endmodule
