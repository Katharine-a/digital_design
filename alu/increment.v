`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:15:30 AM
// Design Name: 
// Module Name: increment
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Increment module for ALU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module increment(
    input wire [15:0] A,
    output wire [15:0] S,
    output wire overflow
    );
    
    adder_16bit u_increment_16bit(
        .A(A),
        .B(16'b0),
        .Cin(1'b1), // Perform "+1"
        .S(S),
        .Cout(),
        .V(overflow)
    );
endmodule // increment
