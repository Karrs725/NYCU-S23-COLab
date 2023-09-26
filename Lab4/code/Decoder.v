//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      110550063
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
//110550063
module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [2-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output         MemRead_o;
output	      MemWrite_o;
output         MemtoReg_o;
 
//Internal Signals
reg    [2-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg            MemRead_o;
reg            MemWrite_o;
reg            MemtoReg_o;

//Parameter


//Main function
always @(instr_op_i)
begin
    case (instr_op_i)
        0:  begin  //R-format
                RegDst_o <= 1;
                ALUSrc_o <= 0;
                MemtoReg_o <= 0;
                RegWrite_o <= 1;
                MemRead_o <= 0;
                MemWrite_o <= 0;
                Branch_o <= 0;
                ALU_op_o <= 2'b11;
            end
        4:  begin  //beq
                RegDst_o <= 0;
                ALUSrc_o <= 0;
                MemtoReg_o <= 0;
                RegWrite_o <= 0;
                MemRead_o <= 0;
                MemWrite_o <= 0;
                Branch_o <= 1;
                ALU_op_o <= 2'b10;
            end
        8:  begin  //addi
                RegDst_o <= 0;
                ALUSrc_o <= 1;
                MemtoReg_o <= 0;
                RegWrite_o <= 1;
                MemRead_o <= 0;
                MemWrite_o <= 0;
                Branch_o <= 0;
                ALU_op_o <= 2'b00;
            end
        10: begin  //slti
                RegDst_o <= 0;
                ALUSrc_o <= 1;
                MemtoReg_o <= 0;
                RegWrite_o <= 1;
                MemRead_o <= 0;
                MemWrite_o <= 0;
                Branch_o <= 0;
                ALU_op_o <= 2'b01;
            end
        35: begin  //lw
                RegDst_o <= 0;
                ALUSrc_o <= 1;
                MemtoReg_o <= 1;
                RegWrite_o <= 1;
                MemRead_o <= 1;
                MemWrite_o <= 0;
                Branch_o <= 0;
                ALU_op_o <= 2'b00;
            end
        43: begin  //sw
                RegDst_o <= 0;
                ALUSrc_o <= 1;
                MemtoReg_o <= 0;
                RegWrite_o <= 0;
                MemRead_o <= 0;
                MemWrite_o <= 1;
                Branch_o <= 0;
                ALU_op_o <= 2'b00;
            end
        default:  begin
                    RegDst_o <= 0;
                    ALUSrc_o <= 0;
                    MemtoReg_o <= 0;
                    RegWrite_o <= 0;
                    MemRead_o <= 0;
                    MemWrite_o <= 0;
                    Branch_o <= 0;
                    ALU_op_o <= 2'b11;
                end
    endcase
end

endmodule





                    
                    