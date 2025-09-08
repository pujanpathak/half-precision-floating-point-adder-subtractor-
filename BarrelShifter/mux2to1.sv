module mux2to1 (
	input in0, in1, sel,
	output out
);

always_comb 
begin
	case(sel) 
		1'b0: out = in0;
		1'b1: out = in1;
	endcase 
end

endmodule 