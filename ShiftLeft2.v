/******************************************************************
* Description
*	This performs a shift left opeartion in roder to calculate the brances.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module ShiftLeft2 
(   
	input [31:0]  DataInput,
   output reg [31:0] DataOutput

);
   always @ (DataInput)
     DataOutput = {DataInput[29:0], 1'b0, 1'b0};

endmodule // leftShift2