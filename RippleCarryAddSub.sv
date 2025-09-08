module RippleCarryAddSub #(parameter N = 11)(
	input [N-1:0] A, B,
	input addSub,
	output [N-1: 0] S, 
	output Cout
);

	logic [N:0] C; 
	assign C[0] = addSub; //0 for add 1 for sub
	
	//5 Full adder for the 5 bit input 
	FAbehav s0 (A[0], B[0]^C[0], C[0], S[0], C[1]); 
	FAbehav s1 (A[1], B[1]^C[0], C[1], S[1], C[2]); 
	FAbehav s2 (A[2], B[2]^C[0], C[2], S[2], C[3]); 
	FAbehav s3 (A[3], B[3]^C[0], C[3], S[3], C[4]); 
	FAbehav s4 (A[4], B[4]^C[0], C[4], S[4], C[5]);  
	FAbehav s5 (A[5], B[5]^C[0], C[5], S[5], C[6]); 
	FAbehav s6 (A[6], B[6]^C[0], C[6], S[6], C[7]); 
	FAbehav s7 (A[7], B[7]^C[0], C[7], S[7], C[8]);
	
	FAbehav s8 (A[8], B[8]^C[0], C[8], S[8], C[9]);
	FAbehav s9 (A[9], B[9]^C[0], C[9], S[9], C[10]);
	FAbehav s10 (A[10], B[10]^C[0], C[10], S[10], C[11]);
	

	
	
	assign Cout = C[N]; // Cout flag
endmodule 