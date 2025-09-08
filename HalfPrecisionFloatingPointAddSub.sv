module HalfPrecisionFloatingPointAddSub(
input clk, 
inout [7:0] lcd_data,
output lcd_rs,
output lcd_rw, 
output lcd_e,
input lcd_reset,

input operation,

input [3:0] row,
output [3:0] col,

input loadA, loadB, loadR

);


logic [15:0] out; //keypad output 

//for loadA and loadB register
logic [15:0] Aholder;
logic [15:0] Bholder;

//for exponent subtractor 
logic Cout_EX_SUB;
logic [4:0] EX_SUB_result;

//for the three mux
logic [10:0] smallerMantissa, largerMantissa;
logic [4:0] largerExp;

logic [10:0] correctedMantissa; //correct mantissa after shifting
logic [10:0] rippleMantissa; //mantissa after adding both mantissa 
logic Cout_Mantissa; //cout from ripple carry

logic [4:0] cont_exponent;//controleld exponent

logic [10:0] finalMantissa; //Mantissa from the normalizer

logic signBit; //the sign bit

Keypad theKeypad
(
	.clk(clk) ,	// input  clk_sig
	.reset(lcd_reset) ,	// input  reset_sig
	.row(row) ,	// input [3:0] row_sig
	.col(col) ,	// output [3:0] col_sig
	.out(out) ,	// output [DIGITS*4-1:0] out_sig
	.value() ,	// output [3:0] value_sig
	.trig() 	// output  trig_sig
);
	
//register for loading A
always_ff @(posedge loadA, negedge lcd_reset) begin
	if(lcd_reset == 0) Aholder <= 0; 
	else if(loadA == 1)  
		Aholder <= out; 
end

//register for loading B
always_ff @(posedge loadB, negedge lcd_reset) begin
	if(lcd_reset == 0) Bholder <= 0;  
	else if(loadB == 1) Bholder <= out; 
end

ExponentSubtractor ExponentSubtractor_inst
(
	.A(Aholder[14:10]) ,	// input [W-1:0] A_sig
	.B(Bholder[14:10]) ,	// input [W-1:0] B_sig
	.R(EX_SUB_result) ,	// output [W-1:0] R_sig
	.Cout(Cout_EX_SUB) 	// output  Cout_sig
);

logic addSubHolder;
logic Bsign;
always_ff @(*) begin
	
	//setting addSub
	Bsign <= Bholder[15];
	if(operation == 1'b1)  Bsign <= ~Bholder[15];
	
	if(Aholder[15] == 1'b1 && Bsign == 1'b1 )addSubHolder <= 1'b0;
	else if (Aholder[15] != Bsign) addSubHolder <= 1'b1;	
	else addSubHolder <= 1'b0;
	
	//setting the sign bit to show
	signBit <=  Cout_EX_SUB? Aholder[15]: Bsign;
end



//mux to select right exponent and mantissa
assign smallerMantissa = !Cout_EX_SUB ? {1'b1, Aholder[9:0]} : {1'b1, Bholder[9:0]}; //if zero pick A else pick B
assign largerMantissa = Cout_EX_SUB ? {1'b1, Aholder[9:0]} : {1'b1, Bholder[9:0]};
assign largerExp = Cout_EX_SUB ? Aholder[14:10] : Bholder[14:10]; 

//this is the sixteb bit right shifter ***Heavily eidted so might break****
EightBitRightBarrelShifter SixtenBitRightBarrelShifter
(
	.in(smallerMantissa) ,	// input [10:0] in_sig
	.ctrl(EX_SUB_result) ,	// input [4:0] ctrl_sig
	.out(correctedMantissa) 	// output [10:0] out_sig
);



//adder for mantissa
RippleCarryAddSub MantissaAddSub
(
	.A(largerMantissa) ,	// input [N-1:0] A_sig
	.B(correctedMantissa) ,	// input [N-1:0] B_sig
	.addSub(addSubHolder) , // 0 for add 1 for sub  ***addSubHolder
	.S(rippleMantissa) ,	// output [N-1:0] S_sig
	.Cout(Cout_Mantissa) 	// output  Cout_sig
);


//To noramalize the mantissa and inc or dec the exponent accordingly 
MantissaNormalizer theNormalizer
(
	.mantissa(rippleMantissa) ,	// input [10:0] mantissa_sig
	.exponent(largerExp) ,	// input [4:0] exponent_sig
	.operation(addSubHolder) ,	// input  operation_sig
	.Cout_Ripple(Cout_Mantissa) ,	// input  Cout_Ripple_sig
	.out_mantissa(finalMantissa) ,	// output [10:0] out_mantissa_sig
	.out_exponent(cont_exponent) 	// output [4:0] out_exponent_sig
);

//checking if loadR has been clicked
logic loadTheR;
always_ff @(posedge loadR, negedge lcd_reset) begin
	if(lcd_reset == 0) loadTheR <= 0; 
	else if(loadR == 1) loadTheR <= 1;
end

logic [15:0] finalOutputHolder;
always_ff@(*) begin
	if(Aholder[14:0] == Bholder[14:0]) begin //both A and B same and doing sub then output 0
		if(addSubHolder) finalOutputHolder <= 16'b0;
		else finalOutputHolder <= {signBit, cont_exponent, finalMantissa[9:0]};
	end
	else finalOutputHolder <= {signBit, cont_exponent, finalMantissa[9:0]};
	
	if(Aholder == 16'b0 && Bholder == 16'b0) finalOutputHolder <= 16'b0; //if both A and B 0, then output is 0
end

//loading the final output
logic [15:0] finalOutput;
always_ff @(*) begin
	if(loadTheR == 0) finalOutput <= out; 
	else if(loadTheR == 1) finalOutput <= finalOutputHolder;
end



LCDboard LCDboard_inst
(
	.clk(clk) ,	// input  clk_sig
	.lcd_data(lcd_data) ,	// inout [7:0] lcd_data_sig
	.lcd_rs(lcd_rs) ,	// output  lcd_rs_sig
	.lcd_rw(lcd_rw) ,	// output  lcd_rw_sig
	.lcd_e(lcd_e) ,	// output  lcd_e_sig
	.lcd_reset(lcd_reset) ,	// input  lcd_reset_sig
	.operation(operation) ,	// input  operation_sig
	.A(Aholder) ,	// input [15:0] A_sig
	.B(Bholder) ,	// input [15:0] B_sig
	.R(finalOutput) 	// input [15:0] R_sig
);

endmodule 