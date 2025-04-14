module alu_mux (
	input				alu_src,
	input		[31:0]	rs2,      //output of register file
	input		[31:0]	imm_ext, //output of extend
	output 		[31:0]	src_b   //input of alu
	);
	
assign src_b = alu_src ? imm_ext : rs2;

endmodule 