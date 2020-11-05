module Control_Unit(input 	logic[3:0] OpCode,
						  output logic BranchSelect, RegFileWE, ExtendSelect,
											ALUOpBSelect, SetFlags, MemWE, WBSelect,
						  output logic[1:0] ALUControl);
	
	logic [9:0] OUT;
	
	always_comb begin
		casex(OpCode)
			4'b0000: OUT = 9'bX;			 //NOP
			4'b0001: OUT = 9'b1010011XX;//Branch
			4'b0010: OUT = 9'b1010011XX;//Branch equal
			4'b0011: OUT = 9'b1010011XX;//Branch less than
			4'b0100: OUT = 9'b01X000001;//Load word
			4'b0101: OUT = 9'b01X000001;//Load byte
			4'b0110: OUT = 9'b00X00001X;//Store word
			4'b0111: OUT = 9'b00X00001X;//Store byte
			4'b1000: OUT = 9'b01X000000;//Add
			4'b1001: OUT = 9'b01X100000;//Add Imm
			4'b1010: OUT = 9'b01X001000;//Substract
			4'b1011: OUT = 9'b01X010000;//Divide
			4'b1100: OUT = 9'b01X011000;//Shift Left
			//4'b1101: OUT = 10'b01X0XX000;//Shift LA *Igual a shift left logico
			default: OUT = 10'bX;
		endcase
	end
	
	assign BranchSelect = OUT[8];
	assign RegFileWE = OUT[7];
	assign ExtendSelect = OUT[6];
	assign ALUOpBSelect = OUT[5];
	assign ALUControl = OUT[4:3];
	assign SetFlags = OUT[2];
	assign MemWE = OUT[1];
	assign WBSelect = OUT[0];
			

endmodule						  