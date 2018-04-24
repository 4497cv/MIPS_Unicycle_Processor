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
	output ZeroImm,
	output LUI,
	output [2:0]ALUOp
);

reg [13:0] ControlValues; //CONTROL VALUES OUTPUT

/*OP CODES: Instruction[31:26]*/

localparam R_Type      = 6'h00; //*
localparam I_Type_ADDI = 6'h08; //*
localparam I_Type_ORI  = 6'h0d; //*
localparam I_Type_LUI  = 6'h0f;
localparam I_Type_ANDI = 6'h0c; //*
localparam I_Type_LW   = 6'h23; //
localparam I_Type_SW   = 6'h2b; //
localparam I_Type_BEQ  = 6'h04; //*
localparam I_Type_BNE  = 6'h05; //*
localparam I_Type_J    = 6'h02;
localparam I_Type_JAL  = 6'h03;

/*
localparam AND = 3'b000;
localparam OR  = 3'b001;
localparam NOR = 3'b010;
localparam ADD = 3'b011;
localparam SUB = 3'b100;
localparam LUI = 3'b101;
localparam JAL = 3'b110;
*/

always@(OP) begin
	casex(OP)
		R_Type:       ControlValues= 14'b1_001_00_0000_0_111; //RegDst:Rt,RegWrite; FunctField(111)
		I_Type_ADDI:  ControlValues= 14'b0_101_00_0000_0_011; //RegDst:RS,ALUSRC; ADD(011)
		I_Type_ORI:   ControlValues= 14'b0_001_00_0001_0_001; //RegDest:Rt,RegWrite,ZeroImm; OR(001)
		I_Type_ANDI:  ControlValues= 14'b0_001_00_0001_0_000; //RegDest:Rt,RegWrite, ZeroImm; AND(000)
		I_Type_LUI:   ControlValues= 14'b0_001_00_0000_1_101; //RegDest:Rt,RegWrite, ;LUI(101)
		I_Type_LW:	  ControlValues= 14'b0_111_10_0000_0_011; //ALUSrc,MemtoReg,RegWrite,MemRead;ADD(011)
		I_Type_SW:	  ControlValues= 14'b0_100_01_0000_0_011; //AlUSrc,MemWrite;ADD(011)
		I_Type_BEQ:	  ControlValues= 14'b0_000_00_0100_0_100; //BranchEQ;SUB(100)
		I_Type_BNE:	  ControlValues= 14'b0_000_00_1000_0_100; //BranchNE;SUB(100)
		I_Type_J: 	  ControlValues= 14'b0_000_00_0010_0_110; //
		I_Type_JAL:	  ControlValues= 14'b0_000_00_0010_0_100; //

		default:
			ControlValues= 14'b0_000_00_0000_000;
		endcase
end

assign RegDst   = ControlValues[13];
assign ALUSrc   = ControlValues[12];
assign MemtoReg = ControlValues[11];
assign RegWrite = ControlValues[10];
assign MemRead  = ControlValues[9];
assign MemWrite = ControlValues[8];
assign BranchNE = ControlValues[7];
assign BranchEQ = ControlValues[6];
assign Jump     = ControlValues[5];
assign ZeroImm  = ControlValues[4];
assign LUI      = ControlValues[3];
assign ALUOp    = ControlValues[2:0];

endmodule
