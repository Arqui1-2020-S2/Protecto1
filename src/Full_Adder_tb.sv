module Full_Adder_tb();

logic [3:0] A, B, S;
logic Cin, Cout;

Full_Adder #(4) adder(A, B, Cin, S, Cout);

initial begin
	// Caso 1
	A = 4'b0001;
	B = 4'b1010;
	Cin = 1'b0;
	#10;
	assert (S === 4'b1011) else $error("Case 1: S failed.");
	assert (Cout === 1'b0) else $error("Case 1: Cout failed.");
	#10;
	
	//Caso 2
	A = 4'b0000;
	B = 4'b1111;
	Cin = 1'b0;
	#10;
	assert (S === 4'b1111) else $error("Case 2: S failed.");
	assert (Cout === 1'b0) else $error("Case 2: Cout failed.");
	#10;
	
	//Caso 3
	A = 4'b1000;
	B = 4'b1010;
	Cin = 1'b0;
	#10;
	assert (S === 4'b0010) else $error("Case 3: S failed.");
	assert (Cout === 1'b1) else $error("Case 3: Cout failed.");
	#10;
	
	//Caso 4
	A = 4'b0000;
	B = 4'b0000;
	Cin = 1'b0;
	#10;
	assert (S === 4'b0000) else $error("Case 4: S failed.");
	assert (Cout === 1'b0) else $error("Case 4: Cout failed.");
	#10;
	
	//Caso 5
	A = 4'b1111;
	B = 4'b1111;
	Cin = 1'b0;
	#10;
	assert (S === 4'b1110) else $error("Case 5: S failed.");
	assert (Cout === 1'b1) else $error("Case 5: Cout failed.");
	#10;
	
	//Caso 6
	A = 4'b1001;
	B = 4'b0100;
	Cin = 1'b1;
	#10;
	assert (S === 4'b1110) else $error("Case 6: S failed.");
	assert (Cout === 1'b0) else $error("Case 6: Cout failed.");
	#10;
	
end

endmodule 