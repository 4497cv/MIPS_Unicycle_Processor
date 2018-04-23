module Control
(
	input [5:0]OP,

	output RegDst,
	output BranchEQ,
	output BranchNE,
	output MemRead,
	output MemtoReg,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output Jump,
	output [2:0]ALUOp
);

reg [11:0] ControlValues; //CONTROL VALUES OUTPUT

/*OP CODES: Instruction[31:26]*/

localparam R_Type      = 6'h00;
localparam I_Type_ADDI = 6'h08;
localparam I_Type_ORI  = 6'h0d;
localparam I_Type_LUI  = 6'h0f;
localparam I_Type_ANDI = 6'h0c;
localparam I_Type_LW   = 6'h23;
localparam I_Type_SW	  = 6'h2b;
localparam I_Type_BEQ  = 6'h04;
localparam I_Type_BNE  = 6'h05;
localparam I_Type_J    = 6'h02;
localparam I_Type_JAL  = 6'h03;

/*ALU OP Control Values
	000: ADD
	001: SUB
	010: OR
	011: AND
	100: JAL
	101: LUI
	110: J
	111: FUNCT
*/

always@(OP) begin
	casex(OP)
		R_Type:       ControlValues= 12'b1_001_00_000_111; //RegDst,RegWrite; FunctField(111)
		I_Type_ADDI:  ControlValues= 12'b0_101_00_000_000; //
		I_Type_ORI:   ControlValues= 12'b0_101_00_000_010; //
		I_Type_ANDI:  ControlValues= 12'b0_000_00_000_011; //
		I_Type_LUI:   ControlValues= 12'b0_000_00_000_101; //
		I_Type_LW:	  ControlValues= 12'b0_111_10_000_000; //ALUSrc,MemtoReg,RegWrite,MemRead;ADD(000)
		I_Type_SW:	  ControlValues= 12'bx_000_00_000_000; //AlUSrc,MemWrite;ADD(000)
		I_Type_BEQ:	  ControlValues= 12'bx_100_x0_000_000; //BranchEQ;SUB(001)
		I_Type_BNE:	  ControlValues= 12'bx_010_x0_000_000; //BranchNE;SUB(001)
		I_Type_J: 	  ControlValues= 12'b0_000_00_001_110; //
		I_Type_JAL:	  ControlValues= 12'b0_000_00_001_100; //

		default:
			ControlValues= 11'b0_000_00_00_000;
		endcase
end

assign RegDst   = ControlValues[11];
assign ALUSrc   = ControlValues[10];
assign MemtoReg = ControlValues[9];
assign RegWrite = ControlValues[8];
assign MemRead  = ControlValues[7];
assign MemWrite = ControlValues[6];
assign BranchNE = ControlValues[5];
assign BranchEQ = ControlValues[4];
assign Jump     = ControlValues[3];
assign ALUOp    = ControlValues[2:0];

endmodule
