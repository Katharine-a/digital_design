`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 01:11:19 PM
// Design Name: 
// Module Name: mux2to1_1bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 2 to 1 multiplexer for 1-bit inputs 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux2to1_1bit(
    input wire a,
    input wire b,
    input wire sel,
    output wire out
);
    wire sel_n, w1, w2;
    
    not (sel_n, sel);   // inverted select
    and (w1, a, sel_n); // input A selection
    and (w2, b, sel);   // input B selection
    or  (out, w1, w2);   // combine results
endmodule // mux2to1_1bit
