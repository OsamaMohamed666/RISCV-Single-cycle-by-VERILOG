module pc_next (
	input		[1:0]	pc_src, //controller
	input		[31:0]	pc,	
	input		[31:0]	imm_ext, //output of extend
	input		[31:0]	alu_res, // output of ALU
	output	reg	[31:0]	pc_nxt
	);
		
always @(*)
	begin 
		case (pc_src)
		2'b00 	: 	pc_nxt = pc + 4;
		2'b01 	:	pc_nxt = pc + imm_ext;		//for beq or bne or jal
		2'b10 	:	pc_nxt = {alu_res[31:1],1'b0};		//for jalr
		default : 	pc_nxt = pc;
		endcase
	end 
endmodule 