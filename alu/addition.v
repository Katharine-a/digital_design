`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:15:30 AM
// Design Name: 
// Module Name: addition
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Performs addition of two 16-bit values
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module addition(
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [15:0] S,
    output wire overflow
    );
    
    adder_16bit u_adder_16bit(
        .A(A),
        .B(B),
        .Cin(1'b0),
        .S(S),
        .Cout(),
        .V(overflow)
    );
        
endmodule // addition
