`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:14:45 AM
// Design Name: 
// Module Name: logical_shift_right
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


module logical_shift_right(
    input wire [15:0] A,B,
    output wire [15:0] S,
    output wire overflow
);
    wire [15:0] shift_by_1, shift_by_2, shift_by_4, shift_by_8, S;
    wire shift_ge_16;
    or (shift_ge_16, B[4],  B[5],  B[6],  B[7],  B[8],  B[9],
                     B[10], B[11], B[12], B[13], B[14], B[15]
    );
    assign overflow = 1'b0; // overflow is always 0 for logical shifts
    
    // Stage 0 : Shift by 1
    mux2to1_16bit M0 (
        .a(A),
        .b({1'b0, A[15:1]}),
        .sel(B[0]),
        .out(shift_by_1)
    );
    
    // Stage 1: Shift by 2
    mux2to1_16bit M1 (
        .a(shift_by_1),
        .b({2'b00, shift_by_1[15:2]}),
        .sel(B[1]),
        .out(shift_by_2)
    );
    
    // Stage 2: Shift by 4
    mux2to1_16bit M2 (
        .a(shift_by_2),
        .b({4'b0000, shift_by_2[15:4]}),
        .sel(B[2]),
        .out(shift_by_4)
    );
    
    // Stage 3: Shift by 8
    mux2to1_16bit M3 (
        .a(shift_by_4),
        .b({8'b0000_0000, shift_by_4[15:8]}),
        .sel(B[3]),
        .out(shift_by_8)
    );
    
    mux2to1_16bit final_out(
        .a(shift_by_8),
        .b(16'b0),
        .sel(shift_ge_16),
        .out(S)
        );
endmodule // logical_shift_right
