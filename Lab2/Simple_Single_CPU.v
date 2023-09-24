//Subject:     CO project 2 - Simple Single CPU
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
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire  [32-1:0] pc_in_i;
wire  [32-1:0] pc_out_o;
wire  [32-1:0] pc_plus_four;
wire  [32-1:0] instruction;
wire           regdst;
wire           regwrite;
wire           alusrc;
wire  [2-1: 0] alu_op;
wire           branch;
wire  [5-1: 0] write_register;
wire  [32-1:0] alu_result;
wire  [32-1:0] read_data1;
wire  [32-1:0] read_data2;
wire  [4-1: 0] alu_control;
wire  [32-1:0] alu_input2;
wire  [32-1:0] sign_ext_o;
wire           zero_o;
wire  [32-1:0] shift_left_o;
wire  [32-1:0] branch_adder_o;
wire           pc_source_control;

//Greate componentes
ProgramCounter PC(    //PC
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in_i),   
	    .pc_out_o(pc_out_o) 
	    );
	
Adder Adder1(         //PC+4
        .src1_i(32'd4),     
	    .src2_i(pc_out_o),     
	    .sum_o(pc_plus_four)    
	    );
	
Instr_Memory IM(      //Instruction_memory
        .pc_addr_i(pc_out_o),  
	    .instr_o(instruction)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(regdst),
        .data_o(write_register)
        );	
		
Reg_File RF(          //Register_File
        .clk_i(clk_i),      
	    .rst_i(rst_i),     
        .RSaddr_i(instruction[25:21]),  
        .RTaddr_i(instruction[20:16]),  
        .RDaddr_i(write_register),  
        .RDdata_i(alu_result), 
        .RegWrite_i(regwrite),
        .RSdata_o(read_data1),  
        .RTdata_o(read_data2)   
        );
	
Decoder Decoder(      //Decoder
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(regwrite), 
	    .ALU_op_o(alu_op),   
	    .ALUSrc_o(alusrc),   
	    .RegDst_o(regdst),   
		.Branch_o(branch)   
	    );

ALU_Ctrl AC(          //ALU_control
        .funct_i(instruction[5:0]),   
        .ALUOp_i(alu_op),   
        .ALUCtrl_o(alu_control) 
        );
	
Sign_Extend SE(       //Sign_extend
        .data_i(instruction[15:0]),
        .data_o(sign_ext_o)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(read_data2),
        .data1_i(sign_ext_o),
        .select_i(alusrc),
        .data_o(alu_input2)
        );	
		
ALU ALU(              //ALU
        .src1_i(read_data1),
	    .src2_i(alu_input2),
	    .ctrl_i(alu_control),
	    .result_o(alu_result),
		.zero_o(zero_o)
	    );
		
Adder Adder2(         //branch_adder
        .src1_i(pc_plus_four),     
	    .src2_i(shift_left_o),     
	    .sum_o(branch_adder_o)      
	    );
		
Shift_Left_Two_32 Shifter( //shift_left_2
        .data_i(sign_ext_o),
        .data_o(shift_left_o)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_plus_four),
        .data1_i(branch_adder_o),
        .select_i(pc_source_control),
        .data_o(pc_in_i)
        );	

assign pc_source_control = branch & zero_o;

endmodule
		  


