// Modelsim-ASE requires a timescale directive
`timescale 1 ps / 1 ps
module DataMemoryManager_tb();
logic [31:0] address_i, data_i,data_o;
logic  CLK, wren_i;
logic [31:0] i;
logic [3:0] wren;
logic [1:0] sel;

//altera_mf_ver en modelsim


DataMemoryManager DUT (.address_i(address_i), .CLK(CLK), 
								.data_i(data_i), .wren_i(wren_i), 
								.data_o(data_o));

	
initial
begin
CLK=0;
wren_i=0;



for(i=32'h00000;i<32'h000F;i=i+1)
begin
data_i=i;
address_i=i;
wren_i=1;
CLK=1;
#1;
CLK=0;
#1;
end

for(i=32'h10000;i<32'h1000F;i=i+1)
begin
data_i=i;
address_i=i;
wren_i=1;
CLK=1;
#1;
CLK=0;
#1;
end


for(i=32'h20000;i<32'h2000F;i=i+1)
begin
data_i=i;
address_i=i;
wren_i=1;
CLK=1;
#1;
CLK=0;
#1;
end

//###################################################################

wren_i=0; 
for(i=32'h00000;i<32'h0000F;i=i+1)
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


for(i=32'h10000;i<32'h1000F;i=i+1)
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


for(i=32'h20000;i<32'h2000F;i=i+1)
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