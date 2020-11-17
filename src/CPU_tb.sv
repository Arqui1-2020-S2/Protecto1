`timescale 1 ps / 1 ps

module CPU_tb();
 integer f_img_out,f_data_out;

 logic CLK, RST;
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
							.button_i(),
							.data_o(data_mem_out_data), 
							.LEDs_o());
							
							

// RAM_test ram(
//	.address(data_mem_address[11:0]),
//	.clock(CLK_ng),
//	.data(data_mem_in_data),
//	.wren(data_mem_WE),
//	.q(data_mem_out_data));
	

	
	
	
	
	
	
	
	
	
	
	
	
// RAM_input_image ram_in0(
//	.address(data_mem_address[15:0]),
//	.clock(CLK_ng),
//	.data(data_mem_in_data[7:0]),
//	.wren(data_mem_WE),
//	.q());
//	
// RAM_input_image ram_in1(
//	.address(data_mem_address[15:0]),
//	.clock(CLK_ng),
//	.data(data_mem_in_data[7:0]),
//	.wren(data_mem_WE),
//	.q());
// RAM_input_image ram_in2(
//	.address(data_mem_address[15:0]),
//	.clock(CLK_ng),
//	.data(data_mem_in_data[7:0]),
//	.wren(data_mem_WE),
//	.q());
// RAM_input_image ram_out0(
//	.address(data_mem_address[15:0]),
//	.clock(CLK_ng),
//	.data(data_mem_in_data[7:0]),
//	.wren(data_mem_WE),
//	.q());
//	
// RAM_input_image ram_out1(
//	.address(data_mem_address[15:0]),
//	.clock(CLK_ng),
//	.data(data_mem_in_data[7:0]),
//	.wren(data_mem_WE),
//	.q());
//	
// RAM_input_image ram_out2(
//	.address(data_mem_address[15:0]),
//	.clock(CLK_ng),
//	.data(data_mem_in_data[7:0]),
//	.wren(data_mem_WE),
//	.q());
	
always #5 CLK=!CLK;





always @(posedge CLK) counter = counter+1;



always @(posedge CLK)
begin
	#1;
	if(data_mem_WE)
	begin
			$display("PC:inst_mem_address: %d, data_mem_address: %d, data_mem_in_data: %d", 
					  inst_mem_address,data_mem_address, data_mem_in_data);
			if(data_mem_address>=32'd262144)
			begin
				$display("Imagen Salida");
				pos=data_mem_address-32'd262144;
				$fwrite(f_img_out,"%d ",data_mem_in_data);
//				$fwrite(f_img_out,"%d : %d\n",pos ,data_mem_in_data  );

			end
			else if(data_mem_address<=32'd4095)
			begin
				$display("Datos");
				pos=data_mem_address;
				$fwrite(f_data_out,"%d : %d\n",pos ,data_mem_in_data  );
			end			
			
	end
end

//if(data_mem_WE)
//begin
//	
//end
////if(data_mem_WE)
////begin
////$display("data_mem_address: %d, data_mem_in_data: %d", 
////              data_mem_address, data_mem_in_data);
////end



//end


initial
begin
f_img_out = $fopen("IMG_OUT.txt","w");
f_data_out = $fopen("DATA_OUT.txt","w");

CLK=0;
#1;
RST=1;
wait(CLK == 1);
wait(CLK == 0);
RST=0;

//wait(inst_mem_address==187);
//$finish;
//$fclose(f);  
//$finish;


end





endmodule