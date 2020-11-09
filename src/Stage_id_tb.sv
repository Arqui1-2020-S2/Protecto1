module Stage_id_tb();
parameter N=32;
logic CLK, RST_pipe_if_id,RST_pipe_id_ex;
logic [31:0] instruction_if,instruction_id;
logic [31:0] RD1_if,RD1_id;
logic [31:0] RD2_if,RD2_id;
logic [31:0] Extend_id, Extend_ex;
logic [31:0]   wb_data_wb;

logic [31:0]   counter;



logic RF_WE_id,RF_WE_ex,RF_WE_wb;
logic [3:0] A3_id,A3_ex,A3_wb;
logic BranchSelect_id, BranchSelect_ex;
logic ALUOpBSelect_id, ALUOpBSelect_ex;
//logic[1:0] ExtendSelect, ALUControl
logic[1:0] ALUControl_id, ALUControl_ex;
logic SetFlags_id, SetFlags_ex;
logic MemWE_id, MemWE_ex;
logic WBSelect_id, WBSelect_ex;




logic[3:0] OpCode;
logic[1:0] ExtendSelect;
logic [3:0]   A1, A2;
logic [15:0]   imm;


//assign instruction_id[15:0]
assign OpCode = instruction_id[31:28];
assign A1 = instruction_id[27:24];
assign A2 = instruction_id[23:20];
assign A3_id = instruction_id[19:16];
assign imm = instruction_id[15:0];



Pipe_IF_ID #(.N(N))  pipe_IF_ID (.CLK(CLK), .RST(RST_pipe_if_id), .instruction_i(instruction_if), .instruction_o(instruction_id));


Pipe_ID_EX  #(.N(N)) pipe_ID_EX(.CLK(CLK), .RST(RST_pipe_id_ex), 
									.RD1_i(RD1_if), .RD2_i(RD2_if), .Extend_i(Extend_id), .RF_WE_i(RF_WE_id), 
									.A3_i(A3_id), .BranchSelect_i(BranchSelect_id), .ALUOpBSelect_i(ALUOpBSelect_id), .ALUControl_i(ALUControl_id),
									.SetFlags_i(SetFlags_id), .MemWE_i(MemWE_id),.WBSelect_i(WBSelect_id),
									
									.RD1_o(RD1_id), .RD2_o(RD2_id), .Extend_o(Extend_ex), .RF_WE_o(RF_WE_ex), 
									.A3_o(A3_ex), .BranchSelect_o(BranchSelect_ex), .ALUOpBSelect_o(ALUOpBSelect_ex), .ALUControl_o(ALUControl_ex),
									.SetFlags_o(SetFlags_ex), .MemWE_o(MemWE_ex),.WBSelect_o(WBSelect_ex));


//logic[1:0]  ImmSrc;
//logic[19:0] Instr
//logic[31:0] ExtImm				
//Extend extend (input  logic[1:0]  ImmSrc,
//				  input  logic[19:0] Instr,
//				  output logic[31:0] ExtImm);
				  
			
			

			
//RegisterFile #(N=32) registerFile (input  logic         clk, rst, WE3,
//									  input  logic [3:0]   A1, A2, A3,
//							        input  logic [N-1:0] WD3, R15,
//									  output logic [N-1:0] RD1, RD2);
RegisterFile #(.N(32)) registerFile (.clk(CLK), .rst(), .WE3(RF_WE_wb),
									    .A1(A1), .A2(A2), .A3(A3_wb),
							        .WD3(wb_data_wb), .R15(),
									  .RD1(RD1_if), .RD2(RD2_if));									
//s
		

		
// Control_Unit(input 	logic[3:0] OpCode,
//						  output logic BranchSelect, RegFileWE, ALUOpBSelect,
//										   SetFlags, MemWE, WBSelect,
//						  output logic[1:0] ExtendSelect, ALUControl);	


 Control_Unit  control_Unit(.OpCode(OpCode),
						 .BranchSelect(BranchSelect_id), .RegFileWE(RF_WE_id), .ALUOpBSelect(ALUOpBSelect_id),
										   .SetFlags(SETFlags_id), .MemWE(MEMWE_id), .WBSelect(WBSelect_id),
						  .ExtendSelect(ExtendSelect), .ALUControl(AluControl_if));	

								

always #5 CLK=!CLK;

initial 
begin
CLK=0;
//llenar register file
for(counter=0; counter<15; counter=counter+1)
begin
	wait(CLK == 1);
	#2;
	RF_WE_wb=1;
	A3_wb=counter[3:0];
	wb_data_wb=counter;
	wait(CLK == 0);
end
RF_WE_wb=0;
wb_data_wb=0;
A3_wb=0;

//leer registerfile

instruction_if[31:28]=0;	//OpCode
instruction_if[27:24]=0;	//A1
instruction_if[23:20]=0;	//A2
instruction_if[19:16]=0;	//A3_id
instruction_if[15:0]=0;	//imm


for(counter=0; counter<15; counter=counter+1)
begin
	wait(CLK == 0);
	#2;
	instruction_if[31:28]=0;	//OpCode
	instruction_if[27:24]=counter[3:0];	//A1
	instruction_if[23:20]=0;	//A2
	instruction_if[19:16]=0;	//A3_id
	instruction_if[15:0]=0;	//imm
	wait(CLK == 1);
	
	wait(CLK == 0);
	wait(CLK == 1);
	#1;
	assert (RD1_id == counter) else $error("ERROR: RD1_id:%0d, counter:%0d",RD1_id,counter);


end


for(counter=0; counter<15; counter=counter+1)
begin
	wait(CLK == 0);
	#2;
	instruction_if[31:28]=0;	//OpCode
	instruction_if[27:24]=0;	//A1
	instruction_if[23:20]=counter[3:0];	//A2
	instruction_if[19:16]=0;	//A3_id
	instruction_if[15:0]=0;	//imm
	
	wait(CLK == 1);
	
	wait(CLK == 0);
	wait(CLK == 1);
	#1;
	assert (RD2_id == counter) else $error("ERROR: RD2_id:%0d, counter:%0d",RD1_id,counter);

end



//probar suma de R1 con R2 y guardar en R3
wait(CLK == 0);
#1;
instruction_if[31:28]=4'b1000;	//OpCode
instruction_if[27:24]=1;	//A1
instruction_if[23:20]=2;	//A2
instruction_if[19:16]=3;	//A3_id
instruction_if[15:0]=0;	//imm

wait(CLK == 1);

wait(CLK == 0);
wait(CLK == 1);
#1;
assert (RD1_id == 			1) else $error("ERROR: suma RD1_id:%0d",RD1_id);
assert (RD2_id == 			2) else $error("ERROR: suma RD2_id:%0d",RD2_id);
assert (A3_ex == 				3) else $error("ERROR: suma A3_ex:%0d",A3_ex);
assert (ALUOpBSelect_ex == 0) else $error("ERROR: suma ALUOpBSelect_ex:%0d",ALUOpBSelect_ex);
assert (ALUControl_ex == 	0) else $error("ERROR: suma ALUControl_ex:%0d",ALUControl_ex);
assert (MemWE_ex == 			0) else $error("ERROR: suma MemWE_ex:%0d",MemWE_ex);
assert (RF_WE_ex == 			1) else $error("ERROR: suma RF_WE_ex:%0d",RF_WE_ex);
//assert (SetFlags_ex == 		0) else $error("ERROR: suma SetFlags_ex:%0d",SetFlags_ex);
//assert (WBSelect_ex == 		0) else $error("ERROR: suma WBSelect_ex:%0d",WBSelect_ex);
//assert (BranchSelect_id == 0) else $error("ERROR: suma BranchSelect_id:%0d",BranchSelect_id);
//assert (Extend_ex == 		0) else $error("ERROR: suma Extend_ex:%0d",Extend_ex);


$finish;
end							
	
endmodule
