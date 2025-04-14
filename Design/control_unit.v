module control_unit /*#(parameter width=4)*/ (
	input			[31:0]		instr, // instruction 32bit
	input						zero,
	output	reg		[1:0]		pc_src,
	output	reg		[1:0]		result_src,
	output	reg					mem_wrt,
	output	reg	 	[3:0]		alu_ctrl, 
	output	reg					alu_src,			
	output	reg		[1:0]		imm_src,
	output	reg					reg_wrt
	);

//internal signals 
wire	[6:0]	op;
wire	[2:0]	funct3;
wire			funct7;
wire 	[9:0]	Decoder;
//value of these internal signals 
assign op = instr[6:0];
assign funct3 = instr[14:12];
assign funct7 = instr[30];
assign Decoder = {op,funct3}; // for the mux 

always @ (*)
	begin 
		//INTIALIZATION to avoid latches 
		pc_src=0;
		result_src=0;
		mem_wrt=0;
		alu_ctrl=0;
		alu_src=0;
		imm_src=0;
		reg_wrt=0;
		casex (Decoder)
		10'b0000011010	:	begin	// load word
							result_src =2'b01;
							alu_ctrl = 4'b0010;
							alu_src = 1;
							reg_wrt = 1;
							end
		10'b0010011000	:	begin	// addi 
							alu_ctrl = 4'b0010;
							alu_src = 1;
							reg_wrt = 1;
							end
		10'b0010011110	:	begin	// ori 
							alu_ctrl = 4'b0001;
							alu_src = 1;
							reg_wrt = 1;
							end
		10'b0010011111	:	begin	// andi 
							alu_ctrl = 4'b0000;
							alu_src = 1;
							reg_wrt = 1;
							end
		10'b0110011000	:	begin	// add & sub
							reg_wrt = 1;
							if (!funct7) // add
							alu_ctrl = 4'b0010; 
							else 		// sub
							alu_ctrl = 4'b0011;
							end
		10'b0110011110	:	begin	// or
							alu_ctrl = 4'b0001;
							reg_wrt = 1;
							end
		10'b0110011111	:	begin	// and
							alu_ctrl = 4'b0000;
							reg_wrt = 1;
							end
		10'b0110011010	:	begin	// set less than 
							alu_ctrl = 4'b0100;
							reg_wrt = 1;
							end
		10'b0100011010	:	begin	// store word
							mem_wrt = 1;
							alu_ctrl = 4'b0010;
							alu_src = 1;
							imm_src = 2'b01;
							end
		10'b1100011000	:	begin	// branch equal (bge)
							alu_ctrl = 4'b0011;
							imm_src = 2'b10;
							if (zero)
							pc_src = 2'b01;
							else 
							pc_src = 2'b00;
							end
		10'b1100011001	:	begin	// branch not equal (bne)
							alu_ctrl = 4'b0011;
							imm_src = 2'b10;
							if (!zero)
							pc_src = 2'b01;
							else 
							pc_src = 2'b00;
							end
		10'b1101111xxx	:	begin	// Jump and link	(jal)
							result_src = 2'b10;
							imm_src = 2'b11;
							pc_src = 2'b01;
							reg_wrt=1;
							end
		10'b1100111000	:	begin	// Jump and link register	(jalr)
							result_src = 2'b10;
							imm_src = 2'b00;
							alu_src	= 1;
							alu_ctrl = 4'b0010;
							pc_src = 2'b10;
							reg_wrt=1;
							end
		
		endcase
	end
endmodule 
		
							
								


