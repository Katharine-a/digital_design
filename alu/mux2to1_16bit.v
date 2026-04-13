`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 01:11:19 PM
// Design Name: 
// Module Name: mux2to16_1bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 2 to 1 multiplexer for 16-bit wide inputs
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mux2to1_16bit(
    input wire [15:0] a,
    input wire [15:0] b,
    input wire sel,
    output wire [15:0] out
);
    // Wire 16 individual 1-bit muxes together
    genvar i;
    generate
        for (i=0; i < 16; i = i + 1) begin : mux_loop
            mux2to1_1bit m (
                .a(a[i]), 
                .b(b[i]), 
                .sel(sel), 
                .out(out[i])
            );
        end // mux_loop
    endgenerate
endmodule // mux2to1_16bit
