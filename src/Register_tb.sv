module Register_tb();

logic clk, rst, en;
logic [3:0] data_in, data_out;

Register #(4) DUT(clk, rst, en, data_in, data_out);

initial begin
	clk = 1;
	rst = 0;
	en = 0;
	data_in = 0;
	#10;
	
	// Caso 1: Dato en la entrada sin enable activado, no debe escribir
	data_in = 4'b1100;
	#10;
	assert (data_out !== data_in) else $error("Case 1 failed.");
	
	// Caso 2: Activar enable para que escriba
	en = 1;
	#10;
	assert (data_out === 4'b1100) else $error("Case 2 failed.");
	
	// Caso 3: Desactivar enable y cambiar dato en la entrada, no debe escribir
	en = 0;
	data_in = 4'b1111;
	#10;
	assert (data_out === 4'b1100) else $error("Case 3 failed.");
	
	// Caso 4: Activar enable para que escriba nuevamente
	en = 1;
	#10;
	assert (data_out === 4'b1111) else $error("Case 4 failed.");
	#10
	
	// Caso 5: Reset del registro
	en = 0;
	rst = 1;
	#10;
	assert (data_out === 4'b0000) else $error("Case 5 failed.");
	
	
end

always
	#5 clk = !clk;

endmodule 