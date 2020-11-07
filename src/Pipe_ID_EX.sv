module Pipe_ID_EX  #(N=32) (CLK, RST, 
									RD1_i, RD2_i, Extend_i, RF_WE_i, A3_i, BranchSelect_i, ALUOpBSelect_i, ALUControl_i,SetFlags_i, MemWE_i,WBSelect_i,
									RD1_o, RD2_o, Extend_o, RF_WE_o, A3_o, BranchSelect_o, ALUOpBSelect_o, ALUControl_o,SetFlags_o, MemWE_o,WBSelect_o);


input logic CLK, RST;
input logic [N-1:0] RD1_i, RD2_i, Extend_i;
input logic RF_WE_i, BranchSelect_i, ALUOpBSelect_i,SetFlags_i, MemWE_i,WBSelect_i;
input logic [3:0] A3_i;
input logic [1:0] ALUControl_i;


 logic [N-1:0] RD1, RD2, Extend;
 logic RF_WE, BranchSelect, ALUOpBSelect,SetFlags, MemWE,WBSelect;
 logic [3:0] A3;
 logic [1:0] ALUControl;


output logic [N-1:0] RD1_o, RD2_o, Extend_o;
output logic RF_WE_o, BranchSelect_o, ALUOpBSelect_o,SetFlags_o, MemWE_o,WBSelect_o;
output logic [3:0] A3_o;
output logic [1:0] ALUControl_o;



	always @(negedge CLK) begin
		if      (RST) 
		begin
			RD1 <= 0;
			RD2 <= 0;
			Extend <= 0;
			RF_WE <= 0;
			BranchSelect <= 0;
			ALUOpBSelect <= 0;
			SetFlags <= 0;
			MemWE <= 0;
			WBSelect <= 0;
			A3 <= 0;
			ALUControl <= 0;
		end
		
		else
		begin
			RD1 <= RD1_i;
			RD2 <= RD2_i;
			Extend <= Extend_i;
			RF_WE <= RF_WE_i;
			BranchSelect <= BranchSelect_i;
			ALUOpBSelect <= ALUOpBSelect_i;
			SetFlags <= SetFlags_i;
			MemWE <= MemWE_i;
			WBSelect <= WBSelect_i;
			A3 <= A3_i;
			ALUControl <= ALUControl_i;
		end
		
	end
	
	always @(posedge CLK) 
	begin
		RD1_o <= RD1;
		RD2_o <= RD2;
		Extend_o <= Extend;
		RF_WE_o <= RF_WE;
		BranchSelect_o <= BranchSelect;
		ALUOpBSelect_o <= ALUOpBSelect;
		SetFlags_o <= SetFlags;
		MemWE_o <= MemWE;
		WBSelect_o <= WBSelect;
		A3_o <= A3;
		ALUControl_o <= ALUControl;
	end
	
	endmodule