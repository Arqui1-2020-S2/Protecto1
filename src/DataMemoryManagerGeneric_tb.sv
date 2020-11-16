`timescale 1 ps / 1 ps
module DataMemoryManagerGeneric_tb();

    logic [31:0] address_i, data_i,data_o,byte_mode_i;
    logic  CLK, wren_i;

    DataMemoryManagerGeneric  #(16) DUT (
        .address_i(address_i),
        .CLK(CLK),
        .data_i(data_i),
        .wren_i(wren_i),
        .byte_mode_i(byte_mode_i),
        .data_o(data_o));
    initial  begin
        // FILL THE MEMORY 
        address_i = {11'b000000000000 ,4'b0000, 1'b0, 17'b1};
        data_i = {32'b0000_1111_0000_1111_0000_1111_0000_1111};
        wren_i = 1;
        #101
        wren_i = 0;
        address_i = {11'b000000000000 ,4'b0000, 1'b0, 17'b1};
        assert(data_o == {32'b0000_1111_0000_1111_0000_1111_0000_1111}) else $error ("Error");
        // READ THE MEMORY

    end    

endmodule