/******************************************************************
* Description
*	This a decoder used in the register file.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module DecoderRegisterFile
(
	input [4:0] WriteRegister,
	output [31:0] SelectRegister
);
reg [31:0] SelectRegister_reg;

always@(*)begin
	case(WriteRegister)
		0:   SelectRegister_reg = 32'b0000_0000_0000_0000_0000_0000_0000_0001;
		1:	  SelectRegister_reg = 32'b0000_0000_0000_0000_0000_0000_0000_0010;
		2:	  SelectRegister_reg = 32'b0000_0000_0000_0000_0000_0000_0000_0100;
		3:	  SelectRegister_reg = 32'b0000_0000_0000_0000_0000_0000_0000_1000;
		4:	  SelectRegister_reg = 32'b0000_0000_0000_0000_0000_0000_0001_0000;		
		5:	  SelectRegister_reg = 32'b0000_0000_0000_0000_0000_0000_0010_0000;
		6:	  SelectRegister_reg = 32'b0000_0000_0000_0000_0000_0000_0100_0000;
		7:	  SelectRegister_reg = 32'b0000_0000_0000_0000_0000_0000_1000_0000;
		8:	  SelectRegister_reg = 32'b0000_0000_0000_0000_0000_0001_0000_0000;
		9:	  SelectRegister_reg = 32'b0000_0000_0000_0000_0000_0010_0000_0000;
		10:  SelectRegister_reg = 32'b0000_0000_0000_0000_0000_0100_0000_0000;
		11:  SelectRegister_reg = 32'b0000_0000_0000_0000_0000_1000_0000_0000;
		12:  SelectRegister_reg = 32'b0000_0000_0000_0000_0001_0000_0000_0000;
		13:  SelectRegister_reg = 32'b0000_0000_0000_0000_0010_0000_0000_0000;
		14:  SelectRegister_reg = 32'b0000_0000_0000_0000_0100_0000_0000_0000;
		15:  SelectRegister_reg = 32'b0000_0000_0000_0000_1000_0000_0000_0000;
		16:  SelectRegister_reg = 32'b0000_0000_0000_0001_0000_0000_0000_0000;
		17:  SelectRegister_reg = 32'b0000_0000_0000_0010_0000_0000_0000_0000;
		18:  SelectRegister_reg = 32'b0000_0000_0000_0100_0000_0000_0000_0000;
		19:  SelectRegister_reg = 32'b0000_0000_0000_1000_0000_0000_0000_0000;
		20:  SelectRegister_reg = 32'b0000_0000_0001_0000_0000_0000_0000_0000;
		21:  SelectRegister_reg = 32'b0000_0000_0010_0000_0000_0000_0000_0000;		
		22:  SelectRegister_reg = 32'b0000_0000_0100_0000_0000_0000_0000_0000;
		23:  SelectRegister_reg = 32'b0000_0000_1000_0000_0000_0000_0000_0000;
		24:  SelectRegister_reg = 32'b0000_0001_0000_0000_0000_0000_0000_0000;
		25:  SelectRegister_reg = 32'b0000_0010_0000_0000_0000_0000_0000_0000;
		26:  SelectRegister_reg = 32'b0000_0100_0000_0000_0000_0000_0000_0000;
		27:  SelectRegister_reg = 32'b0000_1000_0000_0000_0000_0000_0000_0000;
		28:  SelectRegister_reg = 32'b0001_0000_0000_0000_0000_0000_0000_0000;
		29:  SelectRegister_reg = 32'b0010_0000_0000_0000_0000_0000_0000_0000;
		30:  SelectRegister_reg = 32'b0100_0000_0000_0000_0000_0000_0000_0000;
		31:  SelectRegister_reg = 32'b1000_0000_0000_0000_0000_0000_0000_0000;
	endcase
end

assign SelectRegister = SelectRegister_reg;




endmodule