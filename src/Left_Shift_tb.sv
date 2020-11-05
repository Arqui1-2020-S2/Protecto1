module Left_Shift_tb();

logic [4:0] A, B, C;

Left_Shift #(5) lshift(A, B, C);

initial begin
	// Caso 1 - Corrimiento de 0
	A = 5'b11011;
	B = 5'b00000;
	#10;
	assert (C === A << B) else $error("Case 1 failed.");
	#10;
	
	// Caso 2 - Corrimiento de 1
	B = 5'b00001;
	#10;
	assert (C === A << B) else $error("Case 2 failed.");
	#10;
	
	// Caso 3 - Corrimiento de 2
	B = 5'b00010;
	#10;
	assert (C === A << B) else $error("Case 3 failed.");
	#10;
	
	// Caso 4 - Corrimiento de 3
	B = 5'b00011;
	#10;
	assert (C === A << B) else $error("Case 4 failed.");
	#10;
	
	// Caso 5 - Corrimiento de 4
	B = 5'b00100;
	#10;
	assert (C === A << B) else $error("Case 5 failed.");
	#10;
	
	// Caso 6 - Corrimiento de 5
	B = 5'b00101;
	#10;
	assert (C === A << B) else $error("Case 6 failed.");
	#10;
	
end

endmodule 