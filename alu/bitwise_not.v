`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2026 05:37:41 PM
// Design Name: 
// Module Name: bitwise_not
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 16-bit bitwise not 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bitwise_not(
    input wire [15:0] A,
    output wire [15:0] S
    );
    
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : bitwise_not
            not (S[i], A[i]);
        end
    endgenerate
endmodule // bitwise_not
