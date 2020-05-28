module mips(
	clk,
	rst
);

input wire clk,rst;

wire[31:0] ir;

wire regWr,regDst,Extop,alusrc,memWr,memtoreg,checkover,overflow,branch,jump,zero;
wire[4:0] aluop;
wire[4:0] rs,rt,rd,shamt;
wire[5:0] op,func;
wire[15:0] imm16;
wire[31:0] imm32,busA,busB,busW,DataIn,DataOut,result,DataA,DataB;
wire[25:0] target;

wire[29:0] cur_pc,next_pc,jalpc;
pc pc_1(
	clk,
	next_pc,
	rst,
	cur_pc
);

im_4k im_4k_1(
	cur_pc[9:0],
	ir
);

decoder decoder_1(
	ir,
	op,
	rs,
	rt,
	rd,
	shamt,
	func,
	imm16,
	target
);

Control control_1(
	op,
	func,
	regWr,
	regDst,
	Extop,
	alusrc,
	aluop,
	memWr,
	memtoreg,
	checkover,
	branch,
	jump
);

npc npc_1(
	op,
	rt,
	func,
	busA,
	imm16,
	branch,
	zero,
	jump,
	target,
	cur_pc,
	jalpc,
	next_pc
);

regfile regfile_1(
	clk,
	rs,
	rt,
	rd,
	op,
	func,
	cur_pc,
	result[11:0],  //Addr
	regWr,
	regDst,
	busW,
	busA,
	busB,
	jalpc
);

SignExt SignExt_1(
	imm16,
	Extop,
	imm32
);

mux_Extend mux_Extend_1(
	busB,
	imm32,
	alusrc,
	DataB
);


alu alu_1(
	cur_pc,
	checkover,
	aluop,
	shamt,
	busA,
	DataB,
	zero,
	overflow,
	result
);

dm_4k dm_4k_1(
	clk,
	op,
	memWr,
	result[11:0],
	busB,
	DataOut
);

mux_memtoreg mux_memtoreg_1(
	result,
	DataOut,
	memtoreg,
	busW
);
reg[31:0] pc;
always@(ir) begin
	pc[31:2] = cur_pc;
	pc[1:0] = 2'b00;
	$display("%h",{cur_pc,2'b00});
	$display("%h",ir);
end

endmodule
