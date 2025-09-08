module LCDboard
	 (input                clk       , // 50MHz Clock
	  inout    [7:0]       lcd_data  , // LCD Data Bus
	  output               lcd_rs    , // LCD Register Select
	  output               lcd_rw    , // LCD Read Write Select
	  output               lcd_e     , // LCD Execute
	  input                lcd_reset,
	  
	  input operation,
	  
	  input [15:0] A, B, R

	  ); // LCD Reset
	 
	
	LCD #(
		 .WIDTH(64),
		 .DIGITS(16),
		 .FLOAT(0),
		 .MODE(1),
		 .LINES(4),
		 .CHARS(20),
		 .LINE_STARTS({7'h00, 7'h40, 7'h14, 7'h54})
		 )(
		 .clk(clk),
		 .lcd_data(lcd_data),
		 .lcd_rs(lcd_rs),
		 .lcd_rw(lcd_rw),
		 .lcd_e(lcd_e),
		 .lcd_reset(!lcd_reset),
		 .A(A),
		 .B(B),
		 .C(R),
		 .Operation(operation)
	);

endmodule
