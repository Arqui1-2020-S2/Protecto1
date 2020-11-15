`timescale 1 ps / 1 ps
module Stage_if_ROM_tb();


parameter N=32;
logic CLK, RST_pipe_if_id;
//logic [31:0] instruction_if,instruction_id;




logic RST_pc, WE_pc;
logic [31:0] instruction_if,instruction_id;
logic [31:0] pc_i,pc_o;
logic [31:0] Extend_ex;

logic [31:0] PC_1,PC_label;
logic pc_select;
logic zero=0;
logic [1:0] branchselect_id,branchselect_ex,ALU_flags_ex;

logic clear_pipes_o;
logic reset_int_mem;
logic CLK_ng;
assign CLK_ng=!CLK;


 Register #(.N(N)) PC (.CLK(CLK), .RST(RST_pc), .EN(WE_pc),
						   	.Data_In(pc_i),
							   .Data_Out(pc_o));
								
//Ram  #(.G(10), .mif_filename("mem_data/test_inst.txt") ) inst_mem (	
//							.address_i(pc_o), 
//							.CLK(CLK), 
//							.RST(reset_int_mem), 
//							.data_i(), 
//							.EN(zero), 
//							.data_o(instruction_if), 
//							.ByteMode_i(zero));


Inst_ROM instrction_ROM (
	.address(pc_o[11:0]),
	.clock(CLK_ng),
	.q(instruction_if));
								
PC_controller pc_controller(.branchselect_id_i(branchselect_id),.branchselect_ex_i(branchselect_ex), .ALU_flags_i(ALU_flags_ex),.pc_select_o(pc_select), .clear_pipes_o(clear_pipes_o));

Pipe_IF_ID #(.N(N))  pipe_IF_ID (.CLK(CLK), .RST(RST_pipe_if_id), .instruction_i(instruction_if), .instruction_o(instruction_id));


assign PC_1 = pc_o+1;
assign PC_label = pc_o+Extend_ex;

//mux pc
assign pc_i = (pc_select)? (PC_label):(PC_1);

always #5 CLK=!CLK;

initial 
begin
CLK=0;
//reset_int_mem=1;
//#20;
//reset_int_mem=0;
//#20;


branchselect_id 	= 2'b00;
branchselect_ex 	= 2'b00;
ALU_flags_ex    	= 2'b00;
Extend_ex			= 12;


wait(CLK == 1);
wait(CLK == 0);


WE_pc=1;
Extend_ex=12;

wait(CLK == 0);
assert (pc_o == 0) else $error("ERROR: address por leer:%0d",pc_o);
wait(CLK == 1);
assert (instruction_id == 0) else $error("ERROR: instruccion leida:%0d",instruction_id);



#1000 $finish;

end





endmodule