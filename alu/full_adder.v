`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2026 11:03:24 AM
// Design Name: 
// Module Name: full_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Full adder 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module full_adder(
    input wire A, B,
    input wire Cin,
    output wire S, Cout
);
    wire a_xor_b, cin_and_axb, a_and_b;
    xor (a_xor_b, A, B);
    xor (S, Cin, a_xor_b);
    and (cin_and_axb, Cin, a_xor_b);
    and (a_and_b, A, B);
    or  (Cout, cin_and_axb, a_and_b);
endmodule // full_adder
