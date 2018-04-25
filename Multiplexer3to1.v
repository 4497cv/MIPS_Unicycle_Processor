module Multiplexer3to1
#(
	parameter NBits=32
)
(
	input [1:0] Selector,
	input [NBits-1:0] MUX_Data0,
	input [NBits-1:0] MUX_Data1,
	input [NBits-1:0] MUX_Data2,

	output reg [NBits-1:0] MUX_Output
);

	always@(Selector,MUX_Data2,MUX_Data1,MUX_Data0)
	 begin
		if(Selector == 2'b01)
			MUX_Output = MUX_Data1;
		else if(Selector == 2'b00)
			MUX_Output = MUX_Data0;
		else if(Selector == 2'b10)
			MUX_Output = MUX_Data2;
	end

endmodule
