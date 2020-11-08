module Pipe_MEM_WB  #(N=32) (CLK, RST, 
									ReadData_i,RF_WE_i, MemWE_i,WBSelect_i, AluResult_i, A3_i,
									ReadData_o,RF_WE_o, MemWE_o,WBSelect_o, AluResult_o, A3_o);


input logic CLK, RST;
input logic [N-1:0] ReadData_i,AluResult_i;
input logic MemWE_i,WBSelect_i,RF_WE_i;
input logic [3:0] A3_i;


//logic [N-1:0] ReadData,AluResult ;
//logic MemWE,WBSelect,RF_WE;
//logic [3:0] A3;


output logic [N-1:0] ReadData_o,AluResult_o ;
output logic MemWE_o,WBSelect_o,RF_WE_o;
output logic [3:0] A3_o;

	
	always @(posedge CLK) 
	if      (RST) 
		begin
			AluResult_o <= 0;
			ReadData_o <= 0;
			RF_WE_o <= 0;
			MemWE_o <= 0;
			WBSelect_o <= 0;
			A3_o <= 0;
		end
		
	else
	begin
		ReadData_o <= ReadData_i;
		RF_WE_o <= RF_WE_i;
		MemWE_o <= MemWE_i;
		WBSelect_o <= WBSelect_i;
		A3_o <= A3_i;
		AluResult_o <= AluResult_i;
	end
	
	endmodule