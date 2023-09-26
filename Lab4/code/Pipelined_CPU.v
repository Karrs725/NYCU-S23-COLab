`timescale 1ns / 1ps
// 110550063
module Pipelined_CPU(
    clk_i,
    rst_i
);
    
/*==================================================================*/
/*                          input & output                          */
/*==================================================================*/

input clk_i;
input rst_i;

/*==================================================================*/
/*                            reg & wire                            */
/*==================================================================*/

/**** IF stage ****/
wire [32-1:0] pc_i;
wire [32-1:0] pc_o;
wire [32-1:0] im_if;
wire [32-1:0] pc_plus4_if;

/**** ID stage ****/
wire [32-1:0] instruction_id;
wire          regdst_id;
wire          alusrc_id;
wire          memtoreg_id;
wire          regwrite_id;
wire          memread_id;
wire          memwrite_id;
wire          branch_id;
wire [ 2-1:0] aluop_id;
wire [32-1:0] pc_plus4_id;
wire [32-1:0] readdata1_id;
wire [32-1:0] readdata2_id;
wire [32-1:0] signextend_id;

/**** EX stage ****/
wire          regdst_ex;
wire          alusrc_ex;
wire          memtoreg_ex;
wire          regwrite_ex;
wire          memread_ex;
wire          memwrite_ex;
wire          branch_ex;
wire [ 2-1:0] aluop_ex;
wire [32-1:0] pc_plus4_ex;
wire [32-1:0] readdata1_ex;
wire [32-1:0] readdata2_ex;
wire [32-1:0] signextend_ex;
wire [ 5-1:0] ins0_ex;
wire [ 5-1:0] ins1_ex;
wire [32-1:0] shift_left2;
wire [32-1:0] alu_in2;
wire [ 4-1:0] alu_ctrl;
wire [32-1:0] pc_branch_ex;
wire          zero_ex;
wire [32-1:0] alu_result_ex;
wire [ 5-1:0] write_register_ex;

/**** MEM stage ****/
wire          memtoreg_mem;
wire          regwrite_mem;
wire          memread_mem;
wire          memwrite_mem;
wire          branch_mem;
wire [32-1:0] pc_branch_mem;
wire          zero_mem;
wire          pcsrc_mem;
wire [32-1:0] alu_result_mem;
wire [32-1:0] readdata2_mem;
wire [32-1:0] memory_out_mem;
wire [ 5-1:0] write_register_mem;

/**** WB stage ****/
wire          memtoreg_wb;
wire          regwrite_wb;
wire [32-1:0] memory_out_wb;
wire [32-1:0] alu_result_wb;
wire [ 5-1:0] write_register_wb;
wire [32-1:0] write_data_wb;

/*==================================================================*/
/*                              design                              */
/*==================================================================*/

//Instantiate the components in IF stage

MUX_2to1 #(.size(32)) Mux0( // pc_i
    .data0_i(pc_plus4_if),
    .data1_i(pc_branch_mem),
    .select_i(pcsrc_mem),
    .data_o(pc_i)
);

ProgramCounter PC(
    .clk_i(clk_i),
	.rst_i(rst_i),
	.pc_in_i(pc_i),
	.pc_out_o(pc_o)
);

Instruction_Memory IM(
    .addr_i(pc_o),
    .instr_o(im_if)
);
			
Adder Add_pc( //pc_plus4
    .src1_i(pc_o),
	.src2_i(32'd4),
	.sum_o(pc_plus4_if)
);
		
Pipe_Reg #(.size(64)) IF_ID(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .data_i({pc_plus4_if, im_if}),
    .data_o({pc_plus4_id, instruction_id})
);


//Instantiate the components in ID stage

Reg_File RF(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .RSaddr_i(instruction_id[25:21]),
    .RTaddr_i(instruction_id[20:16]),
    .RDaddr_i(write_register_wb),
    .RDdata_i(write_data_wb),
    .RegWrite_i(regwrite_wb),
    .RSdata_o(readdata1_id),
    .RTdata_o(readdata2_id)
);

Decoder Control(
    .instr_op_i(instruction_id[31:26]),
	.RegWrite_o(regwrite_id),
	.ALU_op_o(aluop_id),
	.ALUSrc_o(alusrc_id),
	.RegDst_o(regdst_id),
	.Branch_o(branch_id),
	.MemRead_o(memread_id),
	.MemWrite_o(memwrite_id),
	.MemtoReg_o(memtoreg_id)
);

Sign_Extend SE(
    .data_i(instruction_id[15:0]),
    .data_o(signextend_id)
);

Pipe_Reg #(.size(147)) ID_EX(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .data_i({regwrite_id,
             memtoreg_id,
             branch_id,
             memread_id,
             memwrite_id,
             regdst_id,
             aluop_id,
             alusrc_id,
             pc_plus4_id,
             readdata1_id,
             readdata2_id,
             signextend_id,
             instruction_id[20:16],
             instruction_id[15:11]}),
    .data_o({regwrite_ex,
             memtoreg_ex,
             branch_ex,
             memread_ex,
             memwrite_ex,
             regdst_ex,
             aluop_ex,
             alusrc_ex,
             pc_plus4_ex,
             readdata1_ex,
             readdata2_ex,
             signextend_ex,
             ins0_ex,
             ins1_ex})
);


//Instantiate the components in EX stage

Shift_Left_Two_32 Shifter(
    .data_i(signextend_ex),
    .data_o(shift_left2)
);

ALU ALU(
    .src1_i(readdata1_ex),
	.src2_i(alu_in2),
	.ctrl_i(alu_ctrl),
	.result_o(alu_result_ex),
	.zero_o(zero_ex)
);
		
ALU_Ctrl ALU_Control(
    .funct_i(signextend_ex[5:0]),
    .ALUOp_i(aluop_ex),
    .ALUCtrl_o(alu_ctrl)
);

MUX_2to1 #(.size(32)) Mux1( //alu_src
    .data0_i(readdata2_ex),
    .data1_i(signextend_ex),
    .select_i(alusrc_ex),
    .data_o(alu_in2)
);
		
MUX_2to1 #(.size(5)) Mux2( //write_register
    .data0_i(ins0_ex),
    .data1_i(ins1_ex),
    .select_i(regdst_ex),
    .data_o(write_register_ex)
);

Adder Add_pc_branch(
    .src1_i(pc_plus4_ex),
	.src2_i(shift_left2),
	.sum_o(pc_branch_ex)
);

Pipe_Reg #(.size(107)) EX_MEM( // Modify N, which is the total length of input/output
    .clk_i(clk_i),
    .rst_i(rst_i),
    .data_i({regwrite_ex,
             memtoreg_ex,
             branch_ex,
             memread_ex,
             memwrite_ex,
             pc_branch_ex,
             zero_ex,
             alu_result_ex,
             readdata2_ex,
             write_register_ex}),
    .data_o({regwrite_mem,
             memtoreg_mem,
             branch_mem,
             memread_mem,
             memwrite_mem,
             pc_branch_mem,
             zero_mem,
             alu_result_mem,
             readdata2_mem,
             write_register_mem})
);


//Instantiate the components in MEM stage

Data_Memory DM(
    .clk_i(clk_i),
    .addr_i(alu_result_mem),
    .data_i(readdata2_mem),
    .MemRead_i(memread_mem),
    .MemWrite_i(memwrite_mem),
    .data_o(memory_out_mem)
);

Pipe_Reg #(.size(71)) MEM_WB( // Modify N, which is the total length of input/output
    .clk_i(clk_i),
    .rst_i(rst_i),
    .data_i({regwrite_mem,
             memtoreg_mem,
             memory_out_mem,
             alu_result_mem,
             write_register_mem}),
    .data_o({regwrite_wb,
             memtoreg_wb,
             memory_out_wb,
             alu_result_wb,
             write_register_wb})
);

assign pcsrc_mem = branch_mem & zero_mem;

//Instantiate the components in WB stage

MUX_2to1 #(.size(32)) Mux3( //write_data
    .data0_i(alu_result_wb),
    .data1_i(memory_out_wb),
    .select_i(memtoreg_wb),
    .data_o(write_data_wb)
);


endmodule