module Control_Unit(input 	logic[3:0] OpCode,
						  output logic RegFileWE, ALUOpBSelect,
										   SetFlags, MemWE, WBSelect,
						  output logic[1:0] ExtendSelect, ALUControl,BranchSelect);
	
	logic [10:0] OUT;
	
	always_comb begin
		casex(OpCode)     //  9876543210
			4'b0000: OUT = 11'b0;			//NOP
			4'b0001: OUT = 11'b01010001100;//Branch
			4'b0010: OUT = 11'b10010001100;//Branch equal
			4'b0011: OUT = 11'b11010001100;//Branch less than
			4'b0100: OUT = 11'b00100000001;//Load word
			4'b0101: OUT = 11'b00100000001;//Load byte
			4'b0110: OUT = 11'b00000000010;//Store word
			4'b0111: OUT = 11'b00000000010;//Store byte
			4'b1000: OUT = 11'b00100000000;//Add
			4'b1001: OUT = 11'b00101100000;//Add Imm
			4'b1010: OUT = 11'b00100001000;//Substract
			4'b1011: OUT = 11'b00100010000;//Divide
			4'b1100: OUT = 11'b00100011000;//Shift Left
			default: OUT = 11'b0;
		endcase
	end
	
	assign BranchSelect = OUT[10:9];
	assign RegFileWE = OUT[8];
	assign ExtendSelect = OUT[7:6];
	assign ALUOpBSelect = OUT[5];
	assign ALUControl = OUT[4:3];
	assign SetFlags = OUT[2];
	assign MemWE = OUT[1];
	assign WBSelect = OUT[0];
			

endmodule						  