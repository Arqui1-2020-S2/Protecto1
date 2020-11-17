`timescale 1 ps / 1 ps
module DataMemoryManager(address_i, CLK, data_i, wren_i, data_o, LEDs_o );
input logic [31:0] address_i, data_i;
input logic  CLK, wren_i;
output logic [31:0] data_o;
output logic [7:0] LEDs_o;


logic [1:0] sel;
logic [7:0] wren;
logic [31:0] data_general;
logic [7:0] data_image [5:0];

logic RST=0;

//assign sel = address_i[18:16];


assign wren[0] = (sel==3'b000)? wren_i:0;
assign wren[1] = (sel==3'b001)? wren_i:0;
assign wren[2] = (sel==3'b010)? wren_i:0;
assign wren[3] = (sel==3'b011)? wren_i:0;
assign wren[4] = (sel==3'b100)? wren_i:0;
assign wren[5] = (sel==3'b101)? wren_i:0;
assign wren[6] = (sel==3'b110)? wren_i:0;
assign wren[7] = (sel==3'b111)? wren_i:0;
//assign data_o = sel[1]? (sel[0]?data[3]:data[2]):(sel[0]?data[1]:data[0]);
//{24'b0, data_image[0]}




 RAM_test ram(
	.address(address_i[11:0]),
	.clock(CLK),
	.data(data_i),
	.wren(wren[0]),
	.q(data_general));
	
 RAM_input_0 ram_in0(
	.address(address_i[15:0]),
	.clock(CLK),
	.data(data_i[7:0]),
	.wren(wren[1]),
	.q(data_image[0]));
	
 RAM_input_1 ram_in1(
	.address(address_i[15:0]),
	.clock(CLK),
	.data(data_i[7:0]),
	.wren(wren[2]),
	.q(data_image[1]));
	
 RAM_input_2 ram_in2(
	.address(address_i[15:0]),
	.clock(CLK),
	.data(data_i[7:0]),
	.wren(wren[3]),
	.q(data_image[2]));
	
 RAM_input_image ram_out0(
	.address(address_i[15:0]),
	.clock(CLK),
	.data(data_i[7:0]),
	.wren(wren[4]),
	.q(data_image[3]));
	
 RAM_input_image ram_out1(
	.address(address_i[15:0]),
	.clock(CLK),
	.data(data_i[7:0]),
	.wren(wren[5]),
	.q(data_image[4]));
	
 RAM_input_image ram_out2(
	.address(address_i[15:0]),
	.clock(CLK),
	.data(data_i[7:0]),
	.wren(wren[6]),
	.q(data_image[5]));

	
	
	
assign sel = address_i[18:16];
always_comb begin
	case(sel)
		3'b000: data_o = data_general;//data
		3'b001: data_o = {24'b0, data_image[0]};//imagen entrada
		3'b010: data_o = {24'b0, data_image[1]};
		3'b011: data_o = {24'b0, data_image[2]};
		3'b100: data_o = {24'b0, data_image[3]};//imagen salida
		3'b101: data_o = {24'b0, data_image[4]};
		3'b110: data_o = {24'b0, data_image[5]};
		3'b111: data_o = {32'b0};//botones
		default: data_o = 0;
	endcase
end	
	
endmodule





