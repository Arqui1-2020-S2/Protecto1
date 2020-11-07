module Pipe_MEM_WB  #(N=32) (CLK, RST, 
									ReadData_i,RF_WE_i, MemWE_i,WBSelect_i, AluResult_i, A3_i,
									ReadData_o,RF_WE_o, MemWE_o,WBSelect_o, AluResult_o, A3_o);


input logic CLK, RST;
input logic [N-1:0] ReadData_i,AluResult_i;
input logic MemWE_i,WBSelect_i,RF_WE_i;
input logic [3:0] A3_i;


logic [N-1:0] ReadData,AluResult ;
logic MemWE,WBSelect,RF_WE;
logic [3:0] A3;


output logic [N-1:0] ReadData_o,AluResult_o ;
output logic MemWE_o,WBSelect_o,RF_WE_o;
output logic [3:0] A3_o;


	always @(negedge CLK) begin
		if      (RST) 
		begin
			AluResult <= 0;
			ReadData <= 0;
			RF_WE <= 0;
			MemWE <= 0;
			WBSelect <= 0;
			A3 <= 0;
		end
		
		else
		begin
			ReadData <= ReadData_i;
			RF_WE <= RF_WE_i;
			MemWE <= MemWE_i;
			WBSelect <= WBSelect_i;
			A3 <= A3_i;
			AluResult <= AluResult_i;
		end
		
	end
	
	always @(posedge CLK) 
	begin
		ReadData_o <= ReadData;
		RF_WE_o <= RF_WE;
		MemWE_o <= MemWE;
		WBSelect_o <= WBSelect;
		A3_o <= A3;
		AluResult_o <= AluResult;
	end
	
	endmodule