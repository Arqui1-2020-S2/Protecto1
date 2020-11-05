module ALU_tb();

logic[3:0] A, B, ALUResult;
logic [1:0] ALUControl, ALUFlags;
logic Z, N;

ALU #(4) alu(A, B, ALUControl, ALUResult, ALUFlags);

assign N = ALUFlags[0];
assign Z = ALUFlags[1];

initial begin
	// Caso 1: Suma con carryout
	ALUControl = 2'b00;
	A = 4'b1010;
	B = 4'b1001;
	#10;
	assert (ALUResult === 4'b0011) else $error("Case 1: ALUResult failed.");
	assert (N === 1'b0) else $error("Case 1: N failed.");
	assert (Z === 1'b0) else $error("Case 1: Z failed.");
	#10;
	
	// Caso 2: Suma sin carryout
	ALUControl = 2'b00;
	A = 4'b1010;
	B = 4'b0001;
	#10;
	assert (ALUResult === 4'b1011) else $error("Case 2: ALUResult failed.");
	assert (N === 1'b1) else $error("Case 2: N failed.");
	assert (Z === 1'b0) else $error("Case 2: Z failed.");
	#10;
	
	// Caso 3: Suma zero
	ALUControl = 2'b00;
	A = 4'b0000;
	B = 4'b0000;
	#10;
	assert (ALUResult === 4'b0000) else $error("Case 3: ALUResult failed.");
	assert (N === 1'b0) else $error("Case 3: N failed.");
	assert (Z === 1'b1) else $error("Case 3: Z failed.");
	#10;
	
	
	// Caso 4: Resta con carryout
	ALUControl = 2'b01;
	A = 4'b0000;
	B = 4'b1111;
	#10;
	assert (ALUResult === 4'b0001) else $error("Case 4: ALUResult failed.");
	assert (N === 1'b0) else $error("Case 4: N failed.");
	assert (Z === 1'b0) else $error("Case 4: Z failed.");
	#10;
	
	// Caso 5: Resta sin carryout
	ALUControl = 2'b01;
	A = 4'b1100;
	B = 4'b0011;
	#10;
	assert (ALUResult === 4'b1001) else $error("Case 5: ALUResult failed.");
	assert (N === 1'b1) else $error("Case 5: N failed.");
	assert (Z === 1'b0) else $error("Case 5: Z failed.");
	#10;
	
	// Caso 6: Resta zero
	ALUControl = 2'b01;
	A = 4'b1101;
	B = 4'b1101;
	#10;
	assert (ALUResult === 4'b0000) else $error("Case 6: ALUResult failed.");
	assert (N === 1'b0) else $error("Case 6: N failed.");
	assert (Z === 1'b1) else $error("Case 6: Z failed.");
	#10;
	
	// Caso 7: Left Shift
	ALUControl = 2'b11;
	A = 4'b0100;
	B = 4'b0001;
	#10;
	assert (ALUResult === A << B) else $error("Case 7: ALUResult failed.");
	assert (N === 1'b1) else $error("Case 7: N failed.");
	assert (Z === 1'b0) else $error("Case 7: Z failed.");
	#10;
	
	// Caso 8: Left Shift zero
	ALUControl = 2'b11;
	A = 4'b0100;
	B = 4'b0010;
	#10;
	assert (ALUResult === A << B) else $error("Case 8: ALUResult failed.");
	assert (N === 1'b0) else $error("Case 8: N failed.");
	assert (Z === 1'b1) else $error("Case 8: Z failed.");
	#10;




end

endmodule 