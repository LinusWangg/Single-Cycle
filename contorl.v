`timescale 1ns / 1ps
module Control(
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

input wire[5:0] op;
input wire[5:0] func;
output reg regWr,regDst,Extop,alusrc,memWr,memtoreg,checkover,branch,jump;
output reg[4:0] aluop;

initial begin
	regWr = 0;
	regDst = 0;
	Extop = 0;
	alusrc = 0;
	memWr = 0;
	memtoreg = 0;
	branch = 0;
	jump = 0;
end

always@(op or func)
begin
	case(op)
		6'b001001: begin  //addi
			Extop = 1;
			regDst = 0;
			regWr = 1;
			alusrc = 1;
			memtoreg = 0;
			checkover = 1;
			memWr = 0;
			branch = 0;
			jump = 0;
			aluop = 5'b00000;// addu
			end
		6'b100011: begin  //load word
			Extop = 1;
			regDst = 0;
			regWr = 1;
			alusrc = 1;
			memtoreg = 1;
			checkover = 0;
			memWr = 0;
			branch = 0;
			jump = 0;
			aluop = 5'b00000;  //addu
			end
		6'b101011: begin  //store word
			Extop = 1;
			regDst = 0;  //have nothing to do with
			regWr = 0;
			alusrc = 1;
			memtoreg = 1;  //have nothing to do with
			memWr = 1;
			checkover = 0;
			branch = 0;
			jump = 0;
			aluop = 5'b00000;  //addu
			end
		6'b000100: begin  //beq
			Extop = 1;  //have nothing to do with
			regDst = 0;  //have nothing to do with
			regWr = 0;
			alusrc = 0;
			memtoreg = 1;  //have nothing to do with
			memWr = 0;
   			checkover = 0;
			branch = 1;
			jump = 0;
			aluop = 5'b00001;  //subu
			end
		6'b000101: begin  //bne
			Extop = 1;  //have nothing to do with
			regDst = 0;  //have nothing to do with
			regWr = 0;
			alusrc = 0;
			memtoreg = 1;  //have nothing to do with
			memWr = 0;
			checkover = 0;
			branch = 1;
			jump = 0;
			aluop = 5'b00001;  //subu
			end
		6'b000010: begin  //jump
			Extop = 1;  //have nothing to do with
			regDst = 0;  //have nothing to do with
			regWr = 0;
			alusrc = 0;  //have nothing to do with
			memtoreg = 1;  //have nothing to do with
			memWr = 0;
			checkover = 0;
			branch = 0;
			jump = 1;
			aluop = 5'b00001;  //have nothing to do with
			end
		6'b000011: begin  //jal
			Extop = 1;  //have nothing to do with
			regDst = 0;  //have nothing to do with
			regWr = 1;
			alusrc = 0;  //have nothing to do with
			memtoreg = 0;
			memWr = 0;
			checkover = 0;
			branch = 0;
			jump = 1;
			aluop = 5'b01010;  //jalr
			end
		6'b001111: begin  //lui
			Extop = 0;
			regDst = 0;
			regWr = 1;
			alusrc = 1;
			memtoreg = 0;
			memWr = 0;
			checkover = 0;
			branch = 0;
			jump = 0;
			aluop = 5'b10000;  //lui
			end
		6'b001010: begin  //slti
			Extop = 1;
			regDst = 0;
			regWr = 1;
			alusrc = 1;
			memtoreg = 0;
			memWr = 0;
			checkover = 0;
			branch = 0;
			jump = 0;
			aluop = 5'b00010;  //slti
			end
		6'b001011: begin  //sltiu
			Extop = 1;
			regDst = 0;
			regWr = 1;
			alusrc = 1;
			memtoreg = 0;
			memWr = 0;
			checkover = 0;
			branch = 0;
			jump = 0;
			aluop = 5'b01001;  //sltiu
			end
		6'b000001: begin  //bgez
			Extop = 0;  //have nothing to do with
			regDst = 0;  //have nothing to do with
			regWr = 0;
			alusrc = 0;
			memtoreg = 0;  //have nothing to do with
			memWr = 0;
			checkover = 0;
			branch = 1;
			jump = 0;
			aluop = 5'b00000;  //have nothing to do with
			end
		6'b000111: begin  //bgtz
			Extop = 0;  //have nothing to do with
			regDst = 0;  //have nothing to do with
			regWr = 0;
			alusrc = 0;
			memtoreg = 0;  //have nothing to do with
			memWr = 0;
			checkover = 0;
			branch = 1;
			jump = 0;
			aluop = 5'b00000;  //have nothing to do with
			end
		6'b000110: begin  //blez
			Extop = 0;  //have nothing to do with
			regDst = 0;  //have nothing to do with
			regWr = 0;
			alusrc = 0;
			memtoreg = 0;  //have nothing to do with
			memWr = 0;
			checkover = 0;
			branch = 1;
			jump = 0;
			aluop = 5'b00000;  //have nothing to do with
			end
		6'b000001: begin  //bltz
			Extop = 0;  //have nothing to do with
			regDst = 0;  //have nothing to do with
			regWr = 0;
			alusrc = 0;
			memtoreg = 0;  //have nothing to do with
			memWr = 0;
			checkover = 0;
			branch = 1;
			jump = 0;
			aluop = 5'b00000;  //have nothing to do with
			end
		6'b100000: begin  //lb
			Extop = 1;
			regDst = 0;
			alusrc = 1;
			memtoreg = 1;
			regWr = 1;
			memWr = 0;
			checkover = 0;
			branch = 0;
			jump = 0;
			aluop = 5'b00000;  //have nothing to do with
			end
		6'b100100: begin  //lbu
			Extop = 1;
			regDst = 0;
			alusrc = 1;
			memtoreg = 1;
			regWr = 1;
			memWr = 0;
			checkover = 0;
			branch = 0;
			jump = 0;
			aluop = 5'b00000;  //have nothing to do with
			end
		6'b101000: begin  //sb
			Extop = 1;
			regWr = 0;
			memWr = 1;
			alusrc = 1;
			memtoreg = 0;
			checkover = 0;
			branch = 1;
			jump = 0;
			aluop = 5'b00000;  //have nothing to do with
			end
		6'b001100: begin  //andi
			Extop = 0;
			regDst = 0;
			regWr = 1;
			alusrc = 1;
			memtoreg = 0;
			memWr = 0;
			checkover = 0;
			branch = 0;
			jump = 0;
			aluop = 5'b00011;  //and
			end
		6'b001101: begin  //ori
			Extop = 0;
			regDst = 0;
			regWr = 1;
			alusrc = 1;
			memtoreg = 0;
			memWr = 0;
			checkover = 0;
			branch = 0;
			jump = 0;
			aluop = 5'b00101;  //or
			end
		6'b001110: begin  //xori
			Extop = 0;
			regDst = 0;
			regWr = 1;
			alusrc = 1;
			memtoreg = 0;
			memWr = 0;
			checkover = 0;
			branch = 0;
			jump = 0;
			aluop = 5'b00110;  //xor
			end
		6'b000000: begin  //R-type
			case(func)
				6'b100000: begin  //add
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 1;
				branch = 0;
				jump = 0;
				aluop = 5'b00000;  // add
				end
				6'b100001: begin  //addu
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b00000;  // add
				end
				6'b100010: begin  //sub
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 1;
				branch = 0;
				jump = 0;
				aluop = 5'b00001;  // sub
				end
				6'b100011: begin  //subu
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b00001;  // sub
				end
				6'b101010: begin  //slt
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b00010;  // slt
				end
				6'b100100: begin  //and
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b00011;  // and
				end
				6'b100111: begin  //nor
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b00100;  // nor
				end
				6'b100101: begin  //or
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b00101;  //  or
				end
				6'b100110: begin  //xor
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b00110;  //  xor
				end
				6'b000000: begin  //sll
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b00111;  //sll
				end
				6'b000010: begin  //srl
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b01000;  //srl
				end
				6'b101011: begin  //sltu
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b01001;  //sltu
				end
				6'b001001: begin  //jalr
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b01010;  //jalr
				end
				6'b001000: begin  //jr
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 0;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b01011;  //jr
				end
				6'b000100: begin  //sllv
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b01100;  //sllv
				end
				6'b000011: begin  //sra
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b01101;  //sra
				end
				6'b000111: begin  //srav
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b01110;  //srav
				end
				6'b000110: begin  //srlv
				Extop = 1;  //have nothing to do with
				regDst = 1;
				regWr = 1;
				alusrc = 0;
				memtoreg = 0;
				memWr = 0;
				checkover = 0;
				branch = 0;
				jump = 0;
				aluop = 5'b01111;  //srlv
				end
			endcase
		end
	endcase
end
endmodule
					
			
			
		
	