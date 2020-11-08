module Ram #(parameter N = 1024, G = 10)
			   (input  logic [G-1:0] Addr,
			    input  logic CLK, RST,
			    input  logic [31:0] Data_In,
			    input  logic EN,
			    output logic [31:0] Data_Out);
	// Memoria
	logic [7:0] Memory [0:N-1];
	
	// Variables para direccionamiento de memoria 
	logic [G-1:0] Addr1, Addr2, Addr3;
	assign Addr1 = Addr  + 1;
	assign Addr2 = Addr1 + 1;
	assign Addr3 = Addr2 + 1;
	
	// Direccionamiento de memoria
	integer index;
	always_ff @(negedge CLK) begin
		if (RST) begin
			for (index=0; index<N; index++) begin
				Memory[index] <= 8'b0;
			end
		end else if (EN) begin
			Memory[Addr]  <= Data_In[31:24];
			Memory[Addr1] <= Data_In[23:16];
			Memory[Addr2] <= Data_In[15:8];
			Memory[Addr3] <= Data_In[7:0];
		end
	end
	
	assign Data_Out = {Memory[Addr],Memory[Addr1],Memory[Addr2],Memory[Addr3]};		  
endmodule 