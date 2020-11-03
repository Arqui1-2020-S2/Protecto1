module RegisterFile_tb();

logic clk, rst, WE3;
logic [3:0] A1, A2, A3;
logic [31:0] WD3, R15, RD1, RD2;

RegisterFile DUT(clk, rst, WE3, A1, A2, A3, WD3, R15, RD1, RD2);

initial begin
	clk = 1;
	rst = 0;
	A1 = 0;
	A2 = 0;
	A3 = 0;
	WE3 = 0;
	WD3 = 0;
	R15 = 0;
	#10;
	
	//Caso 1: Escribir WD3 en Registro R1 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b00111001111111001111110011111111;
	A1 = 4'b0001;
	A2 = 4'b0001;
	A3 = 4'b0001;
	#10
	assert (RD1 === WD3) else $error("Case 1 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 1 RD2 failed.");

	//Caso 2: Escribir WD3 en Registro R2 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b00111111100111111110011111110011;
	A1 = 4'b0010;
	A2 = 4'b0010;
	A3 = 4'b0010;
	#10
	assert (RD1 === WD3) else $error("Case 2 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 2 RD2 failed.");
	
	//Caso 3: Escribir WD3 en Registro R3 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b11100111111110011110011111110011;
	A1 = 4'b0011;
	A2 = 4'b0011;
	A3 = 4'b0011;
	#10
	assert (RD1 === WD3) else $error("Case 3 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 3 RD2 failed.");
	
	//Caso 4: Escribir WD3 en Registro R4 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b00000001001110011110011111110011;
	A1 = 4'b0100;
	A2 = 4'b0100;
	A3 = 4'b0100;
	#10
	assert (RD1 === WD3) else $error("Case 4 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 4 RD2 failed.");
	
	//Caso 5: Escribir WD3 en Registro R5 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b11111000000010011100111100110011;
	A1 = 4'b0101;
	A2 = 4'b0101;
	A3 = 4'b0101;
	#10
	assert (RD1 === WD3) else $error("Case 5 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 5 RD2 failed.");
	
	//Caso 6: Escribir WD3 en Registro R6 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b11111000000010011100111100110011;
	A1 = 4'b0110;
	A2 = 4'b0110;
	A3 = 4'b0110;
	#10
	assert (RD1 === WD3) else $error("Case 6 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 6 RD2 failed.");
	
	//Caso 7: Escribir WD3 en Registro R7 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b11111000000010011100111100110011;
	A1 = 4'b0111;
	A2 = 4'b0111;
	A3 = 4'b0111;
	#10
	assert (RD1 === WD3) else $error("Case 7 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 7 RD2 failed.");

	//Caso 8: Escribir WD3 en Registro R8 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b11000010011100111100011100110011;
	A1 = 4'b1000;
	A2 = 4'b1000;
	A3 = 4'b1000;
	#10
	assert (RD1 === WD3) else $error("Case 8 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 8 RD2 failed.");
	
	//Caso 9: Escribir WD3 en Registro R9 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b11000010000000111010111100110011;
	A1 = 4'b1001;
	A2 = 4'b1001;
	A3 = 4'b1001;
	#10
	assert (RD1 === WD3) else $error("Case 9 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 9 RD2 failed.");
	
	//Caso 10: Escribir WD3 en Registro R10 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b11000010000000111010111100110011;
	A1 = 4'b1010;
	A2 = 4'b1010;
	A3 = 4'b1010;
	#10
	assert (RD1 === WD3) else $error("Case 10 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 10 RD2 failed.");
	
	//Caso 11: Escribir WD3 en Registro R11 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b11000010001010111100100001110011;
	A1 = 4'b1011;
	A2 = 4'b1011;
	A3 = 4'b1011;
	#10
	assert (RD1 === WD3) else $error("Case 11 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 11 RD2 failed.");
	
	//Caso 12: Escribir WD3 en Registro R12 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b00000010001010000000000001110011;
	A1 = 4'b1100;
	A2 = 4'b1100;
	A3 = 4'b1100;
	#10
	assert (RD1 === WD3) else $error("Case 12 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 12 RD2 failed.");
	
	//Caso 13: Escribir WD3 en Registro R13 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b00000010001010011100111001110011;
	A1 = 4'b1101;
	A2 = 4'b1101;
	A3 = 4'b1101;
	#10
	assert (RD1 === WD3) else $error("Case 13 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 13 RD2 failed.");
	
	//Caso 14: Escribir WD3 en Registro R14 y leerlo en las salidas RD1 y RD2
	WE3 = 1;
	WD3 = 32'b00000010001010011100111001110011;
	A1 = 4'b1110;
	A2 = 4'b1110;
	A3 = 4'b1110;
	#10
	assert (RD1 === WD3) else $error("Case 14 RD1 failed.");
	assert (RD2 === WD3) else $error("Case 14 RD2 failed.");
	
	// Caso 15: Escribir en Registro R15 utilizando la entrada R15 y leerlo
	WE3 = 0;
	R15 = 000000000000000000000000000000000011;
	A1 = 4'b1111;
	A2 = 4'b1111;
	#10
	assert (RD1 === R15) else $error("Case 15 RD1 failed.");
	assert (RD2 === R15) else $error("Case 15 RD2 failed.");
	
end

always
	#5 clk = !clk;

endmodule 