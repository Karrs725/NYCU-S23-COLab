`timescale 1ns/1ps
// 110550063
module alu_top31(
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
    cout,       //1 bit, carry out
    set,        //1 bit, set
    overflow    //1 bit, overflow
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
output set;
output overflow;

/*==================================================================*/
/*                            reg & wire                            */
/*==================================================================*/

reg result, cout, set, overflow;

/*==================================================================*/
/*                              design                              */
/*==================================================================*/

always@(*) begin
    case (operation)
        2'b00: begin
                    result = (src1^A_invert) & (src2^B_invert);
                    cout = 0;
                    set = 0;
                    overflow = 0;
               end
        2'b01: begin
                    result = (src1^A_invert) | (src2^B_invert);
                    cout = 0;
                    set = 0;
                    overflow = 0;
               end
        2'b10: begin
                    result = ((src1^A_invert) ^ (src2^B_invert)) ^ cin;
                    cout = (((src1^A_invert) ^ (src2^B_invert)) & cin) + ((src1^A_invert) & (src2^B_invert));
                    set = 0;
                    overflow = cin ^ cout;
               end
        2'b11: begin
                    result = less;
                    cout = 0;
                    set = ((src1^A_invert) ^ (src2^B_invert)) ^ cin;
                    overflow = 0;
               end
        default: begin
                    result = result;
                    cout = cout;
                    set = 0;
                    overflow = 0;
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
