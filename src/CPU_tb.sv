`timescale 1 ps / 1 ps

module CPU_tb();


 logic CLK, RST;
 logic [31:0] inst_mem_data,data_mem_out_data;
 logic [31:0] data_mem_in_data,data_mem_address,inst_mem_address;
 logic data_mem_WE;
 
 
 logic CLK_ng;
 assign CLK_ng=!CLK;
 logic byte_mode=0;

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


Ram  #(.G(10),.mif_filename("mem_data/in_ram.txt")) dataMem (	
							.address_i(data_mem_address[9:0]), 
							.CLK(CLK), 
							.RST(RST), 
							.data_i(data_mem_in_data), 
							.EN(data_mem_WE), 
							.data_o(data_mem_out_data), 
							.ByteMode_i(byte_mode));


always #5 CLK=!CLK;

initial
begin
CLK=0;
#1;
RST=1;
wait(CLK == 1);
wait(CLK == 0);
RST=0;

#1000 $finish;



end


endmodule