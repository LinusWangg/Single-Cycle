module pc(
	clk,
	adin,
	rst,
	adout
);
input wire clk,rst;
input wire[29:0] adin;
output reg[29:0] adout;
wire[31:0] temp = 32'h00003000;
initial begin
	adout=temp[31:2];
end

always@(posedge clk)
begin
	if(rst)
		adout=temp[31:2];
	else
		adout=adin;
end
endmodule
