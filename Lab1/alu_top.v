`timescale 1ns/1ps
// 110550063
module alu_top(
    /* input */
    src1,       //1 bit, source 1 (A)
    src2,       //1 bit, source 2 (B)
    less,       //1 bit, less
    A_invert,   //1 bit, A_invert
    B_invert,   //1 bit, B_invert
    cin,        //1 bit, carry in
    operation,  //2 bit, operation
    /* output */
    result,     //1 bit, result
    cout        //1 bit, carry out
);

/*==================================================================*/
/*                          input & output                          */
/*==================================================================*/

input src1;
input src2;
input less;
input A_invert;
input B_invert;
input cin;
input [1:0] operation;

output result;
output cout;

/*==================================================================*/
/*                            reg & wire                            */
/*==================================================================*/

reg result, cout;

/*==================================================================*/
/*                              design                              */
/*==================================================================*/

always@(*) begin
    case (operation)
        2'b00: begin
                    result = (src1^A_invert) & (src2^B_invert);
                    cout = 0;
               end
        2'b01: begin
                    result = (src1^A_invert) | (src2^B_invert);
                    cout = 0;
               end
        2'b10: begin
                    result = ((src1^A_invert) ^ (src2^B_invert)) ^ cin;
                    cout = (((src1^A_invert) ^ (src2^B_invert)) & cin) + ((src1^A_invert) & (src2^B_invert));
               end
        2'b11: begin
                    result = less;
                    cout = (((src1^A_invert) ^ (src2^B_invert)) & cin) + ((src1^A_invert) & (src2^B_invert));
               end
        default: begin
                    result = result;
                    cout = cout;
                end
    endcase
end

/* HINT: You may use 'case' or 'if-else' to determine result.
// result
always@(*) begin
    case()
        default: begin
            result = ;
        end
    endcase
end
*/

endmodule
