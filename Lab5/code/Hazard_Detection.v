//110550063
module Hazard_Detection(
    memread_ex_i,
    if_id_rs_i,
    if_id_rt_i,
    id_ex_rt_i,
    branch_i,
    pc_write_o,
    if_id_write_o,
    if_flush_o,
    id_flush_o,
    ex_flush_o
    );
    
//I/O ports 
input         memread_ex_i;
input [5-1:0] if_id_rs_i;
input [5-1:0] if_id_rt_i;
input [5-1:0] id_ex_rt_i;
input         branch_i;

output        pc_write_o;
output        if_id_write_o;
output        if_flush_o;
output        id_flush_o;
output        ex_flush_o;

//Internal Signals
reg pc_write_o;
reg if_id_write_o;
reg if_flush_o;
reg id_flush_o;
reg ex_flush_o;

//Main function
always @(*)
begin
    if(branch_i) begin
        pc_write_o <= 1;
        if_id_write_o <= 0;
        if_flush_o <= 1;
        id_flush_o <= 1;
        ex_flush_o <= 1;
    end
    else begin
        if(memread_ex_i & ((id_ex_rt_i == if_id_rs_i)|(id_ex_rt_i == if_id_rt_i))) begin
            pc_write_o <= 0;
            if_id_write_o <= 0;
            if_flush_o <= 0;
            id_flush_o <= 1;
            ex_flush_o <= 0;
        end
        else begin
            pc_write_o <= 1;
            if_id_write_o <= 1;
            if_flush_o <= 0;
            id_flush_o <= 0;
            ex_flush_o <= 0;
        end
    end
end

endmodule
