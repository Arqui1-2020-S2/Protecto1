module Pipe_IF_ID_tb();
parameter N = 32;

 logic CLK, RST;
 logic [N-1:0] instruction_i, instruction_o;

Pipe_IF_ID #(.N(N))  DUT(.CLK(CLK), .RST(RST), .instruction_i(instruction_i), .instruction_o(instruction_o));

initial
begin
CLK=0;
RST=1;

#1 CLK =1;
#1  CLK=0;
RST=0;



instruction_i = 1;
#1;
assert (instruction_o !== instruction_i) else $error("Case 1 failed.");
#1;


#1 CLK =1;
instruction_i = 2;
#1 CLK=0;

#1 CLK =1;
#2
assert (instruction_o == instruction_i) else $error("Case 2 failed.");
#1 CLK=0;


#1 CLK =1;
instruction_i = 3;
RST = 1 ;
#1  CLK=0;
#1 CLK =1;
#2
assert (instruction_o == 0) else $error("Case 3 failed.");



end




endmodule 