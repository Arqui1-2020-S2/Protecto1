module Pipe_MEM_WB_tb #(N=32)();
// Entradas para inicializar el pipe ID --> EX
logic CLK, RST_DUT1; /* Reloj de circuito*/

logic [N-1:0] ReadData_i,AluResult_i;
logic MemWE_i,WBSelect_i,RF_WE_i;
logic [3:0] A3_i;
//Salidas para inicializar el Pipe MEM_WB
logic [N-1:0] ReadData_o,AluResult_o;
logic MemWE_o,WBSelect_o,RF_WE_o;
logic [3:0] A3_o;

Pipe_MEM_WB #(N) DUT1(
    .CLK(CLK),
    .RST(RST_DUT1), 
    .ReadData_i(ReadData_i),
    .RF_WE_i(RF_WE_i),
    .MemWE_i(MemWE_i),
    .WBSelect_i(WBSelect_i),
    .AluResult_i(AluResult_i),
    .A3_i(A3_i),
    .ReadData_o(ReadData_o),
    .RF_WE_o(RF_WE_o),
    .MemWE_o(MemWE_o),
    .WBSelect_o(WBSelect_o),
    .AluResult_o(AluResult_o),
    .A3_o(A3_o));
    /**
    * Suponiendo que 0 = es el dato leído: READ DATA. 
    * Suponiendo que 1 = es el resultado de la ALU: ALU RESULT.
    */
    assign WBSelect_o = 0;
    logic [N-1:0] data_to_wb;
    assign data_to_wb = WBSelect_o ? AluResult_o : ReadData_o;
initial begin 
    RST_DUT1 = 0;
    ReadData_i = 32'h7894ACD0;
    AluResult_i = 32'h00000002;
    RF_WE_i = 1;
    MemWE_i = 1;
    WBSelect_i = 0; //Cambio de señal para seleccionar ahora ReadData_o del mux simulado
    A3_i = 4'b0011;
    #101
    $display("Vericando valores de salida de Pipe MEM_WB");
    assert(AluResult_o === 32'h00000002) else $error("Valor de salida incorrecto %b",AluResult_o);
    $display("Verificando selección de ReadData_o como valor de salida del MUX");
    assert(data_to_wb === ReadData_o) else $error("Valor de salida incorrecto %b",data_to_wb);
    WBSelect_i = 1; //Cambio de señal para seleccionar ahora AluResult_o del mux simulado
    #101
    $display("Verificando selección de AluResult_o como valor de salida del MUX");
    assert(data_to_wb === AluResult_o) else $error("Valor de salida incorrecto %b",data_to_wb);

end
endmodule
