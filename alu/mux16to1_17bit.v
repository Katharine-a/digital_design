`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:15:30 AM
// Design Name: 
// Module Name: mux16to1_17bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 16 to 1 multiplexer for 18-bit wide inputs. Composed of 15, 2 to 1 muxes
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux16to1_17bit(
    input wire [16:0] in0, in1, in2, in3, in4, in5, in6, in7,
    input wire [16:0] in8, in9, in10, in11, in12, in13, in14, in15,
    input wire [3:0] sel,
    output wire [16:0] S_overflow
);

    wire [17:0] s1[7:0]; // first layer of muxes has 8 outputs
    wire [17:0] s2[3:0]; // second layer of muxes has 4 outputs
    wire [17:0] s3[3:0]; // third layer of muxes has 2 outputs
    
    // First layer: 16 inputs -> 8 outputs
    mux2to1_17bit m1_0(in0,  in1,  sel[3], s1[0]);
    mux2to1_17bit m1_1(in2,  in3,  sel[3], s1[1]);
    mux2to1_17bit m1_2(in4,  in5,  sel[3], s1[2]);
    mux2to1_17bit m1_3(in6,  in7,  sel[3], s1[3]);
    mux2to1_17bit m1_4(in8,  in9,  sel[3], s1[4]);
    mux2to1_17bit m1_5(in10, in11, sel[3], s1[5]);
    mux2to1_17bit m1_6(in12, in13, sel[3], s1[6]);
    mux2to1_17bit m1_7(in14, in15, sel[3], s1[7]);
    
    // Second layer: 8 inputs -> 4 outputs
    mux2to1_17bit m2_0(s1[0], s1[1], sel[2], s2[0]);
    mux2to1_17bit m2_1(s1[2], s1[3], sel[2], s2[1]);
    mux2to1_17bit m2_2(s1[4], s1[5], sel[2], s2[2]);
    mux2to1_17bit m2_3(s1[6], s1[7], sel[2], s2[3]);
    
    // Third layer: 4 inputs -> 2 outputs
    mux2to1_17bit m3_0(s2[0], s2[1], sel[1], s3[0]);
    mux2to1_17bit m3_1(s2[2], s2[3], sel[1], s3[1]);
    
    // Fourth layer: 2 inputs -> final output
    mux2to1_17bit m4_0(s3[0], s3[1], sel[0], S_overflow);


endmodule // mux16to1_17bit
