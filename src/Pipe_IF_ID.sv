module Pipe_IF_ID  #(N=32) (CLK, RST, instruction_i, instruction_o);
input logic CLK, RST;
input logic [N-1:0] instruction_i;
output logic [N-1:0] instruction_o;
//logic [N-1:0] instruction;



	always @(negedge CLK) begin
		
	end
	
	always @(posedge CLK) begin
		if      (RST) instruction_o <= 0;
		else     instruction_o <= instruction_i;
	end

	
	endmodule