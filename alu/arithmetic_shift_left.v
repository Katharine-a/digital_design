`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 01:11:19 PM
// Design Name: 
// Module Name: arithmetic_shift_left
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
module arithmetic_shift_left(
    input wire [15:0] A, B,
    output wire [15:0] S,
    output wire overflow
);   
     
    logical_shift_left u_logical_shift_left(
        .A(A),
        .B(B),
        .S(S),
        .overflow()
    );
    
    // Overflow occurs if the sign bit of the result (S[15]) 
    // is different from the original sign bit (A[15]).
    xor(overflow, S[15], A[15]);
        
endmodule // arithmetic_shift_left
