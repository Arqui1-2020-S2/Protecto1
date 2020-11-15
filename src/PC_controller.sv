module PC_controller(branchselect_id_i,branchselect_ex_i, ALU_flags_i,pc_select_o ,clear_pipes_o);
input logic [1:0] branchselect_id_i,branchselect_ex_i,ALU_flags_i;
output logic pc_select_o,clear_pipes_o;


//pc_select_o
//pc_select_o 1 cuando:
//					branchselect_id_i == 01
//					branchselect_ex_i == 10 AND flag zero
//					branchselect_ex_i == 11 AND flag negative
//clear_pipes_o = 1 cuando 
//					branchselect_ex_i == 10 AND flag zero
//					branchselect_ex_i == 11 AND flag negative

logic zero, negative;
assign zero = ALU_flags_i[1];
assign negative = ALU_flags_i[0];
assign pc_select_o = ((branchselect_ex_i===2'b01) || (branchselect_ex_i===2'b10 && zero)  ||  (branchselect_ex_i===2'b11 && negative) )? (1):(0);
//assign clear_pipes_o = pc_select_o;
assign clear_pipes_o = pc_select_o;


endmodule