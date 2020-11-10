module Stage_if_tb();


parameter N=32;
logic CLK, RST_pipe_if_id;
//logic [31:0] instruction_if,instruction_id;


Pipe_IF_ID #(.N(N))  pipe_IF_ID (.CLK(CLK), .RST(RST_pipe_if_id), .instruction_i(instruction_if), .instruction_o(instruction_id));


logic RST_pc, WE_pc;
logic [31:0] instruction_if,instruction_id;
logic [31:0] pc_i,pc_o;
logic [31:0] Extend_ex;

logic [31:0] PC_4;
logic [31:0] pc_select;
logic zero=0;

 Register #(.N(N)) PC (.CLK(CLK), .RST(RST_pc), .EN(WE_pc),
						   	.Data_In(pc_i),
							   .Data_Out(pc_o));
								
Ram  #(.G(18), .mif_filename("mem_data/test_inst.txt")) inst_mem (	
							.address_i(pc_o), 
							.CLK(CLK), 
							.RST(), 
							.data_i(), 
							.EN(zero), 
							.data_o(instruction_if), 
							.ByteMode_i(zero));
								
								
								

assign PC_4 = pc_o+4;

//mux pc
assign pc_i = (pc_select)? (Extend_ex):(PC_4);


always #5 CLK=!CLK;

initial 
begin
CLK=0;
RST_pc=1;
wait(CLK == 1);
wait(CLK == 0);
#1 RST_pc=0;

wait(CLK == 1);



WE_pc=1;
Extend_ex=12;

wait(CLK == 0);
assert (pc_o == 0) else $error("ERROR: address por leer:%0d",pc_o);
wait(CLK == 1);
assert (instruction_id == 0) else $error("ERROR: instruccion leida:%0d",instruction_id);





end





endmodule