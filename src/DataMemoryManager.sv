module DataMemoryManager(address_i, CLK, data_i, wren_i, data_o,wren,sel);
input logic [31:0] address_i, data_i;
input logic  CLK, wren_i;
output logic [31:0] data_o;

output logic [1:0] sel;
output logic [3:0] wren;
logic [31:0] data [3:0];


assign sel = address_i[17:16];


assign wren[0] = (sel==2'b00)? wren_i:0;
assign wren[1] = (sel==2'b01)? wren_i:0;
assign wren[2] = (sel==2'b10)? wren_i:0;
assign wren[3] = (sel==2'b11)? wren_i:0;
assign data_o = sel[1]? (sel[0]?data[3]:data[2]):(sel[0]?data[1]:data[0]);

DataMemSection datamem_0(
	.address(address_i[15:0]),
	.clock(CLK),
	.data(data_i),
	.wren(wren[0]),
	.q(data[0]));

DataMemSection datamem_1(
	.address(address_i[15:0]),
	.clock(CLK),
	.data(data_i),
	.wren(wren[1]),
	.q(data[1]));

DataMemSection datamem_2(
	.address(address_i[15:0]),
	.clock(CLK),
	.data(data_i),
	.wren(wren[2]),
	.q(data[2]));
endmodule









//module DataMem1 (
//	address,
//	clock,
//	data,
//	wren,
//	q);
//
//	input	[13:0]  address;
//	input	  clock;
//	input	[31:0]  data;
//	input	  wren;
//	output	[31:0]  q;