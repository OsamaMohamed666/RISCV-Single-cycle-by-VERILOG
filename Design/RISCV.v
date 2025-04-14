module RISCV(
	input				clk,
	input				rst
	);

//**********INSTANTIATION CPU********** 
//internal signals CPU	
wire 	[31:0]		instr,rd_data;
wire 	[31:0]		pc,alu_res,wrt_data;
wire				mem_wrt;
CPU DUT1(
.clk(clk),
.rst(rst),
.instr(instr),
.mem_wrt(mem_wrt),
.rd_data(rd_data),
.pc(pc),
.alu_res(alu_res),
.wrt_data(wrt_data)
);

//**********INSTANTIATION DATA MEMORY********** 
//internal signals DATA MEMORY
wire	[7:0]	addr;
assign addr = alu_res[9:2]; // according to specs you can put the whole alu result
data_mem DUT2(
.clk(clk),
.rst(rst),
.addr(addr),
.wrt_data(wrt_data),
.mem_wrt(mem_wrt),
.rd_data(rd_data)
);	

//**********INSTANTIATION INSTRUCTION MEMORY********** 
instr_mem DUT3(
.pc(pc[31:2]),
.instr(instr)
);

endmodule


