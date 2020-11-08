// Modelsim-ASE requires a timescale directive
`timescale 1 ps / 1 ps
module Stage_Mem_tb();
//Contiene:
//Pipe EX/MEM
//Pipe MEM/WB
//Memory manager


logic CLK_tb, CLK_neg;



logic CLK, RST_pipe_ex_mem,RST_pipe_mem_wb;
logic [31:0] RD2_ex, RD2_mem;
logic RF_WE_ex,RF_WE_mem, RF_WE_wb;
logic MemWE_ex, MemWE_mem, MemWE_wb;
logic WBSelect_ex,WBSelect_mem, WBSelect_wb;
logic [31:0] AluResult_ex, AluResult_mem, AluResult_wb;
logic [3:0] A3_ex, A3_mem, A3_wb;
logic [31:0] ReadData_mem, ReadData_wb;

logic [31:0] counter;

//Contiene:
//Pipe EX/MEM
//Pipe MEM/WB
//Memory manager

Pipe_EX_MEM  pipe_EX_MEM (.CLK(CLK), .RST(RST_pipe_ex_mem), 
									.RD2_i(RD2_ex),.RF_WE_i(RF_WE_ex), .MemWE_i(MemWE_ex),.WBSelect_i(WBSelect_ex), .AluResult_i(AluResult_ex), .A3_i(A3_ex),
									.RD2_o(RD2_mem),.RF_WE_o(RF_WE_mem), .MemWE_o(MemWE_mem),.WBSelect_o(WBSelect_mem), .AluResult_o(AluResult_mem), .A3_o(A3_mem));

Pipe_MEM_WB pipe_MEM_WB  (.CLK(CLK), .RST(RST_pipe_mem_wb), 
									.ReadData_i(ReadData_mem),.RF_WE_i(RF_WE_mem), .MemWE_i(MemWE_mem),.WBSelect_i(WBSelect_mem), .AluResult_i(AluResult_mem), .A3_i(A3_mem),
									.ReadData_o(ReadData_wb),.RF_WE_o(RF_WE_wb), .MemWE_o(MemWE_wb),.WBSelect_o(WBSelect_wb), .AluResult_o(AluResult_wb), .A3_o(A3_wb));

DataMemoryManager dataMemoryManager (.address_i(AluResult_mem), .CLK(CLK), 
								.data_i(RD2_mem), .wren_i(MemWE_mem), 
								.data_o(ReadData_mem));

								
assign CLK_neg=!CLK;
								
always #5 CLK_tb=!CLK_tb;


always@(posedge CLK_tb)
begin
if(counter<100)
	begin
	RD2_ex=counter;
	AluResult_ex=counter;
	MemWE_ex=1;
	end
else
	begin
	AluResult_ex=counter-100;
	RD2_ex=0;
	MemWE_ex=0;
	end

if(counter>200) 
begin
$finish;
end

#1 CLK = CLK_tb;
counter=counter+1;


end

always@(negedge CLK_tb)
begin
#1 CLK = CLK_tb;
end






initial 
begin
CLK_tb=1;
counter=0;
end








						
endmodule