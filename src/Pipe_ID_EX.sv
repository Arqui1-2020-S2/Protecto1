module Pipe_ID_EX  #(N=32) (CLK, RST, 
									RD1_i, RD2_i, Extend_i, RF_WE_i, A3_i, BranchSelect_i, ALUOpBSelect_i, ALUControl_i,SetFlags_i, MemWE_i,WBSelect_i,
									RD1_o, RD2_o, Extend_o, RF_WE_o, A3_o, BranchSelect_o, ALUOpBSelect_o, ALUControl_o,SetFlags_o, MemWE_o,WBSelect_o);


input logic CLK, RST;
input logic [N-1:0] RD1_i, RD2_i, Extend_i;
input logic RF_WE_i, ALUOpBSelect_i,SetFlags_i, MemWE_i,WBSelect_i;
input logic [3:0] A3_i;
input logic [1:0] ALUControl_i,BranchSelect_i;

//
// logic [N-1:0] RD1, RD2, Extend;
// logic RF_WE, BranchSelect, ALUOpBSelect,SetFlags, MemWE,WBSelect;
// logic [3:0] A3;
// logic [1:0] ALUControl;


output logic [N-1:0] RD1_o, RD2_o, Extend_o;
output logic RF_WE_o, ALUOpBSelect_o,SetFlags_o, MemWE_o,WBSelect_o;
output logic [3:0] A3_o;
output logic [1:0] ALUControl_o,BranchSelect_o;


	always @(posedge CLK) 
	begin
		if      (RST) 
		begin
			RD1_o <= 0;
			RD2_o <= 0;
			Extend_o <= 0;
			RF_WE_o <= 0;
			BranchSelect_o <= 0;
			ALUOpBSelect_o <= 0;
			SetFlags_o <= 0;
			MemWE_o <= 0;
			WBSelect_o <= 0;
			A3_o <= 0;
			ALUControl_o <= 0;
		end
		
		else
		begin
			RD1_o <= RD1_i;
			RD2_o <= RD2_i;
			Extend_o <= Extend_i;
			RF_WE_o <= RF_WE_i;
			BranchSelect_o <= BranchSelect_i;
			ALUOpBSelect_o <= ALUOpBSelect_i;
			SetFlags_o <= SetFlags_i;
			MemWE_o <= MemWE_i;
			WBSelect_o <= WBSelect_i;
			A3_o <= A3_i;
			ALUControl_o <= ALUControl_i;
		end
		end
	
	endmodule