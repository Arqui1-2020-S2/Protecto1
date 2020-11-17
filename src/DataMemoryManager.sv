module DataMemoryManager(address_i, CLK, data_i, wren_i,byte_mode_i, data_o, LEDs_o );
input logic [31:0] address_i, data_i,byte_mode_i;
input logic  CLK, wren_i;
output logic [31:0] data_o;
logic [7:0] LEDs_o;


logic [1:0] sel;
logic [3:0] wren;
logic [31:0] data_general;
logic [7:0] data_image [5:0];

logic RST=0;

assign sel = address_i[18:16];


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
	.address(data_mem_address[11:0]),
	.clock(CLK_ng),
	.data(data_mem_in_data),
	.wren(wren[0]),
	.q(data_general));
	
 RAM_input_image ram_in0(
	.address(data_mem_address[15:0]),
	.clock(CLK_ng),
	.data(data_image[0]),
	.wren(wren[1]),
	.q(data_image[0]));
	
 RAM_input_image ram_in1(
	.address(data_mem_address[15:0]),
	.clock(CLK_ng),
	.data(data_image[0]),
	.wren(wren[2]),
	.q(data_image[0]));
 RAM_input_image ram_in2(
	.address(data_mem_address[15:0]),
	.clock(CLK_ng),
	.data(data_image[0]),
	.wren(wren[3]),
	.q(data_image[0]));
 RAM_input_image ram_out0(
	.address(data_mem_address[15:0]),
	.clock(CLK_ng),
	.data(data_image[0]),
	.wren(wren[4]),
	.q(data_image[0]));
	
 RAM_input_image ram_out1(
	.address(data_mem_address[15:0]),
	.clock(CLK_ng),
	.data(),
	.wren(wren[5]),
	.q(data_image[0]));
	
 RAM_input_image ram_out2(
	.address(data_mem_address[15:0]),
	.clock(CLK_ng),
	.data(data_image[0]),
	.wren(wren[6]),
	.q(data_image[0]));

	
	
	
assign sel = address_i[18:16];
always_comb begin
	case(sel)
		3'b000: out = data_general;//data
		3'b001: out = {24'b0, data_image[0]};//imagen entrada
		3'b010: out = {24'b0, data_image[1]};
		3'b011: out = {24'b0, data_image[2]};
		3'b100: out = {24'b0, data_image[3]};//imagen salida
		3'b101: out = {24'b0, data_image[4]};
		3'b110: out = {24'b0, data_image[5]};
		3'b111: out = {32'b0};//botones
		default: out = 0;
	endcase
end	
	
	

//DataMemSection datamem_0(
//	.address(address_i[15:0]),
//	.clock(CLK),
//	.data(data_i),
//	.wren(wren[0]),
//	.q(data[0]));
//
//DataMemSection datamem_1(
//	.address(address_i[15:0]),
//	.clock(CLK),
//	.data(data_i),
//	.wren(wren[1]),
//	.q(data[1]));
//
//DataMemSection datamem_2(
//	.address(address_i[15:0]),
//	.clock(CLK),
//	.data(data_i),
//	.wren(wren[2]),
//	.q(data[2]));
//	
//	
	
endmodule





