module instr_mem(
	input		[29:0]		pc,//PC as an address for instruction memory is incremented 4 bytes for each instruction
	output		[31:0]		instr//instruction
	);

reg [31:0] Imem [0:255]; //instruction memory array of 32 bits width and 256 words (put whatever you want)

initial begin
    $readmemh("riscv.mem", Imem);
end

assign instr = Imem[pc];
endmodule 