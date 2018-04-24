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
	output JumpAndLink,
	output ZeroImm,
	output LUI,
	output [2:0]ALUOp
);

reg [14:0] ControlValues; //CONTROL VALUES OUTPUT

/*OP CODES: Instruction[31:26]*/

localparam R_Type      = 6'h00; //*
localparam I_Type_ADDI = 6'h08; //*
localparam I_Type_ORI  = 6'h0d; //*
localparam I_Type_LUI  = 6'h0f; //*
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
		R_Type:       ControlValues= 15'b1_001_00_00000_0_111; //RegDst:Rt,RegWrite; FunctField(111)
		I_Type_ADDI:  ControlValues= 15'b0_101_00_00000_0_011; //RegDst:RS,ALUSRC; ADD(011)
		I_Type_ORI:   ControlValues= 15'b0_001_00_00001_0_001; //RegDest:Rt,RegWrite,ZeroImm; OR(001)
		I_Type_ANDI:  ControlValues= 15'b0_001_00_00001_0_000; //RegDest:Rt,RegWrite, ZeroImm; AND(000)
		I_Type_LUI:   ControlValues= 15'b0_001_00_00000_1_101; //RegDest:Rt,RegWrite, ;LUI(101)
		I_Type_LW:	  ControlValues= 15'b0_111_10_00000_0_011; //ALUSrc,MemtoReg,RegWrite,MemRead;ADD(011)
		I_Type_SW:	  ControlValues= 15'b0_100_01_00000_0_011; //AlUSrc,MemWrite;ADD(011)
		I_Type_BEQ:	  ControlValues= 15'b0_000_00_01000_0_100; //BranchEQ;SUB(100)
		I_Type_BNE:	  ControlValues= 15'b0_000_00_10000_0_100; //BranchNE;SUB(100)
		I_Type_J: 	  ControlValues= 15'b0_000_00_00100_0_xxx; //Jump; NO-ALU
		I_Type_JAL:	  ControlValues= 15'b0_000_00_00010_0_110; //Jump; JAL(110)

		default:
									ControlValues= 15'b0_000_00_0000_0_000;
		endcase
end

assign RegDst      = ControlValues[14];
assign ALUSrc      = ControlValues[13];
assign MemtoReg    = ControlValues[12];
assign RegWrite    = ControlValues[11];
assign MemRead     = ControlValues[10];
assign MemWrite    = ControlValues[9];
assign BranchNE    = ControlValues[8];
assign BranchEQ    = ControlValues[7];
assign Jump        = ControlValues[6];
assign JumpAndLink = ControlValues[5];
assign ZeroImm     = ControlValues[4];
assign LUI         = ControlValues[3];
assign ALUOp       = ControlValues[2:0];

endmodule
