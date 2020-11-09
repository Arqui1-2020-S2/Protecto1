module Ram #(parameter G = 18, parameter mif_filename="mem_data/in_ram.txt")
			   (input  logic [G-1:0] address_i,
			    input  logic CLK, RST,
			    input  logic [31:0] data_i,
			    input  logic EN,
				 input  logic ByteMode_i,
			    output logic [31:0] data_o				 
				 );
	// Memoria
//   logic [7:0] Memory [0:D-1] /* synthesis ram_init_file = "../../mem_data/test.hex" */;
//	logic [7:0] Memory [0:2**G-1];
	logic [7:0] Memory [0:2**10-1];

	logic [23:0] zero = 0;
	// Variables para direccionamiento de memoria 
	logic [G-1:0] Addr1, Addr2, Addr3;
	assign Addr1 = address_i  + 1;
	assign Addr2 = Addr1 + 1;
	assign Addr3 = Addr2 + 1;
	
	// Direccionamiento de memoria
	integer index;
	always_ff @(negedge CLK) begin
		if (RST) begin
//			for (index=0; index<D; index++) begin
//				Memory[index] <= 8'b0;
//			end
			Memory<= '{default:2'b00};
		end 
		
		else if (EN) begin
			
			if (ByteMode_i) 
			begin
				Memory[address_i]  <= data_i[7:0];
			end
			else 
			begin
				Memory[address_i]  <= data_i[31:24];
				Memory[Addr1] <= data_i[23:16];
				Memory[Addr2] <= data_i[15:8];
				Memory[Addr3] <= data_i[7:0];
			end 
		end
	end
	
	initial begin
	$readmemb(mif_filename, Memory);
//	$readmemb("mem_data/in_ram.txt", Memory);

	end
	
	assign data_o = ByteMode_i?({zero,Memory[address_i]}):({Memory[address_i],Memory[Addr1],Memory[Addr2],Memory[Addr3]});		  
endmodule 