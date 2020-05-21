module mux_Extend(busB,imm32,alusrc,DataB);
	input wire alusrc;
	input wire[31:0] busB,imm32;
	output wire[31:0] DataB;

	assign DataB=(alusrc==0)?busB:imm32;
endmodule
