module register_file (
	input				clk,
	input				rst,
	input				reg_wrt,
	input		[4:0]	rs1_num,
	input		[4:0]	rs2_num,
	input		[4:0]	rd_num,
	input		[31:0]	result,
	output		[31:0]	rs1,
	output		[31:0]	rs2
	);
/*
//internal signals (rs1 ,rs2 ,rd) number
wire	[4:0]	rs1_num,rs2_num,rd_num;
//their position in instruction bits 
assign rs1_num = instr[19:15];
assign rs2_num = instr[24:20];
assign rd_num = instr[11:7]; */
//the register file: x0 to x31 of width 32 bits 
reg	[31:0] x [0:31]; 

integer i;
always@(posedge clk or negedge rst)
	begin 
		if (!rst)
			begin 
				for (i=0; i<31; i=i+1) 
					begin 
						x[i]<=0; //initialization of registers
					end
			end 
		else 
			begin
				if (reg_wrt)
					x[rd_num] <= result;
			end
	end
assign rs1 = x[rs1_num]; //asynchronous register source 1
assign rs2 = x[rs2_num]; //asynchronous register source 2
endmodule 	

				



