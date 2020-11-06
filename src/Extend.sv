module Extend(input  logic[1:0]  ImmSrc,
				  input  logic[19:0] Instr,
				  output logic[31:0] ExtImm);
// ImmSrc: selector de operacion
// Instr: bits de la instruccion que corresponden al inmediato
// ExtImm: inmediato extendido segun la operacion seleccionada
always_comb begin
	case (ImmSrc)
				 // Extension de ceros
		2'b00: ExtImm = {19'b0, Instr[15:0]};
				 // Extension de signo
		2'b01: ExtImm = {{16{Instr[15]}},Instr[15:0]};
				 // Extension de signo con dos corrimientos a la izquierda
		2'b10: ExtImm = {{10{Instr[19]}},Instr[19:0], 2'b00};
		default: ExtImm = 32'bx; // Indefinido
	endcase
end
	  
endmodule 