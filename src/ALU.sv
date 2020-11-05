module ALU #(parameter N = 32)
				(input logic [N-1:0] A, B,
				 input logic [1:0] ALUControl,
				 output logic [N-1:0] ALUResult,
				 output logic [1:0] ALUFlags);

logic [N-1:0] Addition, Subtraction, LeftShift;
logic Cout, Bout;
logic Z, C;
					 
// Operaciones
Full_Adder      #(N) adder(A, B, 1'b0, Addition, Cout);
Full_Subtractor #(N) subtractor(A, B, 1'b0, Subtraction, Bout);
Left_Shift      #(N) lshift(A, B, LeftShift);

// Seleccion del resultado deseado
Mux_4 #(N) muxcontrol(ALUControl, Addition, Subtraction, 1'bX, LeftShift, ALUResult);

// Determinacion de las banderas
always_comb begin
	// Bandera C
	case(ALUControl)
		2'b00: C = Cout;
		2'b01: C = Bout;
		default: C = 0;
	endcase
	
	// Bandera Z
	if (ALUResult === 0) Z <= 1;
	else Z <= 0;
end

assign ALUFlags = {Z, C}; 
					 
endmodule 