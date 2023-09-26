//110550063
module Forwarding(
    id_ex_rs_i,
    id_ex_rt_i,
    ex_mem_rd_i,
    ex_mem_regwrite_i,
    mem_wb_rd_i,
    mem_wb_regwrite_i,
    forwardA_o,
    forwardB_o
    );
    
//I/O ports 
input [5-1:0] id_ex_rs_i;
input [5-1:0] id_ex_rt_i;
input [5-1:0] ex_mem_rd_i;
input         ex_mem_regwrite_i;
input [5-1:0] mem_wb_rd_i;
input         mem_wb_regwrite_i;

output [2-1:0] forwardA_o;
output [2-1:0] forwardB_o;

//Internal Signals
reg [2-1:0] forwardA_o;
reg [2-1:0] forwardB_o;

//Main function
always @(*)
begin
    if(ex_mem_regwrite_i & (ex_mem_rd_i!=0) & (ex_mem_rd_i == id_ex_rs_i)) forwardA_o <= 2'b01;
    else if(mem_wb_regwrite_i & (mem_wb_rd_i!=0) & (mem_wb_rd_i == id_ex_rs_i)) forwardA_o <= 2'b10;
    else  forwardA_o <= 2'b00;
    
    if(ex_mem_regwrite_i & (ex_mem_rd_i!=0) & (ex_mem_rd_i == id_ex_rt_i)) forwardB_o <= 2'b01;
    else if(mem_wb_regwrite_i & (mem_wb_rd_i!=0) & (mem_wb_rd_i == id_ex_rt_i)) forwardB_o <= 2'b10;
    else  forwardB_o <= 2'b00;
end

endmodule
