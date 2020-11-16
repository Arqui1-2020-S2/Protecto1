


//---------------------------- This module is under development check first-----------------------------
`timescale 1 ps / 1 ps


module DataMemoryManagerGeneric  #(N = 2)(address_i, CLK, data_i, wren_i,byte_mode_i, data_o );
input logic [31:0] address_i, data_i,byte_mode_i;
input logic  CLK, wren_i;
output logic [31:0] data_o;

logic [1:0] sel;
logic [15:0] wren;
logic [31:0] data [15:0];
logic RST=0;

assign sel = address_i[21:18]; //at least four bits


assign wren[0] = (sel==4'b0000)? wren_i:0;
assign wren[1] = (sel==4'b0001)? wren_i:0;
assign wren[2] = (sel==4'b0010)? wren_i:0;
assign wren[3] = (sel==4'b0011)? wren_i:0;

assign wren[4] = (sel==4'b0100)? wren_i:0;
assign wren[5] = (sel==4'b0101)? wren_i:0;
assign wren[6] = (sel==4'b0110)? wren_i:0;
assign wren[7] = (sel==4'b0111)? wren_i:0;

assign wren[8] = (sel==4'b1000)? wren_i:0;
assign wren[9] =  (sel==4'b1001)? wren_i:0;
assign wren[10] = (sel==4'b1010)? wren_i:0;
assign wren[11] = (sel==4'b1011)? wren_i:0;

assign wren[12] = (sel==4'b1100)? wren_i:0;
assign wren[13] = (sel==4'b1101)? wren_i:0;
assign wren[14] = (sel==4'b1110)? wren_i:0;
assign wren[15] = (sel==4'b1111)? wren_i:0;

//module Mux_16 #(N=4)(input  [3:0]   S,
//							input  [N-1:0] D00, D01, D02, D03, D04, D05, D06, D07,
//							input  [N-1:0] D08, D09, D10, D11, D12, D13, D14, D15,
//							output [N-1:0] Y);

genvar i;
generate 
	for (i = 0; i < N; i = i+1) begin:forloop
		TEST_RAM mem0(
		.address(address_i[15:0]),
		.clock(CLK),
		.data(data_i[15:0]),
		.wren(wren[i]),
		.q(data[i]));
	end
endgenerate				
Mux_16 #(32)(.S(sel),
	.D00(data[0]),
	.D01(data[1]),
	.D02(data[2]),
	.D03(data[3]),
	.D04(data[4]),
	.D05(data[5]),
	.D06(data[6]),
	.D07(data[7]),
	.D08(data[8]),
	.D09(data[9]),
	.D10(data[10]),
	.D11(data[11]),
	.D12(data[12]),
	.D13(data[13]),
	.D14(data[14]),
	.D15(data[15]),
	.Y(data_o));
endmodule





