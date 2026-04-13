`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:15:30 AM
// Design Name: 
// Module Name: decrement
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Decrement module for ALU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module decrement(
    input wire [15:0] A,
    output wire [15:0] S,
    output wire overflow
    );
    
    adder_16bit u_decrement_16bit(
        .A(A),
        .B(16'hFFFF), // -1 in 2's complement
        .Cin(1'b0),
        .S(S),
        .Cout(),
        .V(overflow)
    );
endmodule // decrement
