module Extend(input  logic[1:0]  Ext_sel_i,
				  input  logic[19:0] Imm_i,
				  output logic[31:0] Imm_ext_o);
// ImmSrc: selector de operacion
// Instr: bits de la instruccion que corresponden al inmediato
// ExtImm: inmediato extendido segun la operacion seleccionada
always_comb begin
	case (Ext_sel_i)
				 // Extension de ceros
		2'b00: Imm_ext_o = {16'b0, Imm_i[15:0]};
				 // Extension de signo
		2'b01: Imm_ext_o = {{16{Imm_i[15]}},Imm_i[15:0]};
				 // Extension de signo con dos corrimientos a la izquierda
//		2'b10: Imm_ext_o = {{12{Imm_i[19]}},Imm_i[19:0], 2'b00};
		2'b10: Imm_ext_o = {{14{Imm_i[19]}},Imm_i[19:0]}; //nuevo extend

		default: Imm_ext_o = 32'b0; // Indefinido
	endcase
end
	  
endmodule 