import code_pack ::*;

module atb_top_level ();

logic clk=0, start=0;
wire done;

always begin
	#5ns clk=1;
	#5ns clk=0;
end

initial begin
	#300ns $stop;
end

top_level cpu(.*);

int pc = 0;

initial begin
	cpu.im.core[ pc] = {movl, l};
	 pc++;
	cpu.im.core[ pc] = {litl, 4'b1100};
	 pc++;
	cpu.im.core[ pc] = {lith, 4'b0011};
	 pc++;
	cpu.im.core[ pc] = {movx, l};
	 pc++;
	cpu.im.core[ pc] = {movl, l};
	 pc++;
	cpu.im.core[ pc] = {litl, 4'b0010};
	 pc++;
	cpu.im.core[ pc] = {movy, l};
	 pc++;
	cpu.im.core[ pc] = {mthr, ror};
	 pc++;
	cpu.im.core[ pc] = {mova, a};
	 pc++;
	cpu.im.core[ pc] = {stor, sa, r[2:0]};	//10 : mem[0] = 8'b00001111
	 pc++;
	cpu.im.core[ pc] = {incr, a};
	 pc++;
	cpu.im.core[ pc] = {movy, r};
	 pc++;
	cpu.im.core[ pc]	= {mths, amp};
	 pc++;
	cpu.im.core[ pc]	= {stor, sa, s[2:0]};	//14 : mem[1] = 8'b00001100
	 pc++;
	cpu.im.core[ pc] = {incr, a};
	 pc++;
	cpu.im.core[ pc] = {movx, x};
	 pc++;
	cpu.im.core[ pc] = {mths, amp};
	 pc++;
	cpu.im.core[ pc] = {movd, d};
	 pc++;
	cpu.im.core[ pc] = {jizr, ss, 3'b010};	// jump pc+4
	 pc++;
		cpu.im.core[ pc] = {litl, 4'b1111};
		 pc++;
		cpu.im.core[ pc] = {lith, 4'b1111};
		 pc++;
		cpu.im.core[ pc] = {movd, l};
		 pc++;
	cpu.im.core[ pc] = {stor, sa, d[2:0]};	//23 : mem[2] = 8'b00000000
	 pc++;
	cpu.im.core[ pc] = {incr, a};
	 pc++;
	cpu.im.core[ pc] = {func, done};
end

endmodule