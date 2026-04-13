`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 01:11:19 PM
// Design Name: 
// Module Name: logical_shift_left
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Logarithmic Barrel Shifter
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module logical_shift_left(
    input wire [15:0] A,B,
    output wire [15:0] S,
    output wire overflow
);
    wire [15:0] shift_by_1, shift_by_2, shift_by_4, shift_by_8, S;
    assign overflow = 1'b0; // overflow is always 0 for logical shifts
    
    wire shift_ge_16;
    or (shift_ge_16, B[4],  B[5],  B[6],  B[7],  B[8],  B[9],
                     B[10], B[11], B[12], B[13], B[14], B[15]
    );
    
    // Stage 0 : Shift by 1
    mux2to1_16bit M0 (
        .a(A),
        .b({A[14:0], 1'b0}),
        .sel(B[0]),
        .out(shift_by_1)
    );
    
    // Stage 1: Shift by 2
    mux2to1_16bit M1 (
        .a(shift_by_1),
        .b({shift_by_1[13:0], 2'b00}),
        .sel(B[1]),
        .out(shift_by_2)
    );
    
    // Stage 2: Shift by 4
    mux2to1_16bit M2 (
        .a(shift_by_2),
        .b({shift_by_2[11:0], 4'b0000}),
        .sel(B[2]),
        .out(shift_by_4)
    );
    
    // Stage 3: Shift by 8
    mux2to1_16bit M3 (
        .a(shift_by_4),
        .b({shift_by_4[7:0], 8'b0000_0000}),
        .sel(B[3]),
        .out(shift_by_8)
    );
    
    mux2to1_16bit final_out(
        .a(shift_by_8),
        .b(16'b0),
        .sel(shift_ge_16),
        .out(S)
        );
        
endmodule // logical_shift_left
