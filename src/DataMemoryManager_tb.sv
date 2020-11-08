// Modelsim-ASE requires a timescale directive
`timescale 1 ns / 1 ns
module DataMemoryManager_tb();
logic [31:0] address_i, data_i,data_o;
logic  CLK, wren_i;
logic [31:0] i;


//altera_mf_ver en modelsim


DataMemoryManager DUT (.address_i(address_i), .CLK(CLK), 
								.data_i(data_i), .wren_i(wren_i), 
								.data_o(data_o));

	
initial
begin
CLK=0;
wren_i=0;
for(i=0;i<1000;i=i+1)
begin
data_i=i;
address_i=i;
wren_i=1;
CLK=1;
#1;
CLK=0;
#1;
end


wren_i=0; 
for(i=0;i<1000;i=i+1)
begin
data_i=0;
address_i=i;
CLK=1;
#1;
CLK=0;
#1;
CLK=1;
#1;
CLK=0;
#1;
assert (data_o === i) else $error("Case%0d data in memory: %0d", i,data_o );
end





$finish;
end
								
								

endmodule