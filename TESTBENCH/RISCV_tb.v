module RISCV_tb();
reg clk_tb,rst_tb;

initial 
	begin 
		clk_tb=0;
		rst_tb=0;
		#3
		
		#7
		rst_tb=1;
		#500
		$finish;
	end


always #5 clk_tb=!clk_tb;

RISCV DUT(
.clk(clk_tb),
.rst(rst_tb)
);

endmodule
