module EightBitRightBarrelShifter (in, ctrl, out); //16bits not eightanymore
	input [10:0] in;
	input [4:0] ctrl;
	output [10:0] out;
	logic [10:0] x, y, a, b, c;
	
	
	//16 bit shift --> will shift everything to zero
	mux2to1 inst_1610 (.in0(in[10]), .in1(1'b0), .sel(ctrl[4]), .out(a[10]));
	mux2to1 inst_1609 (.in0(in[9]), .in1(1'b0), .sel(ctrl[4]), .out(a[9]));
	mux2to1 inst_1608 (.in0(in[8]), .in1(1'b0), .sel(ctrl[4]), .out(a[8]));
	mux2to1 inst_1607 (.in0(in[7]), .in1(1'b0), .sel(ctrl[4]), .out(a[7]));
	mux2to1 inst_1606 (.in0(in[6]), .in1(1'b0), .sel(ctrl[4]), .out(a[6]));
	mux2to1 inst_1605 (.in0(in[5]), .in1(1'b0), .sel(ctrl[4]), .out(a[5]));
	mux2to1 inst_1604 (.in0(in[4]), .in1(1'b0), .sel(ctrl[4]), .out(a[4]));
	mux2to1 inst_1603 (.in0(in[3]), .in1(1'b0), .sel(ctrl[4]), .out(a[3]));
	mux2to1 inst_1602 (.in0(in[2]), .in1(1'b0), .sel(ctrl[4]), .out(a[2]));
	mux2to1 inst_1601 (.in0(in[1]), .in1(1'b0), .sel(ctrl[4]), .out(a[1]));
	mux2to1 inst_1600 (.in0(in[0]), .in1(1'b0), .sel(ctrl[4]), .out(a[0]));
	
	//8 bit shift
	mux2to1 inst_810 (.in0(a[10]), .in1(1'b0), .sel(ctrl[3]), .out(b[10]));
	mux2to1 inst_809 (.in0(a[9]), .in1(1'b0), .sel(ctrl[3]), .out(b[9]));
	mux2to1 inst_808 (.in0(a[8]), .in1(1'b0), .sel(ctrl[3]), .out(b[8]));
	mux2to1 inst_807 (.in0(a[7]), .in1(1'b0), .sel(ctrl[3]), .out(b[7]));
	mux2to1 inst_806 (.in0(a[6]), .in1(1'b0), .sel(ctrl[3]), .out(b[6]));
	mux2to1 inst_805 (.in0(a[5]), .in1(1'b0), .sel(ctrl[3]), .out(b[5]));
	mux2to1 inst_804 (.in0(a[4]), .in1(1'b0), .sel(ctrl[3]), .out(b[4]));
	mux2to1 inst_803 (.in0(a[3]), .in1(1'b0), .sel(ctrl[3]), .out(b[3]));
	mux2to1 inst_802 (.in0(a[2]), .in1(a[10]), .sel(ctrl[3]), .out(b[2]));
	mux2to1 inst_801 (.in0(a[1]), .in1(a[9]), .sel(ctrl[3]), .out(b[1]));
	mux2to1 inst_800 (.in0(a[0]), .in1(a[8]), .sel(ctrl[3]), .out(b[0]));
	
	//4 bit shift right
	mux2to1 inst_410 (.in0(b[10]), .in1(1'b0), .sel(ctrl[2]), .out(x[10]));
	mux2to1 inst_409 (.in0(b[9]), .in1(1'b0), .sel(ctrl[2]), .out(x[9]));
	mux2to1 inst_408 (.in0(b[8]), .in1(1'b0), .sel(ctrl[2]), .out(x[8]));
	mux2to1 inst_407 (.in0(b[7]), .in1(1'b0), .sel(ctrl[2]), .out(x[7]));
	mux2to1 inst_406 (.in0(b[6]), .in1(b[10]), .sel(ctrl[2]), .out(x[6]));
	mux2to1 inst_405 (.in0(b[5]), .in1(b[9]), .sel(ctrl[2]), .out(x[5]));
	mux2to1 inst_404 (.in0(b[4]), .in1(b[8]), .sel(ctrl[2]), .out(x[4]));
	mux2to1 inst_403 (.in0(b[3]), .in1(b[7]), .sel(ctrl[2]), .out(x[3]));
	mux2to1 inst_402 (.in0(b[2]), .in1(b[6]), .sel(ctrl[2]), .out(x[2]));
	mux2to1 inst_401 (.in0(b[1]), .in1(b[5]), .sel(ctrl[2]), .out(x[1]));
	mux2to1 inst_400 (.in0(b[0]), .in1(b[4]), .sel(ctrl[2]), .out(x[0]));
	
	
	//2 bit shift right
	mux2to1 inst_210 (.in0(x[10]), .in1(1'b0), .sel(ctrl[1]), .out(y[10]));
	mux2to1 inst_209 (.in0(x[9]), .in1(1'b0), .sel(ctrl[1]), .out(y[9]));
	mux2to1 inst_208 (.in0(x[8]), .in1(x[10]), .sel(ctrl[1]), .out(y[8]));
	mux2to1 inst_207 (.in0(x[7]), .in1(x[9]), .sel(ctrl[1]), .out(y[7]));
	mux2to1 inst_206 (.in0(x[6]), .in1(x[8]), .sel(ctrl[1]), .out(y[6]));
	mux2to1 inst_205 (.in0(x[5]), .in1(x[7]), .sel(ctrl[1]), .out(y[5]));
	mux2to1 inst_204 (.in0(x[4]), .in1(x[6]), .sel(ctrl[1]), .out(y[4]));
	mux2to1 inst_203 (.in0(x[3]), .in1(x[5]), .sel(ctrl[1]), .out(y[3]));
	mux2to1 inst_202 (.in0(x[2]), .in1(x[4]), .sel(ctrl[1]), .out(y[2]));
	mux2to1 inst_201 (.in0(x[1]), .in1(x[3]), .sel(ctrl[1]), .out(y[1]));
	mux2to1 inst_200 (.in0(x[0]), .in1(x[2]), .sel(ctrl[1]), .out(y[0]));
	
	//1 bit shift right
	mux2to1 inst_10 (.in0(y[10]), .in1(1'b0), .sel(ctrl[0]), .out(out[10]));
	mux2to1 inst_09 (.in0(y[9]), .in1(y[10]), .sel(ctrl[0]), .out(out[9]));
	mux2to1 inst_08 (.in0(y[8]), .in1(y[9]), .sel(ctrl[0]), .out(out[8]));
	mux2to1 inst_07 (.in0(y[7]), .in1(y[8]), .sel(ctrl[0]), .out(out[7]));
	mux2to1 inst_06 (.in0(y[6]), .in1(y[7]), .sel(ctrl[0]), .out(out[6]));
	mux2to1 inst_05 (.in0(y[5]), .in1(y[6]), .sel(ctrl[0]), .out(out[5]));
	mux2to1 inst_04 (.in0(y[4]), .in1(y[5]), .sel(ctrl[0]), .out(out[4]));
	mux2to1 inst_03 (.in0(y[3]), .in1(y[4]), .sel(ctrl[0]), .out(out[3]));
	mux2to1 inst_02 (.in0(y[2]), .in1(y[3]), .sel(ctrl[0]), .out(out[2]));
	mux2to1 inst_01 (.in0(y[1]), .in1(y[2]), .sel(ctrl[0]), .out(out[1]));
	mux2to1 inst_00 (.in0(y[0]), .in1(y[1]), .sel(ctrl[0]), .out(out[0]));
	
endmodule 