module Ram_tb();

parameter G = 18;

logic [G-1:0] address_i;
logic CLK, RST;
logic [31:0] data_i;
logic EN;
logic [31:0] data_o;
logic ByteMode_i;
Ram  #(.G(G)) ram (.address_i(address_i), .CLK(CLK), .RST(RST), .data_i(data_i), .EN(EN), .data_o(data_o), .ByteMode_i(ByteMode_i));

//always #5 CLK=!CLK;


initial 
begin

CLK=0;
//RST=1;
#20;
RST=0;

EN=0;
ByteMode_i=0;
#10 address_i = 0;
#10 address_i = 4;
#10 address_i = 8;
#10 address_i = 12;

#10 ByteMode_i=1;
#10 address_i = 3;
#10 address_i = 7;
#10 address_i = 11;
#10 address_i = 15;

#50; 
EN=1;
ByteMode_i=0;

#10 CLK=1;
data_i=32'h11030201;
#10 address_i = 0;
#10 CLK=0;

#10 CLK=1;
data_i=32'h44030201;
#10 address_i = 4;
#10 CLK=0;

#10 CLK=1;
data_i=32'h88030201;
#10 address_i = 8;
#10 CLK=0;

#10 CLK=1;
data_i=32'hCC030201;
#10 address_i = 12;
#10 CLK=0;
#10

EN=0;
ByteMode_i=0;
#10 address_i = 0;
#10 address_i = 4;
#10 address_i = 8;
#10 address_i = 12;


#50; 
EN=1;
ByteMode_i=1;

#10 CLK=1;
data_i=32'h000000AA;
#10 address_i = 1;
#10 CLK=0;

#10 CLK=1;
data_i=32'h000000BB;
#10 address_i = 3;
#10 CLK=0;

#10 CLK=1;
data_i=32'h000000CC;
#10 address_i = 7;
#10 CLK=0;

#10 CLK=1;
data_i=32'h000000DD;
#10 address_i = 11;
#10 CLK=0;
#10

EN=0;
ByteMode_i=0;
#10 address_i = 0;
#10 address_i = 4;
#10 address_i = 8;
#10 address_i = 12;
#10;



end

endmodule