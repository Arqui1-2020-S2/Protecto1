module CustomMicro(CLK,RST, button_i, LEDs_o);

input logic CLK, RST,button_i;
output logic [7:0] LEDs_o;


logic [31:0] inst_mem_data,data_mem_out_data;
logic [31:0] data_mem_in_data,data_mem_address,inst_mem_address;
logic data_mem_WE;


logic CLK_ng;
assign CLK_ng=!CLK;
logic byte_mode=0;

int counter=0;


logic [31:0] pos =0;
CPU cpu (	
						.CLK(CLK),.RST(RST), 
						.inst_mem_data_i(inst_mem_data), 
						.inst_mem_address_o(inst_mem_address), 
						.data_mem_out_data_i(data_mem_out_data), 
						.data_mem_address_o(data_mem_address),
						.data_mem_in_data_o(data_mem_in_data), 
						.data_mem_WE_o(data_mem_WE));


Inst_ROM instROM (
						.address(inst_mem_address[11:0]),
						.clock(CLK_ng),
						.q(inst_mem_data));


DataMemoryManager    dataMemoryManager(	
						.address_i(data_mem_address), 
						.CLK(CLK), 
						.data_i(data_mem_in_data), 
						.wren_i(data_mem_WE),
						.button_i(button_i),
						.data_o(data_mem_out_data), 
						.LEDs_o(LEDs_o));

endmodule