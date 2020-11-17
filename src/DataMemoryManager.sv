`timescale 1 ps / 1 ps
module DataMemoryManager(address_i, CLK, data_i, wren_i,button_i, data_o, LEDs_o );
input logic [31:0] address_i, data_i;
input logic  CLK, wren_i,button_i;
output logic [31:0] data_o;
output logic [7:0] LEDs_o;


logic [2:0] sel;
logic [7:0] wren;
logic [31:0] data_general,data_periferials;
logic [7:0] data_image [5:0];
logic RST=0;
logic CLK_ng;
assign CLK_ng=!CLK;

assign sel = address_i[18:16];


assign wren[0] = (sel==3'b000)? wren_i:0;
assign wren[1] = (sel==3'b001)? wren_i:0;
assign wren[2] = (sel==3'b010)? wren_i:0;
assign wren[3] = (sel==3'b011)? wren_i:0;
assign wren[4] = (sel==3'b100)? wren_i:0;
assign wren[5] = (sel==3'b101)? wren_i:0;
assign wren[6] = (sel==3'b110)? wren_i:0;
//assign wren[7] = (sel==3'b111)? wren_i:0;

assign wren[7] = (sel==3'b111 && address_i[15:0]==0)? wren_i:0;

//assign data_o = sel[1]? (sel[0]?data[3]:data[2]):(sel[0]?data[1]:data[0]);
//{24'b0, data_image[0]}



//data general 4098 32bits
 RAM_test ram(
	.address(address_i[11:0]),
	.clock(CLK_ng),
	.data(data_i),
	.wren(wren[0]),
	.q(data_general));
//imagen entrada 400*400 8bits
 RAM_input_0 ram_in0(
	.address(address_i[15:0]),
	.clock(CLK_ng),
	.data(data_i[7:0]),
	.wren(wren[1]),
	.q(data_image[0]));
	
 RAM_input_1 ram_in1(
	.address(address_i[15:0]),
	.clock(CLK_ng),
	.data(data_i[7:0]),
	.wren(wren[2]),
	.q(data_image[1]));
	
// RAM_input_2 ram_in2(
//	.address(address_i[15:0]),
//	.clock(CLK_ng),
//	.data(data_i[7:0]),
//	.wren(wren[3]),
//	.q(data_image[2]));

 RAM_input_2_h ram_in2_h(
	.address(address_i[14:0]),
	.clock(CLK_ng),
	.data(data_i[7:0]),
	.wren(wren[3]),
	.q(data_image[2]));
	
	
//imagen salida 400*400 8bits
 RAM_input_image ram_out0(
	.address(address_i[15:0]),
	.clock(CLK_ng),
	.data(data_i[7:0]),
	.wren(wren[4]),
	.q(data_image[3]));
	
 RAM_input_image ram_out1(
	.address(address_i[15:0]),
	.clock(CLK_ng),
	.data(data_i[7:0]),
	.wren(wren[5]),
	.q(data_image[4]));

// RAM_input_image ram_out2(
//	.address(address_i[15:0]),
//	.clock(CLK_ng),
//	.data(data_i[7:0]),
//	.wren(wren[6]),
//	.q(data_image[5]));
	
 RAM_half ram_out_h(
	.address(address_i[14:0]),
	.clock(CLK_ng),
	.data(data_i[7:0]),
	.wren(wren[6]),
	.q(data_image[5]));
	
	

 Register #(.N(8)) LEDS (
									.CLK(CLK), 
									.RST(RST), 
									.EN(wren[7]),
									.Data_In(data_i[7:0]),
									.Data_Out(LEDs_o)
									);
	



assign data_periferials = (address_i[0])? ({31'b0, button_i}):({24'b0, LEDs_o});

always_comb begin
	case(sel)
		3'b000: data_o = data_general;//data
		3'b001: data_o = {24'b0, data_image[0]};//imagen entrada
		3'b010: data_o = {24'b0, data_image[1]};
		3'b011: data_o = {24'b0, data_image[2]};
		3'b100: data_o = {24'b0, data_image[3]};//imagen salida
		3'b101: data_o = {24'b0, data_image[4]};
		3'b110: data_o = {24'b0, data_image[5]};
		3'b111: data_o = data_periferials;//botones
		default: data_o = 0;
	endcase
end	
	
endmodule





