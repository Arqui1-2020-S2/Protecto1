module Register #(N=2) (input  logic CLK, RST, EN,
						   	input  logic [N-1:0] Data_In,
							   output logic [N-1:0] Data_Out);
								
	logic [N-1:0] OUT = 0;

	always_ff @(negedge CLK) begin
		if      (RST) OUT <= 0;
		else if (EN) OUT <= Data_In;
	end

	assign Data_Out = OUT;

endmodule 