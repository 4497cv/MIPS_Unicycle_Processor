module JumpAddrOP
(
  input [3:0] PC_4,
  input [25:0] address,

  output reg [32:0] JumpAddr
);

always@(*)
	begin
	JumpAddr = {PC_4, address, 2'b00};
  JumpAddr = JumpAddr;
	end

endmodule
