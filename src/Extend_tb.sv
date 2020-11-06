module Extend_tb();

logic[1:0]  ImmSrc;
logic[19:0] Instr;
logic[31:0] ExtImm;

Extend extend(ImmSrc, Instr, ExtImm);

initial begin
	// Caso 1: Extension de ceros
	ImmSrc = 2'b00;
	Instr = 20'b11111100001111000011;
	#10
	assert (ExtImm === 32'b00000000000000001100001111000011) else $error("Case 1: ExtImm failed.");
	#10;
	
	// Caso 2: Extension de ceros
	ImmSrc = 2'b00;
	Instr = 20'b11111111111111111111;
	#10
	assert (ExtImm === 32'b00000000000000001111111111111111) else $error("Case 2: ExtImm failed.");
	#10;
	
	// Caso 3: Extension de signo
	ImmSrc = 2'b01;
	Instr = 20'b11110100001111000011;
	#10
	assert (ExtImm === 32'b00000000000000000100001111000011) else $error("Case 3: ExtImm failed.");
	#10;
	
	// Caso 4: Extension de signo
	ImmSrc = 2'b01;
	Instr = 20'b11111111111111111111;
	#10
	assert (ExtImm === 32'b11111111111111111111111111111111) else $error("Case 4: ExtImm failed.");
	#10;
	
	// Caso 5: Extension de signo con corrimiento de 2 a la izquierda
	ImmSrc = 2'b10;
	Instr = 20'b00000100001111000011;
	#10
	assert (ExtImm === 32'b00000000000000010000111100001100) else $error("Case 5: ExtImm failed.");
	#10;
	
	// Caso 6: Extension de signo con corrimiento de 2 a la izquierda
	ImmSrc = 2'b10;
	Instr = 20'b11111111100011100011;
	#10
	assert (ExtImm === 32'b11111111111111111110001110001100) else $error("Case 6: ExtImm failed.");
	#10;
	
	
end

endmodule 