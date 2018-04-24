module ORGate
(
	input A,
	input B,
	
	output reg C
);


always@(*)
	C = A | B;

endmodule