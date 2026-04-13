`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:15:30 AM
// Design Name: 
// Module Name: adder_16bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 16 bit adder
// 
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module adder_16bit(
    input [15:0] A, B,
    input Cin,
    output [15:0] S,
    output Cout,
    output V // overflow
    );
    
    wire [16:0] carry;
    assign carry[0] = Cin;

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : fa_loop
            full_adder fa (
                .A(A[i]), 
                .B(B[i]), 
                .Cin(carry[i]), 
                .S(S[i]), 
                .Cout(carry[i+1])
            );
        end // fa_loop
    endgenerate

    assign Cout = carry[16];
    
    xor(V, carry[15], carry[16]);
    
endmodule // adder_16bit
