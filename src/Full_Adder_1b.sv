module Full_Adder_1b(input  logic A, B, Cin,
						output logic S, Cout);

always_comb begin
	S = A ^ B ^ Cin;
	Cout = A & B | (A^B) & Cin;
end

endmodule 