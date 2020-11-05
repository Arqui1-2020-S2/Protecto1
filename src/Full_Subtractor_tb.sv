module Full_Subtractor_tb();

logic [3:0] A, B, D;
logic Bin, Bout;

Full_Subtractor #(4) subtractor(A, B, Bin, D, Bout);

initial begin
	// Caso 1
	A = 4'b1010;
	B = 4'b0001;
	Bin = 1'b0;
	#10;
	assert (D === 4'b1001) else $error("Case 1: D failed.");
	assert (Bout === 1'b0) else $error("Case 1: Bout failed.");
	#10;
	
	//Caso 2
	A = 4'b0000;
	B = 4'b1111;
	Bin = 1'b0;
	#10;
	assert (D === 4'b0001) else $error("Case 2: D failed.");
	assert (Bout === 1'b1) else $error("Case 2: Bout failed.");
	#10;
	
	//Caso 3
	A = 4'b1000;
	B = 4'b1010;
	Bin = 1'b0;
	#10;
	assert (D === 4'b1110) else $error("Case 3: D failed.");
	assert (Bout === 1'b1) else $error("Case 3: Bout failed.");
	#10;
	
	//Caso 4
	A = 4'b0000;
	B = 4'b0000;
	Bin = 1'b0;
	#10;
	assert (D === 4'b0000) else $error("Case 4: D failed.");
	assert (Bout === 1'b0) else $error("Case 4: Bout failed.");
	#10;
	
	//Caso 5
	A = 4'b1111;
	B = 4'b1111;
	Bin = 1'b0;
	#10;
	assert (D === 4'b0000) else $error("Case 5: D failed.");
	assert (Bout === 1'b0) else $error("Case 5: Bout failed.");
	#10;
	
	//Caso 6
	A = 4'b1001;
	B = 4'b0100;
	Bin = 1'b0;
	#10;
	assert (D === 4'b0101) else $error("Case 6: D failed.");
	assert (Bout === 1'b0) else $error("Case 6: Bout failed.");
	#10;
	
end

endmodule 