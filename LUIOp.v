module LUIOp
(
  input [15:0] immediate,

  output reg [32:0] ImmLUI
);

always@(*)
	ImmLUI = {immediate,16'h0000};

endmodule
