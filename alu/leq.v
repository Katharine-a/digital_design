`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:15:30 AM
// Design Name: 
// Module Name: leq
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Set on A is Less than or Equal to B. Handles signed values. A - B <= 0 iff A <= B
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module leq(
    input wire [15:0] A, B,
    output wire [15:0] S,
    output wire overflow
);

wire [15:0] sub_S;
wire sub_overflow;
wire is_zero;
wire sign_xor_v;
wire leq_result;

assign S = {15'b0, leq_result};
assign overflow = 1'b0;

subtraction u_subtraction(
    .A(A),
    .B(B),
    .S(sub_S),
    .overflow(sub_overflow)
);

zero_flag u_zero_flag(
    .S(sub_S),
    .zero(is_zero)
);

// if (Sign != Overflow), then A < B
xor (sign_xor_v, sub_S[15], sub_overflow);

// If (A < B) OR ( A == B), then A <=B
or (leq_result, sign_xor_v, is_zero);

endmodule //leq
