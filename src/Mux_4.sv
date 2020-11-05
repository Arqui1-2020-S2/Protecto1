module Mux_4 #(N=4) (input  [1:0]   S,
						   input  [N-1:0] D0, D1, D2, D3,
						   output [N-1:0] Y);

logic[N-1:0] out;	
							
always_comb begin
	case(S)
		2'b00: out = D0;
		2'b01: out = D1;
		2'b10: out = D2;
		2'b11: out = D3;
		default: out = 0;
	endcase
end

assign Y = out;

endmodule							