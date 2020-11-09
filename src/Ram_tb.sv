module Ram_tb();

parameter G = 18;
parameter D = 1024;

logic [G-1:0] address_i;
logic CLK, RST;
logic [31:0] data_i;
logic EN;
logic [31:0] data_o;
Ram  #( .D(D), .G(G)) ram (.address_i(address_i), .CLK(CLK), .RST(RST), .data_i(data_i), .EN(EN), .data_o(data_o));

always #5 CLK=!CLK;


initial begin
CLK=0;
EN=0;
RST=1;
#20;
RST=0;



#10 address_i = 0;
#10 address_i = 4;
#10 address_i = 8;
#10 address_i = 12;


end

endmodule