module regfile(
	clk,
	rs,
	rt,
	rd,
	op,
	func,
	pc,
	addr,
	regWe,
	regDst,
	busW,
	busA,
	busB,
	jalpc
);

input wire clk,regWe,regDst;
input wire[4:0] rs,rt,rd;
input wire[5:0] op,func;
input wire[11:0] addr;
input wire[29:0] pc;
input wire[31:0] busW;
output reg[31:0] busA,busB;
output reg[29:0] jalpc;

reg [31:0]registers[31:0];
integer i;
initial begin
	for(i=0;i<32;i=i+1)
		registers[i]=0;
end

always@(*) begin
	busA = registers[rs];
	busB = registers[rt];
	jalpc = registers[rs][31:2];
end

always@(posedge clk) begin
	if(regWe)
		case(op)
		6'b100000:  //lb
		begin
		if(addr[1:0] == 2'b00 && regDst == 0)
			registers[rt] = {{24{busW[7]}},busW[7:0]};
		else if(addr[1:0] == 2'b01 && regDst == 0)
			registers[rt] = {{24{busW[15]}},busW[15:8]};
		else if(addr[1:0] == 2'b10 && regDst == 0)
			registers[rt] = {{24{busW[23]}},busW[23:16]};
		else if(addr[1:0] == 2'b11 && regDst == 0)
			registers[rt] = {{24{busW[31]}},busW[31:24]};
		else if(addr[1:0] == 2'b00 && regDst == 1)
			registers[rd] = {{24{busW[7]}},busW[7:0]};
		else if(addr[1:0] == 2'b01 && regDst == 1)
			registers[rd] = {{24{busW[15]}},busW[15:8]};
		else if(addr[1:0] == 2'b10 && regDst == 1)
			registers[rd] = {{24{busW[23]}},busW[23:16]};
		else if(addr[1:0] == 2'b11 && regDst == 1)
			registers[rd] = {{24{busW[31]}},busW[31:24]};
		end
		6'b100100:  //lbu
		begin
		if(addr[1:0] == 2'b00 && regDst == 0)
			registers[rt] = {{24'b0},busW[7:0]};
		else if(addr[1:0] == 2'b01 && regDst == 0)
			registers[rt] = {{24'b0},busW[15:8]};
		else if(addr[1:0] == 2'b10 && regDst == 0)
			registers[rt] = {{24'b0},busW[23:16]};
		else if(addr[1:0] == 2'b11 && regDst == 0)
			registers[rt] = {{24'b0},busW[31:24]};
		else if(addr[1:0] == 2'b00 && regDst == 1)
			registers[rd] = {{24'b0},busW[7:0]};
		else if(addr[1:0] == 2'b01 && regDst == 1)
			registers[rd] = {{24'b0},busW[15:8]};
		else if(addr[1:0] == 2'b10 && regDst == 1)
			registers[rd] = {{24'b0},busW[23:16]};
		else if(addr[1:0] == 2'b11 && regDst == 1)
			registers[rd] = {{24'b0},busW[31:24]};
		end
		6'b000011:  //jal
		begin
			registers[31] = pc+1;
		end
		default:  //lw
		begin
		if(regDst == 0)
			registers[rt] = busW;
		else if(regDst == 1)
			registers[rd] = busW;
		end
		endcase
end

endmodule
