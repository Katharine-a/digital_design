`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:15:30 AM
// Design Name: 
// Module Name: and_16bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 16-bit bitwise AND
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module and_16bit(
    input [15:0] A, B,
    output [15:0] S
    );
    // Use a generate loop to create 16 instances of the 'and' gate primitive
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : bitwise_and
            and (S[i], A[i], B[i]); 
        end
    endgenerate
endmodule // and_16bit
