module Data_Path (
	input				clk,
	input				rst, //active low
	input		[31:0]	instr, //instruction
	input		[1:0]	pc_src,
	input		[1:0]	result_src,
	input				mem_wrt,
	input	 	[3:0]	alu_ctrl, 
	input				alu_src,			
	input		[1:0]	imm_src,
	input				reg_wrt,
	input		[31:0]	rd_data, //read data output of data memory 
	output		[31:0]	pc,
	output		[31:0]	alu_res, 
	output		[31:0]	wrt_data, //write data input of data memory 
	output				zero
	);
	
//**********INSTANTIATION OF REGISTER FILE********** 
//internal signals of register file
wire	[4:0]	rs1_num,rs2_num,rd_num;
wire	[31:0]	result,rs1,rs2;
//their position in instruction bits 
assign rs1_num = instr[19:15];
assign rs2_num = instr[24:20];
assign rd_num = instr[11:7];
register_file U1(
.clk(clk),
.rst(rst),
.reg_wrt(reg_wrt),
.rs1_num(rs1_num),
.rs2_num(rs2_num),
.rd_num(rd_num),
.result(result),
.rs1(rs1),
.rs2(rs2)
);
assign wrt_data = rs2;
//**********INSTANTIATION OF ALU********** 
//internal signals of ALU	
wire	[31:0]	src_b;
alu U2(
.a(rs1),
.b(src_b),
.alu_ctrl(alu_ctrl),
.alu_res(alu_res),
.zero(zero)
);

//**********INSTANTIATION OF PC NEXT (MUX)********** 
//internal signals of PC NEXT 	
wire	[31:0]	imm_ext,pc_nxt;
pc_next U3(
.pc_src(pc_src),
.pc(pc),
.imm_ext(imm_ext),
.alu_res(alu_res),
.pc_nxt(pc_nxt)
);

//**********INSTANTIATION OF PC********** 
PC U4(
.clk(clk),
.rst(rst),
.pc_nxt(pc_nxt),
.pc(pc)
);

//**********INSTANTIATION OF EXTEND********** 
//internal signals of EXTEND 
wire	[24:0]	instr_in;
assign instr_in = instr[31:7];
extend U5(
.instr_in(instr_in),
.imm_src(imm_src),
.imm_ext(imm_ext)
);

//**********INSTANTIATION OF ALU MUX********** 
alu_mux U6(
.alu_src(alu_src),
.rs2(rs2),
.imm_ext(imm_ext),
.src_b(src_b)
);

//**********INSTANTIATION OF RESULT MUX********** 
result_mux U7(
.result_src(result_src),
.alu_res(alu_res),
.rd_data(rd_data),
.pc(pc),
.result(result)
);

endmodule