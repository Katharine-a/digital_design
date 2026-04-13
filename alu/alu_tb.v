`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 10:11:59 AM
// Design Name: 
// Module Name: alu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: ALU Testbench 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module alu_tb();
reg [15:0] A,B;
reg [3:0] ALUCtrl;
wire [15:0] S;
wire zero;
wire overflow;

alu_top_module u_alu_top_module(
    .A(A),
    .B(B),
    .ALUCtrl(ALUCtrl),
    .S(S),
    .zero(zero),
    .overflow(overflow)
);

reg [15:0] expected_S;
reg expected_zero;
reg expected_overflow;
wire test_failed;

assert_result u_assert_result(
    .S(S),
    .overflow(overflow),
    .zero(zero),
    .expected_S(expected_S),
    .expected_zero(expected_zero),
    .expected_overflow(expected_overflow),
    .test_failed(test_failed)
);
initial begin : alu_test

/** Subtraction **/
ALUCtrl = 4'b0000;

/* Positive difference, no overflow */
A = 16'h4;
B = 16'h1;
expected_S = 16'h3;
expected_zero = 0;
expected_overflow = 0;
#5

/* Negative difference, no overflow */
A = 16'h6;
B = 16'hA;
expected_S = 16'hfffc;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Negative difference, both A, B are negative values, no overflow */
A = 16'h8000;
B = 16'h8001;
expected_S = 16'hffff;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Zero difference, no overflow */
A = 16'h5000;
B = 16'h5000;
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5

A = 16'h8000;
B = 16'h8000;
#5

/* Non-zero difference, A is negative, overflow */
A = 16'h8000;
B = 16'h1;
expected_S = 16'h7fff;
expected_zero = 1'b0;
expected_overflow = 1'b1;
#5

/* Positive difference, overflow */
A = 16'h0000;
B = 16'h8000;
expected_S = 16'h8000;
expected_zero = 1'b0;
expected_overflow = 1'b1;
#5

/** Addition **/
ALUCtrl = 4'b0001;

/* Non-zero positive sum, no overflow */
A = 16'ha;
B = 16'h5;
expected_S = 16'hf;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Negative sum, no overflow */
A = 16'hfb;
B = 16'h2;
expected_S = 16'hfd;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Non-zero sum, overflow */
A = 16'h7fff;
B = 16'h1;
expected_S = 16'h8000;
expected_zero = 1'b0;
expected_overflow = 1'b1;
#5

/* Sum equals 0 */
A = 16'hffb0;
B = 16'h0050;
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5

/** Bitwise OR **/ 
ALUCtrl = 4'b0010; 

/* Simple OR, high-bit test */ 
A = 16'h00f0; 
B = 16'h0f00;
expected_S = 16'h0ff0;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5 

/* Test cross-bits */ 
A = 16'h8001; B = 16'h0002; 
expected_S = 16'h8003;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5 

/* Bitwise OR on all zeros */
A = 16'h0000;
B = 16'h0000;
expected_S = 16'h0000;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5
 
/* Bitwise OR on all ones */
A = 16'hffff;
B = 16'h0000;
expected_S = 16'hffff;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/** Bitwise AND **/ 
ALUCtrl = 4'b0011; 
/* Simple AND, zero result */ 
A = 16'h0f0f; 
B = 16'h00ff;
expected_S = 16'h000f;
expected_zero = 1'b0;
expected_overflow = 1'b10;
#5 

/* Simple AND, non-zero result */
A = 16'h1234; 
B = 16'h00ff; 
expected_S = 16'h0034;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Simple AND, zero result */
A = 16'h0f00; 
B = 16'h00ff; 
expected_S = 16'h0000;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5 

/** Decrement **/
ALUCtrl = 4'b0100;

/* Decrement zero */
A= 16'h0000;
expected_S = 16'hffff;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Decrement 1 */
A= 16'h1;
expected_S = 16'h0;
expected_zero = 1'h1;
expected_overflow = 1'b0;
#5

/* Decrement 0xABCD (unsigned 43981, signed -21555) */
A= 16'habcd;
expected_S = 16'habcc;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Test overflow */
A= 16'h8000;
expected_S = 16'h7fff;
expected_zero = 1'b0;
expected_overflow = 1'b1;
#5

/** Increment **/
ALUCtrl = 4'b0101;

/* Increment zero */
A= 16'h0000;
expected_S = 16'h1;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Increment  -1 */
A= 16'hffff;
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5

/* Increment 0xABCD (unsigned 43981, signed -21555) */
A= 16'habcd;
expected_S = 16'habce;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Test overflow */
A= 16'h7fff;
expected_S = 16'h8000;
expected_zero = 1'b0;
expected_overflow = 1'b1;
#5

/** Invert **/
ALUCtrl = 4'b0110;

/* Negation of zero */
A= 16'h0000;
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5

/* Negation of -1 */
A= 16'hffff;
expected_S = 16'h0001;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Negation of 0xABCD (unsigned 43981, signed -21555) */
A= 16'habcd;
expected_S = 16'h5433;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Test overflow */
A= 16'h8000;
expected_S = 16'h8000;
expected_zero = 1'b0;
expected_overflow = 1'b1;
#5

/** Arithmetic Shift Left **/
ALUCtrl = 4'b1100;

/* Shift by more than 15 places, trigger overflow */
A = 16'hffff;
B = 16'd16;
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b1;
#5

/* Shift by more than 15 places, no overflow */
A = 16'h0fff;
B = 16'd16;
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5

/* Shift by 15 places */
A = 16'hffff;
B = 16'd15;
expected_S = 16'h8000;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/** Arithmetic Shift Right **/
ALUCtrl = 4'b1110;

/* Shift negative value by more than 15 places */
A = 16'h8000;
B = 16'd16;
expected_S = 16'hffff;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Shift positive value by more than 15 places */
A = 16'h4000;
B = 16'd16;
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5

/* Shift positive value by 4 places */
A = 16'h0fff;
B = 16'd4;
expected_S = 16'h00ff;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Shift negative value by 4 places */
A = 16'hff0f;
B = 16'd4;
expected_S = 16'hfff0;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

A = 16'h8001; B = 16'h1;
expected_S = 16'hc000;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/** Logical Shift Left **/
ALUCtrl = 4'b1000;

/* Normal left shift by 4 places */
A = 16'h1;
B = 16'd4;
expected_S = 16'h10;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Normal left shift by 15 places */
A = 16'hff;
B = 16'd15;
expected_S = 16'h8000;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/* Shift more than 16 */
A = 16'hffff;
B = 16'd16;
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5

/** Logical Shift Right **/
ALUCtrl = 4'b1010;

/* Normal Shift by 6 places */
A = 16'h0ff0;
B = 16'd6;
expected_S = 16'h3f;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5
 
/* Normal Shift by 15 places */
A = 16'hffff;
B = 16'd15;
expected_S = 16'h1;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5
 
 /* Shift by 16 places */
A = 16'hffff;
B = 16'd16;
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5
 
/** Set on Less than or Equal **/
ALUCtrl = 4'b1001;
/* Set leq flag on equal values */
A = 16'h0ff0;
B = 16'h0ff0;
expected_S = 16'h1;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5
 
 /* Set leq flag on A < B, both negative */
A = 16'hfff0;
B = 16'hffff;
expected_S = 16'h1;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5
 
/* Set on A < B (positive) */
A = 16'h0003;
B = 16'h0005;
expected_S = 16'h0001;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5


 /* Do not set leq flag on A > B (both negative) */
A = 16'hffff;
B = 16'hff00;
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5
 
/* Do not set on A > B (both positive) */
A = 16'h0006;
B = 16'h0002;
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b0;
#5

/* Set on A negative <= B positive */
A = 16'hfffe; // -2
B = 16'h0001;
expected_S = 16'h0001;
expected_zero = 1'b0;
expected_overflow = 1'b0;
#5

/** Invalid ALUCtrl opcodes **/
expected_S = 16'h0;
expected_zero = 1'b1;
expected_overflow = 1'b0;

ALUCtrl = 4'b1101;
#5
ALUCtrl = 4'b1011;
#5
ALUCtrl = 4'b0111;
#5
ALUCtrl = 4'b1111;
#5

$finish;
end
endmodule // alu_tb
