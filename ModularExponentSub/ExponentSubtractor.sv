module ExponentSubtractor #(parameter W = 5)(
	input [W-1:0] A, B,
	output [W-1:0] R,
	output Cout
);

logic [W-1:0] RippleOut, ComplementOut;

RippleCarrySubtractor #(.N(W)) RippleSub
(
	.A(A) ,	// input [N-1:0] A_sig
	.B(B) ,	// input [N-1:0] B_sig
	.S(RippleOut) ,	// output [N-1:0] S_sig
	.Cout(Cout) 	// output  Cout_sig
);

twosComplementConverter #(.N(W))twoComplement
(
	.A(RippleOut) ,	// input [N-1:0] A_sig
	.B(ComplementOut) 	// output [N-1:0] Z_sig
);

assign R = (Cout == 1'd0) ? ComplementOut : RippleOut;


endmodule 