`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2026 12:36:40 PM
// Design Name: 
// Module Name: mux_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for a 16 to 1 multiplexer on 17-bit wide inputs 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_tb();
// For select bits
reg [3:0] ALUCtrl;

// Store seminal values
reg [16:0] subraction_res = 17'd1;
reg [16:0] addition_res = 17'd2;
reg [16:0] bitwise_or_res = 17'd3;
reg [16:0] bitwise_and_res = 17'd4;
reg [16:0] decrement_res = 17'd5;
reg [16:0] increment_res = 17'd6;
reg [16:0] invert_res = 17'd7;
reg [16:0] arithmetic_shift_left_res = 17'd8;
reg [16:0] arithmetic_shift_right_res = 17'd9;
reg [16:0] logical_shift_left_res = 17'd10;
reg [16:0] logical_shift_right_res  = 17'd11;
reg [16:0] leq_res = 17'd12;
wire [16:0] selected_result;

mux16to1_17bit u_mux16to1_17bit(
    .in0(subraction_res),
    .in1(logical_shift_left_res),
    .in2(decrement_res),
    .in3(arithmetic_shift_left_res),
    .in4(bitwise_or_res),
    .in5(logical_shift_right_res),
    .in6(invert_res),
    .in7(arithmetic_shift_right_res),
    .in8(addition_res),
    .in9(leq_res),
    .in10(increment_res),
    .in11(17'd0),
    .in12(increment_res),
    .in13(17'd0),
    .in14(17'd0),
    .in15(17'd0),
    .sel(ALUCtrl),
    .S_overflow(selected_result)
    );

initial begin : mux_test
ALUCtrl = 4'b0000;
#5
ALUCtrl = 4'b0001;
#5
ALUCtrl = 4'b0010;
#5
ALUCtrl = 4'b0011;
#5
ALUCtrl = 4'b0100;
#5
ALUCtrl = 4'b0101;
#5
ALUCtrl = 4'b0110;
#5
ALUCtrl = 4'b1100;
#5
ALUCtrl = 4'b1110;
#5
ALUCtrl = 4'b1000;
#5
ALUCtrl = 4'b1010;
#5
ALUCtrl = 4'b1001;
#5
$finish;
end
endmodule
