module ALU #(parameter N = 32)
				(input logic [N-1:0] A, B,
				 input logic [1:0] ALUControl,
				 output logic [N-1:0] ALUResult,
				 output logic [1:0] ALUFlags);

logic [N-1:0] Addition, Subtraction, LeftShift;
logic Cout, Bout;
logic Zero, Neg;
					 
// Operaciones
Full_Adder      #(N) adder(A, B, 1'b0, Addition, Cout);
Full_Subtractor #(N) subtractor(A, B, 1'b0, Subtraction, Bout);
Left_Shift      #(N) lshift(A, B, LeftShift);

// Seleccion del resultado deseado
Mux_4 #(N) muxcontrol(ALUControl, Addition, Subtraction, 32'b0, LeftShift, ALUResult);

// Determinacion de las banderas
assign Neg = ALUResult[N-1]; // Bandera negativo
always_comb begin	
	// Bandera Zero
	if (ALUResult === 0) Zero <= 1;
	else Zero <= 0;
end

assign ALUFlags = {Zero, Neg};
					 
endmodule 