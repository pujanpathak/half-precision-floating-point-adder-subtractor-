module MantissaNormalizer(
input [10:0] mantissa, 
input [4:0] exponent,
input operation,
input Cout_Ripple,

output [10:0] out_mantissa, 
output [4:0] out_exponent

);

logic [10:0] normalizedMantissa;
logic [4:0]  normalizedExponent;

always_comb begin 
	normalizedMantissa = mantissa;
	normalizedExponent = exponent;
	
	//if addition then do one right shift and add 1 to exponent
	if(operation == 0) begin
		if(Cout_Ripple) begin
			normalizedMantissa = mantissa >> 1'b1;
			normalizedExponent = exponent + 1'b1;
		end
	end
	else begin //if subtraction do enough left shift so that there is a leading 1 
	for (int i = 10; i >= 0; i--) begin //decrement everytime I left shift
		if (normalizedMantissa[10] == 1'b1) break;
			normalizedMantissa = normalizedMantissa << 1'b1;
			normalizedExponent = normalizedExponent - 1'b1;
		end
	end
	
	out_mantissa = normalizedMantissa;
	out_exponent = normalizedExponent;
end
	
		
endmodule 


