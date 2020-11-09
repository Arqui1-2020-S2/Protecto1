`timescale 1 ps / 1 ps
module DataMemSection_tb();

logic [31:0] address_i, data_i,data_o;
logic  CLK, wren_i;

logic [31:0] counter;
logic CLK_ng;

assign CLK_ng=!CLK;

DataMemSection datamem_0(
	.address(address_i[15:0]),
	.clock(CLK),
	.data(data_i),
	.wren(wren_i),
	.q(data_o));

always #5 CLK =! CLK;
	
initial
begin
CLK=0;
for(counter=0; counter<16; counter=counter+1)
begin
wait(CLK == 0);
#2;
data_i=counter;
wren_i=1;
address_i=counter;
wait(CLK == 1);
end

wren_i=0;
#10;
for(counter=0; counter<16; counter=counter+1)
begin
wait(CLK == 0);
#2;
data_i=0;
wren_i=0;
address_i=counter;
wait(CLK == 1);
#1;
assert (data_o == address_i) else $error("ERROR: address_i:%0d, data_o:%0d",address_i,data_o);



end


$finish;

end
	
endmodule