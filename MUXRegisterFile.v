
module MUXRegisterFile
#(
	parameter N=32
)
(
	input [4:0] Selector,

	input [N-1:0] Data_0,
	input [N-1:0] Data_1,
	input [N-1:0] Data_2,
	input [N-1:0] Data_3,
	input [N-1:0] Data_4,
	input [N-1:0] Data_5,
	input [N-1:0] Data_6,
	input [N-1:0] Data_7,
	input [N-1:0] Data_8,
	input [N-1:0] Data_9,
	input [N-1:0] Data_10,
	input [N-1:0] Data_11,
	input [N-1:0] Data_12,
	input [N-1:0] Data_13,
	input [N-1:0] Data_14,
	input [N-1:0] Data_15,
	input [N-1:0] Data_16,
	input [N-1:0] Data_17,
	input [N-1:0] Data_18,
	input [N-1:0] Data_19,
	input [N-1:0] Data_20,
	input [N-1:0] Data_21,
	input [N-1:0] Data_22,
	input [N-1:0] Data_23,
	input [N-1:0] Data_24,
	input [N-1:0] Data_25,
	input [N-1:0] Data_26,
	input [N-1:0] Data_27,
	input [N-1:0] Data_28,
	input [N-1:0] Data_29,
	input [N-1:0] Data_30,
	input [N-1:0] Data_31,
	
	output reg [N-1:0] MUX_Output
	
);

always@(*)begin
	case(Selector)
		0: MUX_Output = Data_0;
		1: MUX_Output = Data_1;
		2: MUX_Output = Data_2;
		3: MUX_Output = Data_3;
		4: MUX_Output = Data_4;
		5: MUX_Output = Data_5;
		6: MUX_Output = Data_6;
		7: MUX_Output = Data_7;
		8: MUX_Output = Data_8;
		9: MUX_Output = Data_9;
		10: MUX_Output = Data_10;
		11: MUX_Output = Data_11;
		12: MUX_Output = Data_12;
		13: MUX_Output = Data_13;
		14: MUX_Output = Data_14;
		15: MUX_Output = Data_15;
		16: MUX_Output = Data_16;
		17: MUX_Output = Data_17;
		18: MUX_Output = Data_18;
		19: MUX_Output = Data_19;
		20: MUX_Output = Data_20;
		21: MUX_Output = Data_21;
		22: MUX_Output = Data_22;
		23: MUX_Output = Data_23;
		24: MUX_Output = Data_24;
		25: MUX_Output = Data_25;
		26: MUX_Output = Data_26;
		27: MUX_Output = Data_27;
		28: MUX_Output = Data_28;
		29: MUX_Output = Data_29;
		30: MUX_Output = Data_30;
		31: MUX_Output = Data_31;
	endcase
end

endmodule



