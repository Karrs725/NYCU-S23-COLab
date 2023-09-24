//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      110550063
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns/1ps
//110550063
module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [2-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation
always @(funct_i, ALUOp_i)
begin
    case (ALUOp_i)
        0: ALUCtrl_o <= 4'b0010;  //addi
        1: ALUCtrl_o <= 4'b0111;  //slti
        2: ALUCtrl_o <= 4'b0110;  //beq
        3:  begin
                case (funct_i)
                    32: ALUCtrl_o <= 4'b0010;  //add
                    34: ALUCtrl_o <= 4'b0110;  //sub
                    36: ALUCtrl_o <= 4'b0000;  //and
                    37: ALUCtrl_o <= 4'b0001;  //or
                    42: ALUCtrl_o <= 4'b0111;  //slt
                endcase
            end
        default: ALUCtrl_o <= 4'b0000;
    endcase
end

endmodule     





                    
                    