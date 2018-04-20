/******************************************************************
* Description
*	This is an 32-bit arithetic logic unit that can execute the next set of operations:
*		add
*		sub
*		or
*		and
*		nor
* This ALU is written by using behavioral description.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/

module ALU 
(
	input [3:0] ALUOperation,
	input [31:0] A,
	input [31:0] B,
	output reg Zero,
	output reg [31:0]ALUResult
);

localparam ADD = 4'b0011;
localparam SUB = 4'b0100;
   
   always @ (A or B or ALUOperation)
     begin
		case (ALUOperation)
		  ADD: // add
			ALUResult=A + B;
		  SUB: // sub
			ALUResult=A - B;

		default:
			ALUResult= 0;
		endcase // case(control)
		Zero = (ALUResult==0) ? 1'b1 : 1'b0;
     end // always @ (A or B or control)
endmodule // ALU