module data_mem(
	input				clk,
	input				rst,
	input		[7:0]	addr,      //address bits [9:2] of output of alu result
	input		[31:0]	wrt_data, //data written in memory during storing operation
	input				mem_wrt, //signal of control unit to activate writing 
	output		[31:0]	rd_data //read data from memory during loading operation 
	);

reg [31:0] mem [0:255]; //memory array of 32 bits width and 256 words
integer i;

always @ (posedge clk or negedge rst)
	begin
		if (!rst) //active low
			begin
				for (i=0; i<256; i=i+1)
					mem[i]<=0;
			end
		else if (mem_wrt)
			mem[addr]<=wrt_data;
	end
assign rd_data=mem[addr]; //asynchronous reading 
endmodule 