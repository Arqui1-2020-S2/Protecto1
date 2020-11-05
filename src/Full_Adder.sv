module Full_Adder #(parameter N = 4)
						 (input  logic [N-1:0] A, B,
						  input  logic  		  Cin,
						  output logic [N-1:0] S,
						  output logic 		  Cout);
	  
	logic [N-1:0] w;
		  
	assign w[0] = Cin;

	genvar i;
	generate
		for(i = 0; i < N-1; i++)
			begin : generate_adder
				Full_Adder_1b adder(A[i], B[i], w[i], S[i], w[i+1]);
			end	
	endgenerate

	Full_Adder_1b adder(A[N-1], B[N-1], w[N-1], S[N-1], Cout);
		  
endmodule 