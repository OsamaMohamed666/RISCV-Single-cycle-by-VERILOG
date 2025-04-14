module CPU (
	input				clk,
	input				rst,
	input		[31:0]	instr,
	input		[31:0]	rd_data, 
	output		[31:0]	pc,
	output		[31:0]	alu_res,
	output		[31:0]	wrt_data,
	output				mem_wrt
	);

//**********INSTANTIATION DATA PATH********** 
//internal signals DATA PATH
wire	[1:0]	pc_src;
wire	[1:0]	result_src,imm_src;
wire	[3:0]	alu_ctrl;
wire			alu_src,reg_wrt,zero;
Data_Path B1(
.clk(clk),
.rst(rst),
.instr(instr),
.pc_src(pc_src),
.result_src(result_src),
.mem_wrt(mem_wrt),
.alu_ctrl(alu_ctrl),
.alu_src(alu_src),
.imm_src(imm_src),
.reg_wrt(reg_wrt),
.rd_data(rd_data),
.pc(pc),
.alu_res(alu_res),
.wrt_data(wrt_data),
.zero(zero)
);

//**********INSTANTIATION CONTROL UNIT********** 
control_unit B2(
.instr(instr),
.pc_src(pc_src),
.result_src(result_src),
.mem_wrt(mem_wrt),
.alu_ctrl(alu_ctrl),
.alu_src(alu_src),
.imm_src(imm_src),
.reg_wrt(reg_wrt),
.zero(zero)
);
endmodule
