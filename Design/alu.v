module alu /*#(parameter width=4)*/ (
	
	input		[31:0]		a,
	input		[31:0]		b,
	input		[3:0]		alu_ctrl,
	output	reg	[31:0]		alu_res,
	output					zero
	);

always @ (*)
	begin 
		case(alu_ctrl)
		4'b0000	:	alu_res = a&b;	//bitwise and
		4'b0001	:	alu_res = a|b;	//bitwise or
		4'b0010	:	alu_res = a+b;	//addition
		4'b0011	:	alu_res = a-b;	//subtraction
		4'b0100	:	begin 			//comparator
						if (a<b)
						alu_res = 32'b1;	
						else
						alu_res = 32'b0; 
					end
		4'b0101	:	alu_res = ~(a | b);	//nor
		default :	alu_res = 32'bx;
		endcase
	end 
	
	assign zero = (alu_res == 32'b0);
	
endmodule