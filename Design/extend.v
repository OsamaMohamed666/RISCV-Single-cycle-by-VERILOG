module extend(
	input		[24:0]	instr_in, // instruction[31:7] bits
	input		[1:0]	imm_src,
	output 	reg	[31:0]	imm_ext
	);
	
always @ (*)
	begin 
		imm_ext=0;
		case(imm_src)
					// FOR I TYPE
		2'b00	:	imm_ext = {{20{instr_in[24]}},instr_in[24:13]};
					// FOR S TYPE
		2'b01	:	imm_ext = {{20{instr_in[24]}},instr_in[24:18],instr_in[4:0]};
					// FOR B TYPE
		2'b10	:	imm_ext = {{20{instr_in[24]}},instr_in[7],instr_in[23:18],instr_in[4:1],1'b0};
					// FOR J TYPE
		2'b11	:	imm_ext = {{12{instr_in[24]}},instr_in[12:5],instr_in[13],instr_in[23:14],1'b0};
		
		endcase 
	end
endmodule 