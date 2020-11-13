module CPU (CLK,RST, inst_mem_data_i, inst_mem_address_o, data_mem_out_data_i, data_mem_address_o,data_mem_in_data_o , data_mem_WE_o);
input logic CLK, RST;
input logic [31:0] inst_mem_data_i,data_mem_out_data_i;
output logic [31:0] data_mem_in_data_o,data_mem_address_o,inst_mem_address_o;
output logic data_mem_WE_o;


parameter N=32;

logic RST_pipe_if_id,RST_pipe_id_ex,RST_pipe_ex_mem,RST_pipe_mem_wb;


logic zero=0;
logic clear_pipes_o;

assign RST_pipe_if_id = RST;
assign RST_pipe_id_ex = RST||clear_pipes_o;
assign RST_pipe_ex_mem= RST;
assign RST_pipe_mem_wb= RST;
//FETCH
logic RST_pc;
logic WE_pc=1;
logic [31:0] instruction_if;
logic [31:0] pc_i,pc_o;
logic [31:0] PC_1,PC_label;
logic pc_select;
logic [31:0] RD1_if;
logic [31:0] RD2_if;

//DECODE
logic [31:0] instruction_id;
logic [31:0] RD1_id;
logic [31:0] RD2_id;
logic [31:0] Extend_id;
logic [1:0] BranchSelect_id;
logic RF_WE_id;
logic [3:0] A3_id;
logic ALUOpBSelect_id;
logic[1:0] ALUControl_id;
logic SetFlags_id;
logic MemWE_id;
logic WBSelect_id;


logic[3:0] OpCode;
logic[1:0] ExtendSelect;
logic [3:0]   A1, A2;
logic [19:0]   imm;


//EXECUTE
logic [31:0] ALUOpB;
logic [31:0] Extend_ex;
logic [1:0]  ALU_flags_ex;


logic RF_WE_ex;
logic [3:0] A3_ex;
logic BranchSelect_ex;
logic ALUOpBSelect_ex;
logic[1:0] ALUControl_ex;
logic SetFlags_ex;
logic MemWE_ex;
logic WBSelect_ex;

logic [31:0] AluResult_ex;



//MEM

logic [31:0] RD2_ex, RD2_mem;
logic RF_WE_mem;
logic MemWE_mem;
logic WBSelect_mem;
logic [31:0] AluResult_mem;
logic [3:0]  A3_mem;
logic [31:0] ReadData_mem;


//WriteBack
logic [31:0]   wb_data_wb;
logic RF_WE_wb;
logic MemWE_wb;
logic WBSelect_wb;
logic [31:0] AluResult_wb;
logic [3:0]  A3_wb;
logic [31:0] ReadData_wb;


//############################# FETCH ####################################
assign PC_1 = pc_o+1;
assign PC_label = pc_o+Extend_ex;
//mux pc
assign pc_i = (pc_select)? (PC_label):(PC_1);

PC_controller pc_controller(	
									.branchselect_id_i(BranchSelect_id),
									.branchselect_ex_i(BranchSelect_ex), 
									.ALU_flags_i(ALU_flags_ex),
									.pc_select_o(pc_select), 
									.clear_pipes_o(clear_pipes_o)
									);

 Register #(.N(N)) PC (
									.CLK(CLK), 
									.RST(RST_pc), 
									.EN(WE_pc),
									.Data_In(pc_i),
									.Data_Out(pc_o)
									);


assign instruction_if = inst_mem_data_i;
assign inst_mem_address_o = pc_o;
assign RST_pc= RST;


//############################# DECODE ####################################
//assign instruction_id[15:0]
assign OpCode = instruction_id[31:28];
assign A1 = instruction_id[27:24];
assign A2 = instruction_id[23:20];
assign A3_id = instruction_id[19:16];
assign imm = instruction_id[19:0];


Pipe_IF_ID #(.N(N))  pipe_IF_ID (
									.CLK(CLK), 
									.RST(RST_pipe_if_id), 
									.instruction_i(instruction_if), 
									.instruction_o(instruction_id)
									);
									

Extend extend(
									.Ext_sel_i(ExtendSelect), 
									.Imm_i(imm), 
									.Imm_ext_o(Extend_id)
									);

RegisterFile #(.N(32)) registerFile (
									.clk(CLK), 
									.rst(RST), 
									.WE3(RF_WE_wb),
									.A1(A1), 
									.A2(A2), 
									.A3(A3_wb),
							      .WD3(wb_data_wb), 
									.R15(),
									.RD1(RD1_id), 
									.RD2(RD2_id)
									);	

 Control_Unit  control_Unit(
									.OpCode(OpCode),
									.BranchSelect(BranchSelect_id), 
									.RegFileWE(RF_WE_id), 
									.ALUOpBSelect(ALUOpBSelect_id),
									.SetFlags(SetFlags_id), 
									.MemWE(MemWE_id), 
									.WBSelect(WBSelect_id),
									.ExtendSelect(ExtendSelect), 
									.ALUControl(ALUControl_id)
									);	

//############################# EXECUTE ####################################
Pipe_ID_EX  #(.N(N)) pipe_ID_EX(
									.CLK(CLK), 
									.RST(RST_pipe_id_ex), 
									.RD1_i(RD1_id), 
									.RD2_i(RD2_id), 
									.Extend_i(Extend_id), 
									.RF_WE_i(RF_WE_id), 
									.A3_i(A3_id), 
									.BranchSelect_i(BranchSelect_id), 
									.ALUOpBSelect_i(ALUOpBSelect_id), 
									.ALUControl_i(ALUControl_id),
									.SetFlags_i(SetFlags_id), 
									.MemWE_i(MemWE_id),
									.WBSelect_i(WBSelect_id),
									
									.RD1_o(RD1_ex), 
									.RD2_o(RD2_ex), 
									.Extend_o(Extend_ex), 
									.RF_WE_o(RF_WE_ex), 
									.A3_o(A3_ex),
									.BranchSelect_o(BranchSelect_ex), 
									.ALUOpBSelect_o(ALUOpBSelect_ex), 
									.ALUControl_o(ALUControl_ex),
									.SetFlags_o(SetFlags_ex), 
									.MemWE_o(MemWE_ex),
									.WBSelect_o(WBSelect_ex)
									);

assign ALUOpB = (ALUOpBSelect_ex)? (Extend_ex):(RD1_id);

ALU #(N) alu (
									.A(RD1_id),
									.B(ALUOpB),
									.ALUControl(ALUControl_ex),
									.ALUResult(AluResult_ex),
									.ALUFlags(ALU_flags_ex));


//############################# MEM ####################################

Pipe_EX_MEM  pipe_EX_MEM (.CLK(CLK), .RST(RST_pipe_ex_mem), 
									.RD2_i(RD2_ex),
									.RF_WE_i(RF_WE_ex), 
									.MemWE_i(MemWE_ex),
									.WBSelect_i(WBSelect_ex), 
									.AluResult_i(AluResult_ex), 
									.A3_i(A3_ex),
									.RD2_o(RD2_mem),
									.RF_WE_o(RF_WE_mem), 
									.MemWE_o(MemWE_mem),
									.WBSelect_o(WBSelect_mem), 
									.AluResult_o(AluResult_mem), 
									.A3_o(A3_mem));
									
									
assign ReadData_mem = data_mem_out_data_i;
assign data_mem_address_o = AluResult_mem;
assign data_mem_WE_o = MemWE_mem;
assign data_mem_in_data_o = RD2_mem;

//DataMemoryManager dataMemoryManager (.address_i(AluResult_mem), .CLK(CLK), 
//								.data_i(RD2_mem), .wren_i(MemWE_mem), 
//								.data_o(ReadData_mem),.byte_mode_i(byte_mode_i));


//############################# WriteBack ####################################

Pipe_MEM_WB pipe_MEM_WB  (
									.CLK(CLK), 
									.RST(RST_pipe_mem_wb), 
									.ReadData_i(ReadData_mem),
									.RF_WE_i(RF_WE_mem), 
									.MemWE_i(MemWE_mem),
									.WBSelect_i(WBSelect_mem), 
									.AluResult_i(AluResult_mem), 
									.A3_i(A3_mem),
									.ReadData_o(ReadData_wb),
									.RF_WE_o(RF_WE_wb), 
									.MemWE_o(MemWE_wb),
									.WBSelect_o(WBSelect_wb), 
									.AluResult_o(AluResult_wb), 
									.A3_o(A3_wb)
									);

 assign wb_data_wb = WBSelect_wb ? AluResult_wb : ReadData_wb;







endmodule