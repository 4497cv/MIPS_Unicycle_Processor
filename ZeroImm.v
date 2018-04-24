module ZeroImm
(
  input [15:0] immediate,

  output reg [32:0] ZeroExtImm
);

always@(*)
	ZeroExtImm = {16'h0000, immediate};

endmodule
