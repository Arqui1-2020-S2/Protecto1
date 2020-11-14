module Right_Shift #(parameter N=4)
				       (input logic[N-1:0] A, B,
				        output logic[N-1:0] C);
// A: numero al que hacerle el shift
// B: cantidad de shifts
// C: resultado
assign C = A >> B;
	
endmodule 