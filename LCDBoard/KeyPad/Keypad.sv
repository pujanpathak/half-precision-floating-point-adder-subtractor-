module Keypad #( parameter DIGITS = 4) // Depends: keypad_base(clock_div,keypad_fsm,keypad_decoder), shift_reg
( 
	input clk,
	input reset,
	input [3:0] row,
	output [3:0] col,
	output [(DIGITS*4)-1:0] out,
	// Debug
	output [3:0] value,
	output trig
);

//Key Pad base
 keypad_base keypad_base(
	.clk(clk),
	.row(row),
	.col(col),
	.value(value),
	.valid(trig)
 );
 
 logic inHolder;
 
 always @(posedge clk) begin
	if(value == 1'd1) inHolder <= 1'b1;
	else inHolder <= 1'b0;
end
		

 //Shift Register
 shift_reg #(.COUNT(DIGITS)) shift_reg(
	.trig(trig),
	//.in(value),
	.in(inHolder),
	.dir(0), //mine
	.out(out),
	.reset(reset)
 );
 endmodule
