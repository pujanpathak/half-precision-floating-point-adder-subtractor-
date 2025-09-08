module twosComplementConverter #(parameter N = 5)(
	input [N-1:0] A,
	output [N-1:0] B
);

wire [N:0] ha;
assign ha[0] = 1'b1; 

genvar i;
generate

for(i=0; i<N; i=i+1) begin: twosFor
	halfADDER halfADDER_inst1
	(
		.s(B[i]), // output s_sig
		.cout(ha[i+1]), // output cout_sig
		.a(~A[i]),
		.b(ha[i]) // input b_sig
	);
end

endgenerate
endmodule

module halfADDER
(
	input a,
	input b,
	output s,
	output cout
);
	xor (s, a, b);
	and (cout, a, b);
endmodule
