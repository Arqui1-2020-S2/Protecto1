module Full_Subtractor_1b(input logic a, b, bin,
						        output logic d, bout);
								  			  
	logic w1, w2, w3;
					
	always_comb begin
		w1 = a ^ b;
		w2 = ~w1 & bin;
		w3 = ~a & b; 			
		
	end
				
	assign d = w1 ^ bin;
	assign bout = w2 | w3; 	
			
endmodule 