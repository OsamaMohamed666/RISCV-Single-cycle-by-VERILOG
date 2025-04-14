module result_mux (
	input		[1:0]	result_src, //signal from control unit
	input		[31:0]	alu_res, //output of ALU
	input		[31:0]	rd_data,    //output of data memory during loading
	input		[31:0]	pc,		//pc 
	output reg	[31:0]	result		//the output 
	);
	
always @ (*)
	begin
		casex(result_src)
		2'b00 : result =alu_res;
		2'b01 : result =rd_data;
		2'b10 : result =pc+4; //pc added to 4
		2'b11 : result =32'bx;
		endcase 
	end
endmodule 