/*
	TITLE: ARITHMETIC LOGIC UNIT MODULE
	CODED BY CÉSAR VILLARREAL & GUILLERMO ROLDÁN

	Description:

	this module executes operations of inputs A and B;
	if branch is equal, ALU must return zero.

*/

module ALU
(
	input [3:0] ALUOperation,
	input [31:0] A,
	input [31:0] B,
	input [4:0] sh,
	output reg JR,
	output reg Zero,
	output reg [31:0]ALUResult
);

localparam AND  = 4'b0000;
localparam OR   = 4'b0001;
localparam NOR  = 4'b0010;
localparam ADD  = 4'b0011;
localparam SUB  = 4'b0100;
localparam ZERO = 4'b0101;
localparam SLL  = 4'b1000;
localparam SRL  = 4'b0111;

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
		  SRL:
				ALUResult = (B >> sh);
		  SLL:
				ALUResult =	(B << sh);
		default:
			ALUResult= 0;
		endcase // case(control)

		JR   = (ALUOperation == 4'b1001) ? 1'b1 : 1'b0;

		Zero = (ALUResult == 0) ? 1'b1 : 1'b0;

    end // always @ (A or B or control)

endmodule
