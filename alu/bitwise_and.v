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
// Description: 16-bit bitwise AND module for ALU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module bitwise_and(
    input wire [15:0] A, B,
    output wire [15:0] S,
    output wire overflow
    );
    
    assign overflow = 1'b0;
    
    and_16bit u_and_16bit(
        .A(A),
        .B(B),
        .S(S)
    );
    
endmodule // bitwise_and
