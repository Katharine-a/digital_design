`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:15:30 AM
// Design Name: 
// Module Name: alu_top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: ALU 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module alu_top_module(
    input wire [15:0] A, B, 
    input wire [3:0] ALUCtrl,
    output wire [15:0] S,
    output wire zero,
    output wire overflow
);

zero_flag u_zero_flag(
    .S(S),
    .zero(zero)
);

// Subtraction
wire [15:0] S0;
wire overflow0;
wire [16:0] subtraction_S_overflow;
assign subtraction_S_overflow = {S0, overflow0};

subtraction u_subtraction(
    .A(A),
    .B(B),
    .S(S0),
    .overflow(overflow0)
);

// Addition
wire [15:0] S1;
wire overflow1;
wire [16:0] addition_S_overflow;
assign addition_S_overflow = {S1, overflow1};

addition u_addition(
    .A(A),
    .B(B),
    .S(S1),
    .overflow(overflow1)
);

// Bitwise OR
wire [15:0] S2;
wire overflow2;
wire [16:0] bitwise_or_S_overflow;
assign bitwise_or_S_overflow = {S2, overflow2};

bitwise_or u_bitwise_or(
    .A(A),
    .B(B),
    .S(S2),
    .overflow(overflow2)    
);

// Bitwise AND
wire [15:0] S3;
wire overflow3;
wire [16:0] bitwise_and_S_overflow;
assign bitwise_and_S_overflow = {S3, overflow3};

bitwise_and u_bitwise_and(
    .A(A),
    .B(B),
    .S(S3),
    .overflow(overflow3)
);

// Decrement
wire [15:0] S4;
wire overflow4;
wire [16:0] decrement_S_overflow;
assign decrement_S_overflow = {S4, overflow4};
decrement u_decrement(
    .A(A),
    .S(S4),
    .overflow(overflow4)  
);

// Increment
wire [15:0] S5;
wire overflow5;
wire [16:0] increment_S_overflow;
assign increment_S_overflow = {S5, overflow5};

increment u_increment(
    .A(A),
    .S(S5),
    .overflow(overflow5)  
);

// Invert
wire [15:0] S6;
wire overflow6;
wire [16:0] invert_S_overflow;
assign invert_S_overflow = {S6, overflow6};

invert u_invert(
    .A(A),
    .S(S6),
    .overflow(overflow6)
);

// Arithmetic Shift Left
wire [15:0] S7;
wire overflow7;
wire [16:0] arithmetic_shift_left_S_overflow;
assign arithmetic_shift_left_S_overflow = {S7, overflow7};

arithmetic_shift_left u_arithmetic_shift_left(
    .A(A),
    .B(B),
    .S(S7),
    .overflow(overflow7)  
);

// Arithmetic Shift Right
wire [15:0] S8;
wire overflow8;
wire [16:0] arithmetic_shift_right_S_overflow;
assign arithmetic_shift_right_S_overflow = {S8, overflow8};

arithmetic_shift_right u_arithmetic_shift_right(
    .A(A),
    .B(B),
    .S(S8),
    .overflow(overflow8)
);

// Logical Shift Left
wire [15:0] S9;
wire overflow9;
wire [16:0] logical_shift_left_S_overflow;
assign logical_shift_left_S_overflow = {S9, overflow9};

logical_shift_left u_logical_shift_left(
    .A(A),
    .B(B),
    .S(S9),
    .overflow(overflow9)
);

// Logical Shift Right
wire [15:0] S10;
wire overflow10;
wire [16:0] logical_shift_right_S_overflow;
assign logical_shift_right_S_overflow = {S10, overflow10};

logical_shift_right u_logical_shift_right(
    .A(A),
    .B(B),
    .S(S10),
    .overflow(overflow10)
);

// Set on Less than or Equal
wire [15:0] S11;
wire overflow11;
wire [16:0] leq_S_overflow;
assign leq_S_overflow = {S11, overflow11};

leq u_leq(
    .A(A),
    .B(B),
    .S(S11),
    .overflow(overflow11)
);

// Final Output
wire [16:0] S_overflow;
assign S = S_overflow[16:1];
assign overflow =  S_overflow[0];


// Select the correct output
mux16to1_17bit u_mux16to1_17bit(
    subtraction_S_overflow,
    logical_shift_left_S_overflow,
    decrement_S_overflow,
    arithmetic_shift_left_S_overflow,
    bitwise_or_S_overflow,
    logical_shift_right_S_overflow,
    invert_S_overflow,
    arithmetic_shift_right_S_overflow,
    addition_S_overflow,
    leq_S_overflow,
    increment_S_overflow,
    17'b0,                  // don't cares value
    bitwise_and_S_overflow,
    17'b0,                  // don't care value
    17'b0,                  // don't care value
    17'b0,                  // don't care value 
    ALUCtrl,
    S_overflow
);
endmodule // alu_top_module
