`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:15:30 AM
// Design Name: 
// Module Name: invert
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Signed Bitwise inversion of 16-bit input, 
// functionally equivalent to multiplying the input by -1
// S = ~A + 1
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module invert(
    input [15:0] A,
    output [15:0] S,
    output overflow
    );
    wire [15:0] unsgn_bitwise_invert;
    bitwise_not u_bitwise_not(
        .A(A),
        .S(unsgn_bitwise_invert)
    );
    
    increment u_increment(
        .A(unsgn_bitwise_invert),
        .S(S),
        .overflow()
    );
    
    // Overflow Detection for INT_MIN (1000_0000_0000_0000)
    or (lower_bits_or, A[0], A[1], A[2], A[3], A[4], A[5], A[6], 
                       A[7], A[8], A[9], A[10], A[11], A[12], A[13], A[14]);

    // Overflow = A[15] AND NOT(lower_bits_or)
    wire not_lower;
    wire lower_bits_or;
    not (not_lower, lower_bits_or);
    and (overflow, A[15], not_lower);
endmodule // invert

//////////////////////////////////////////////////////////////////////////////////

