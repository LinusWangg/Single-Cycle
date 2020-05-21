module npc(
	op,
	rt,
	func,
	DataA,
	immediate,
	branch,
	zero,
	jump,
	target,
	cur_pc,
	jal_pc,
	next_pc
);

input wire[5:0] op,func;
input wire[4:0] rt;
input wire[15:0] immediate;
input wire branch;
input wire jump;
input wire zero;  //zero-alu??????
input wire[25:0] target;
input wire[29:0] cur_pc;
input wire[29:0] jal_pc;
input wire[31:0] DataA;
output reg[29:0] next_pc;

reg [29:0] branch_next;
wire [29:0] new_immediate;
reg [29:0] jump_next;
initial begin
	next_pc = 30'd0;
end

always@(jump or immediate or zero or branch or target or cur_pc or jal_pc or op or func)
begin
	if(op == 6'b000000 && func == 6'b001001) //jalr
		next_pc = jal_pc;
	else if(op == 6'b000000 && func ==6'b001000)  //jr
		next_pc = jal_pc;
	else if(op == 6'b000101)  //bne
		next_pc = (branch&!zero)?cur_pc+{14'b0,immediate}:cur_pc+1;
	else if(op == 6'b000001)  //bgez blez
	begin
		if(rt == 1)  //bgez
			next_pc = (branch&&(DataA[31] == 0))?cur_pc+{14'b0,immediate}:cur_pc+1;
		else  //bltz
			next_pc = (branch&&(DataA[31] == 1))?cur_pc+{14'b0,immediate}:cur_pc+1;
	end
	else if(op == 6'b000111)  //bgtz
		next_pc = (branch&&(DataA != 32'b0 && DataA[31] == 0))?cur_pc+{14'b0,immediate}:cur_pc+1;
	else if(op == 6'b000110)  //blez
		next_pc = (branch&&(DataA == 32'b0 || DataA[31] == 1))?cur_pc+1+{14'b0,immediate}:cur_pc+1;
	else  //beq
	begin
		branch_next = (branch&zero)?cur_pc+{14'b0,immediate}:cur_pc+1;
		jump_next = (jump)?{cur_pc[29:26],target[25:0]}:branch_next;
		next_pc = jump_next;
	end
end

endmodule
