module PC (
	input				clk,
	input				rst,
	input		[31:0]	pc_nxt, 
	output	reg	[31:0]	pc
	);

always @(posedge clk or negedge rst)
	begin
		if(!rst)
			pc <=0;
		else
			pc <= pc_nxt;
	end 
endmodule 