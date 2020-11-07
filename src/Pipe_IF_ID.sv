module Pipe_IF_ID  #(N=32) (CLK, RST, instruction_i, instruction_o);
input logic CLK, RST;
input logic [N-1:0] instruction_i;
output logic [N-1:0] instruction_o;
logic [N-1:0] instruction;



	always @(negedge CLK) begin
		if      (RST) instruction <= 0;
		else     instruction <= instruction_i;
	end
	
	always @(posedge CLK) begin
		instruction_o <= instruction;
	end

	
	endmodule