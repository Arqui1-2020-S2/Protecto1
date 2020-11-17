module AllStages_tb();
    // General parameters and logical signals.
    parameter N = 32; 
    logic CLK;
//-------------------------------------------------------------------------------------------------------------------------------------
    logic RST_Pipe_IF_ID; // Reset: pipe instruction fetch / instruction decode
    logic [N-1:0] instruction_i, instruction_o; // variables to store instruction 
//-------------------------------------------------------------------------------------------------------------------------------------
    logic RST_RegisterFile; // Reset: Register file
    logic WE3_RegisterFile; // Write Enable: Register file
    logic [3:0] A1_RegisterFile, A2_RegisterFile, A3_RegisterFile; // Register selectors
    logic [31:0] WD3_RegisterFile, R15_RegisterFile, RD1_RegisterFile, RD2_RegisterFile; // Data to be written on register, 
    // Data to be written on register 15, Data saved on register 1/2
//-------------------------------------------------------------------------------------------------------------------------------------
    logic RST_Pipe_ID_EX; // Reset: Pipe instruction decode / execution
    logic [N-1:0] Extend_i_Pipe_ID_EX // Extend data as input for pipe
    logic RF_WE_i_Pipe_ID_EX, BranchSelect_i_Pipe_ID_EX, ALUOpBSelect_i_Pipe_ID_EX, SetFlags_i_Pipe_ID_EX,
    MemWE_i_Pipe_ID_EX, WBSelect_i_Pipe_ID_EX;
    logic [3:0] A3_i_Pipe_ID_EX;
    logic [1:0] ALUControl_i_Pipe_ID_EX;

    logic [N-1:0] RD1_o_Pipe_ID_EX, RD2_o_Pipe_ID_EX, Extend_o_Pipe_ID_EX;
    logic RF_WE_o_Pipe_ID_EX, BranchSelect_o_Pipe_ID_EX, ALUOpBSelect_o_Pipe_ID_EX,
    SetFlags_o_Pipe_ID_EX, MemWE_o_Pipe_ID_EX, WBSelect_o_Pipe_ID_EX;
    logic [3:0] A3_o_Pipe_ID_EX; 
    logic [1:0] ALUControl_o_Pipe_ID_EX;
//-------------------------------------------------------------------------------------------------------------------------------------
    logic[N-1:0] ALUResult_ALU;
    logic [1:0]  ALUFlags_ALU;
//-------------------------------------------------------------------------------------------------------------------------------------
    logic RST_Pipe_EX_MEM;
    logic [N-1:0] RD2_o_Pipe_EX_MEM;
    logic RF_WE_o_Pipe_EX_MEM;
    logic MemWE_o_Pipe_EX_MEM;
    logic WBSelect_o_Pipe_EX_MEM;
    logic [N-1:0] AluResult_o_Pipe_EX_MEM;
    logic [3:0] A3_o_Pipe_EX_MEM;
//-------------------------------------------------------------------------------------------------------------------------------------
    logic RST_Pipe_MEM_WB;
    logic [N-1:0] ReadData_i_Pipe_MEM_WB;
    logic [N-1:0] ReadData_o_Pipe_MEM_WB, ALUResult_o_Pipe_MEM_WB;
    logic MemWE_o_Pipe_MEM_WB,WBSelect_o_Pipe_MEM_WB,RF_WE_o_Pipe_MEM_WB;
    logic [3:0] A3_o_Pipe_MEM_WB;
    
    // Device: Instruction Memory
    // Pipe Instruction Fetch / Instruction Decode
    Pipe_IF_ID #(.N(N))  Pipe_IF_ID_UT(
        .CLK(CLK),
        .RST(RST_Pipe_IF_ID),
        .instruction_i(instruction_i),
        .instruction_o(instruction_o));

        // Device: Register File
        RegisterFile #(.N(N)) RegisterFile_UT(
            .clk(CLK),
            .rst(RST_RegisterFile),
            .WE3(WE3_RegisterFile),
            .A1(A1_RegisterFile),
            .A2(A2_RegisterFile),
            .A3(A3_RegisterFile),
            .WD3(WD3_RegisterFile),
            .R15(R15_RegisterFile),
            .RD1(RD1_RegisterFile),
            .RD2(RD2_RegisterFile));

        // Extend
    
    // Pipe Instruction Decode / Execute
    Pipe_ID_EX  #(.N(N)) Pipe_ID_EX_UT(
        .CLK(CLK),
        .RST(RST_Pipe_ID_EX),
        .RD1_i(RD1_RegisterFile), // From Register File
        .RD2_i(RD2_RegisterFile), // From Register File
        .Extend_i(Extend_i_Pipe_ID_EX), //
        .RF_WE_i(RF_WE_i_Pipe_ID_EX),
        .A3_i(A3_i_Pipe_ID_EX), // Check
        .BranchSelect_i(BranchSelect_i_Pipe_ID_EX), // check
        .ALUOpBSelect_i(ALUOpBSelect_i_Pipe_ID_EX), // check 
        .ALUControl_i(ALUControl_i_Pipe_ID_EX), // check
        .SetFlags_i(SetFlags_i_Pipe_ID_EX), // check
        .MemWE_i(MemWE_i_Pipe_ID_EX), // check
        .WBSelect_i(WBSelect_i_Pipe_ID_EX), // check
        .RD1_o(RD1_o_Pipe_ID_EX), // from register file
        .RD2_o(RD2_o_Pipe_ID_EX), // from register file
        .Extend_o(Extend_o_Pipe_ID_EX),
        .RF_WE_o(RF_WE_o_Pipe_ID_EX),
        .A3_o(A3_o_Pipe_ID_EX), 
        .BranchSelect_o(BranchSelect_o_Pipe_ID_EX),
        .ALUOpBSelect_o(ALUOpBSelect_o_Pipe_ID_EX), 
        .ALUControl_o(ALUControl_o_Pipe_ID_EX),
        .SetFlags_o(SetFlags_o_Pipe_ID_EX), 
        .MemWE_o(MemWE_o_Pipe_ID_EX),
        .WBSelect_o(WBSelect_o_Pipe_ID_EX));
        // Device: Mux
        // Device: Alu
        ALU #(.N(N)) ALU_UT (
            .A(RD1_o_Pipe_ID_EX),
            .B(RD2_o_Pipe_ID_EX),
            .ALUControl(ALUControl_o_Pipe_ID_EX),
            .ALUResult(ALUResult_ALU),
            .ALUFlags(ALUFlags_ALU));
                

    // Pipe Exucute / Memory
    Pipe_EX_MEM  #(.N(N)) Pipe_EX_MEM_UT (
        .CLK(CLK),
        .RST(RST_Pipe_EX_MEM), 
        .RD2_i(RD2_o_Pipe_ID_EX), 
        .RF_WE_i(RF_WE_o_Pipe_ID_EX),
        .MemWE_i(MemWE_o_Pipe_ID_EX),
        .WBSelect_i(WBSelect_o_Pipe_ID_EX),
        .AluResult_i(ALUResult_ALU),
        .A3_i(A3_o_Pipe_ID_EX),
        .RD2_o(RD2_o_Pipe_EX_MEM),
        .RF_WE_o(RF_WE_o_Pipe_EX_MEM),
        .MemWE_o(MemWE_o_Pipe_EX_MEM),
        .WBSelect_o(WBSelect_o_Pipe_EX_MEM),
        .AluResult_o(AluResult_o_Pipe_EX_MEM),
        .A3_o(A3_RegisterFile));
            
        
        // Device: Data Memory

    // Pipe Memory /  Write Back 
        Pipe_MEM_WB  #(N) (
            .CLK(CLK),
            .RST(RST_Pipe_MEM_WB),
            .ReadData_i(ReadData_i_Pipe_MEM_WB),
            .RF_WE_i(RF_WE_o_Pipe_EX_MEM),
            .MemWE_i(MemWE_o_Pipe_EX_MEM),
            .WBSelect_i(WBSelect_o_Pipe_EX_MEM),
            .AluResult_i(AluResult_o_Pipe_EX_MEM),
            .A3_i(A3_o_Pipe_ID_EX),
            .ReadData_o(ReadData_o_Pipe_MEM_WB),
            .RF_WE_o(RF_WE_o_Pipe_MEM_WB),
            .MemWE_o(MemWE_o_Pipe_MEM_WB),
            .WBSelect_o(WBSelect_o_Pipe_MEM_WB),
            .AluResult_o(ALUResult_o_Pipe_MEM_WB),
            .A3_o(A3_o_Pipe_MEM_WB));


    initial begin 
    end
endmodule