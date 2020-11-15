module Pipe_ID_EX_ALU_Pipe_EX_MEM_tb  #(N=32)();

// Entradas para inicializar el pipe ID --> EX
logic CLK; /* Reloj de circuito*/
logic RST_Pipe_ID_EX; /* Bandera de reset*/


logic [N-1:0] RD1_i_Pipe_ID_EX, RD2_i_Pipe_ID_EX, Extend_i_Pipe_ID_EX; /* Registro 1 entrada, Registro 2 entrada, ?????? */
logic RF_WE_i_Pipe_ID_EX, BranchSelect_i_Pipe_ID_EX, ALUOpBSelect_i_Pipe_ID_EX, SetFlags_i_Pipe_ID_EX,
MemWE_i_Pipe_ID_EX, WBSelect_i_Pipe_ID_EX;
logic [3:0] A3_i_Pipe_ID_EX;
logic [1:0] ALUControl_i_Pipe_ID_EX;

// Salidas para inicializar el pipe ID --> EX
logic [N-1:0] RD1_o_Pipe_ID_EX, RD2_o_Pipe_ID_EX, Extend_o_Pipe_ID_EX;
logic RF_WE_o_Pipe_ID_EX, BranchSelect_o_Pipe_ID_EX, ALUOpBSelect_o_Pipe_ID_EX,
SetFlags_o_Pipe_ID_EX, MemWE_o_Pipe_ID_EX, WBSelect_o_Pipe_ID_EX;
logic [3:0] A3_o_Pipe_ID_EX; 
logic [1:0] ALUControl_o_Pipe_ID_EX;

Pipe_ID_EX  #(N) pipe_id_ex(
    .CLK(CLK),
    .RST(RST_Pipe_ID_EX),
    .RD1_i(RD1_i_Pipe_ID_EX),
    .RD2_i(RD2_i_Pipe_ID_EX),
    .Extend_i(Extend_i_Pipe_ID_EX),
    .RF_WE_i(RF_WE_i_Pipe_ID_EX),
    .A3_i(A3_i_Pipe_ID_EX), 
    .BranchSelect_i(BranchSelect_i_Pipe_ID_EX), 
    .ALUOpBSelect_i(ALUOpBSelect_i_Pipe_ID_EX),
    .ALUControl_i(ALUControl_i_Pipe_ID_EX),
    .SetFlags_i(SetFlags_i_Pipe_ID_EX),
    .MemWE_i(MemWE_i_Pipe_ID_EX),
    .WBSelect_i(WBSelect_i_Pipe_ID_EX),
    .RD1_o(RD1_o_Pipe_ID_EX),
    .RD2_o(RD2_o_Pipe_ID_EX), 
    .Extend_o(Extend_o_Pipe_ID_EX),
    .RF_WE_o(RF_WE_o_Pipe_ID_EX),
    .A3_o(A3_o_Pipe_ID_EX), 
    .BranchSelect_o(BranchSelect_o_Pipe_ID_EX),
    .ALUOpBSelect_o(ALUOpBSelect_o_Pipe_ID_EX), 
    .ALUControl_o(ALUControl_o_Pipe_ID_EX),
    .SetFlags_o(SetFlags_o_Pipe_ID_EX), 
    .MemWE_o(MemWE_o_Pipe_ID_EX),
    .WBSelect_o(WBSelect_o_Pipe_ID_EX));

// Entradas para inicializar el módulo ALU
/* A Primer operando    : RD1_o */
/* B Segundo operando   : RD2_o */
/* ALUControl           : ALUControl_o  */
// Salidas para ALU
/* ALUResult            :  */
logic[N-1:0] ALUResult;
/* ALUFlags             :  */
logic[1:0]  ALUFlags;
ALU #(N) alu (
    .A(RD1_o_Pipe_ID_EX),
    .B(RD2_o_Pipe_ID_EX),
    .ALUControl(ALUControl_o_Pipe_ID_EX),
    .ALUResult(ALUResult),
    .ALUFlags(ALUFlags));


// Entradas para inicializar el pipe EX --> MEN
logic RST_Pipe_EX_MEM; /* Bandera de reset*/


// Salidas para inicializar el pipe EX --> 
logic [N-1:0] RD2_o_Pipe_EX_MEM;
logic RF_WE_o_Pipe_EX_MEM;
logic MemWE_o_Pipe_EX_MEM;
logic WBSelect_o_Pipe_EX_MEM;
logic [N-1:0] AluResult_o_Pipe_EX_MEM;
logic [3:0] A3_o_Pipe_EX_MEM;

Pipe_EX_MEM  #(N) pipe_ex_mem (
    .CLK(CLK),
    .RST(RST_Pipe_EX_MEM), 
    .RD2_i(RD2_o_Pipe_ID_EX), 
    .RF_WE_i(RF_WE_o_Pipe_ID_EX),
    .MemWE_i(MemWE_o_Pipe_ID_EX),
    .WBSelect_i(WBSelect_o_Pipe_ID_EX),
    .AluResult_i(ALUResult),
    .A3_i(A3_o_Pipe_ID_EX),
    .RD2_o(RD2_o_Pipe_EX_MEM),
    .RF_WE_o(RF_WE_o_Pipe_EX_MEM),
    .MemWE_o(MemWE_o_Pipe_EX_MEM),
    .WBSelect_o(WBSelect_o_Pipe_EX_MEM),
    .AluResult_o(AluResult_o_Pipe_EX_MEM),
    .A3_o(A3_o_Pipe_EX_MEM));


//Bloque de pruebas
initial begin
    //Caso 1: suma resultado correcto 
	 RST_Pipe_ID_EX = 0;
	 RD1_i_Pipe_ID_EX = 32'b00000000000000000000000000000001;
	 RD2_i_Pipe_ID_EX = 32'b00000000000000000000000000000011;
	 RF_WE_i_Pipe_ID_EX = 0;
	 BranchSelect_i_Pipe_ID_EX = 0;
	 ALUOpBSelect_i_Pipe_ID_EX = 0;
	 SetFlags_i_Pipe_ID_EX = 0;
	 MemWE_i_Pipe_ID_EX = 0;
	 WBSelect_i_Pipe_ID_EX = 0;
	 ALUControl_i_Pipe_ID_EX = 2'b00; //Establecemos una suma
	 #101
	 $display("Vericando valores de salida de Pipe ID_EX");
	 assert (RD1_o_Pipe_ID_EX === 32'b00000000000000000000000000000001) else $error("Valor de salida RD1_o_Pipe_ID_EX =%b no es el correcto ", RD1_o_Pipe_ID_EX );
    assert (RD2_o_Pipe_ID_EX === 32'b00000000000000000000000000000011) else $error("Valor de salida RD2_o_Pipe_ID_EX =%b no es el correcto ", RD2_o_Pipe_ID_EX );
	 #150
	 $display("Vericando resultado de la suma");
	 assert(ALUResult === 32'b00000000000000000000000000000100) else $error("Resultado de la suma es incorrecto %b ",ALUResult);
	 #101
	 $display("Vericando Salida del pipe EX_MEM");
	 assert(AluResult_o_Pipe_EX_MEM === 32'b00000000000000000000000000000100) else $error("Resultado de la suma en el pipe EX_MEM es incorrecto %b ",ALUResult);
	 $display("Finaliza exitosamente la prueba");
     
     //Caso 2: resta resultado correcto
end

endmodule
