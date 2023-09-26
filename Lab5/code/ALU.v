//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      110550063
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
//110550063
module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	jump_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output            jump_o;

//Internal signals
reg    [32-1:0]  result_o;
reg              jump_o;

//Parameter

//Main function
always @(ctrl_i, src1_i, src2_i)
begin
    case (ctrl_i)
        0:  begin
                result_o <= src1_i & src2_i;
                jump_o <= 0;
            end
        1:  begin
                result_o <= src1_i | src2_i;
                jump_o <= 0;
            end
        2:  begin
                result_o <= src1_i + src2_i;
                jump_o <= 0;
            end
        3:  begin
                result_o <= src1_i * src2_i;
                jump_o <= 0;
            end
        6:  begin
                result_o <= src1_i - src2_i;
                jump_o <= 0;
            end
        7:  begin
                result_o <= src1_i < src2_i ? 1 : 0;
                jump_o <= 0;
            end
        8:  begin
                result_o <= 0;
                jump_o <= src1_i == src2_i ? 1 : 0;
            end
        9:  begin
                result_o <= 0;
                jump_o <= src1_i != src2_i ? 1 : 0;
            end
        10: begin
                result_o <= 0;
                jump_o <= src1_i >= src2_i ? 1 : 0;
            end
        11: begin
                result_o <= 0;
                jump_o <= src1_i > src2_i ? 1 : 0;
            end
        default: begin
                    result_o <= 0;
                    jump_o <= 0;
                end
    endcase
end

endmodule





                    
                    