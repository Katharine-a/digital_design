`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:15:30 AM
// Design Name: 
// Module Name: subtraction
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Performs A-B. A and B are signed 16-bit values
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module subtraction(
    input wire [15:0] A, B,
    output wire [15:0] S,
    output wire overflow
    );
    
    wire [15:0] not_B;
    // Bitwise invert B
    bitwise_not u_bitwise_not (
        .A(B),
        .S(not_B)
        );
    
    // Add A + (~B+1). Equivalent to A + (~B+1)
    adder_16bit subtract_adder (
        .A(A), 
        .B(not_B),
        .Cin(1'b1), // +1 for (~B+1) negation
        .S(S), 
        .Cout(),
        .V(overflow)
    );
    
endmodule // subtraction
