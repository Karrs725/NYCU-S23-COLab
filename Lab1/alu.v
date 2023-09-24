`timescale 1ns/1ps
// 110550063
module alu(
    /* input */
    clk,            // system clock
    rst_n,          // negative reset
    src1,           // 32 bits, source 1
    src2,           // 32 bits, source 2
    ALU_control,    // 4 bits, ALU control input
    /* output */
    result,         // 32 bits, result
    zero,           // 1 bit, set to 1 when the output is 0
    cout,           // 1 bit, carry out
    overflow        // 1 bit, overflow
);

/*==================================================================*/
/*                          input & output                          */
/*==================================================================*/

input clk;
input rst_n;
input [31:0] src1;
input [31:0] src2;
input [3:0] ALU_control;

output [32-1:0] result;
output zero;
output cout;
output overflow;

/*==================================================================*/
/*                            reg & wire                            */
/*==================================================================*/

reg [32-1:0] result;
reg zero, cout, overflow;
wire [31:0] ALU_result;
wire [31:0] ALU_cout;
wire ALU_set, ALU_overflow;

/*==================================================================*/
/*                              design                              */
/*==================================================================*/

always@(posedge clk or negedge rst_n) 
begin
	if(!rst_n) begin
        result = 0;
        zero = 0;
        cout = 0;
        overflow = 0;
	end
	else begin
        zero = ~(|ALU_result);
        result = ALU_result;
        cout = ALU_cout[31];
        overflow = ALU_overflow;
	end
end

// HINT: You may use alu_top as submodule.
// 32-bit ALU
alu_top ALU00(.src1(src1[0]), .src2(src2[0]), .less(ALU_set), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_control[2]), .operation(ALU_control[1:0]), .result(ALU_result[0]), .cout(ALU_cout[0]));
alu_top ALU01(.src1(src1[1]), .src2(src2[1]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[0]), .operation(ALU_control[1:0]), .result(ALU_result[1]), .cout(ALU_cout[1]));
alu_top ALU02(.src1(src1[2]), .src2(src2[2]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[1]), .operation(ALU_control[1:0]), .result(ALU_result[2]), .cout(ALU_cout[2]));
alu_top ALU03(.src1(src1[3]), .src2(src2[3]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[2]), .operation(ALU_control[1:0]), .result(ALU_result[3]), .cout(ALU_cout[3]));
alu_top ALU04(.src1(src1[4]), .src2(src2[4]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[3]), .operation(ALU_control[1:0]), .result(ALU_result[4]), .cout(ALU_cout[4]));
alu_top ALU05(.src1(src1[5]), .src2(src2[5]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[4]), .operation(ALU_control[1:0]), .result(ALU_result[5]), .cout(ALU_cout[5]));
alu_top ALU06(.src1(src1[6]), .src2(src2[6]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[5]), .operation(ALU_control[1:0]), .result(ALU_result[6]), .cout(ALU_cout[6]));
alu_top ALU07(.src1(src1[7]), .src2(src2[7]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[6]), .operation(ALU_control[1:0]), .result(ALU_result[7]), .cout(ALU_cout[7]));
alu_top ALU08(.src1(src1[8]), .src2(src2[8]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[7]), .operation(ALU_control[1:0]), .result(ALU_result[8]), .cout(ALU_cout[8]));
alu_top ALU09(.src1(src1[9]), .src2(src2[9]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[8]), .operation(ALU_control[1:0]), .result(ALU_result[9]), .cout(ALU_cout[9]));
alu_top ALU10(.src1(src1[10]), .src2(src2[10]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[9]), .operation(ALU_control[1:0]), .result(ALU_result[10]), .cout(ALU_cout[10]));
alu_top ALU11(.src1(src1[11]), .src2(src2[11]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[10]), .operation(ALU_control[1:0]), .result(ALU_result[11]), .cout(ALU_cout[11]));
alu_top ALU12(.src1(src1[12]), .src2(src2[12]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[11]), .operation(ALU_control[1:0]), .result(ALU_result[12]), .cout(ALU_cout[12]));
alu_top ALU13(.src1(src1[13]), .src2(src2[13]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[12]), .operation(ALU_control[1:0]), .result(ALU_result[13]), .cout(ALU_cout[13]));
alu_top ALU14(.src1(src1[14]), .src2(src2[14]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[13]), .operation(ALU_control[1:0]), .result(ALU_result[14]), .cout(ALU_cout[14]));
alu_top ALU15(.src1(src1[15]), .src2(src2[15]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[14]), .operation(ALU_control[1:0]), .result(ALU_result[15]), .cout(ALU_cout[15]));
alu_top ALU16(.src1(src1[16]), .src2(src2[16]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[15]), .operation(ALU_control[1:0]), .result(ALU_result[16]), .cout(ALU_cout[16]));
alu_top ALU17(.src1(src1[17]), .src2(src2[17]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[16]), .operation(ALU_control[1:0]), .result(ALU_result[17]), .cout(ALU_cout[17]));
alu_top ALU18(.src1(src1[18]), .src2(src2[18]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[17]), .operation(ALU_control[1:0]), .result(ALU_result[18]), .cout(ALU_cout[18]));
alu_top ALU19(.src1(src1[19]), .src2(src2[19]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[18]), .operation(ALU_control[1:0]), .result(ALU_result[19]), .cout(ALU_cout[19]));
alu_top ALU20(.src1(src1[20]), .src2(src2[20]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[19]), .operation(ALU_control[1:0]), .result(ALU_result[20]), .cout(ALU_cout[20]));
alu_top ALU21(.src1(src1[21]), .src2(src2[21]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[20]), .operation(ALU_control[1:0]), .result(ALU_result[21]), .cout(ALU_cout[21]));
alu_top ALU22(.src1(src1[22]), .src2(src2[22]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[21]), .operation(ALU_control[1:0]), .result(ALU_result[22]), .cout(ALU_cout[22]));
alu_top ALU23(.src1(src1[23]), .src2(src2[23]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[22]), .operation(ALU_control[1:0]), .result(ALU_result[23]), .cout(ALU_cout[23]));
alu_top ALU24(.src1(src1[24]), .src2(src2[24]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[23]), .operation(ALU_control[1:0]), .result(ALU_result[24]), .cout(ALU_cout[24]));
alu_top ALU25(.src1(src1[25]), .src2(src2[25]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[24]), .operation(ALU_control[1:0]), .result(ALU_result[25]), .cout(ALU_cout[25]));
alu_top ALU26(.src1(src1[26]), .src2(src2[26]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[25]), .operation(ALU_control[1:0]), .result(ALU_result[26]), .cout(ALU_cout[26]));
alu_top ALU27(.src1(src1[27]), .src2(src2[27]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[26]), .operation(ALU_control[1:0]), .result(ALU_result[27]), .cout(ALU_cout[27]));
alu_top ALU28(.src1(src1[28]), .src2(src2[28]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[27]), .operation(ALU_control[1:0]), .result(ALU_result[28]), .cout(ALU_cout[28]));
alu_top ALU29(.src1(src1[29]), .src2(src2[29]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[28]), .operation(ALU_control[1:0]), .result(ALU_result[29]), .cout(ALU_cout[29]));
alu_top ALU30(.src1(src1[30]), .src2(src2[30]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[29]), .operation(ALU_control[1:0]), .result(ALU_result[30]), .cout(ALU_cout[30]));
alu_top31 ALU31(.src1(src1[31]), .src2(src2[31]), .less(1'b0), .A_invert(ALU_control[3]), .B_invert(ALU_control[2]), .cin(ALU_cout[30]), .operation(ALU_control[1:0]), .result(ALU_result[31]), .cout(ALU_cout[31]), .set(ALU_set), .overflow(ALU_overflow));


endmodule
