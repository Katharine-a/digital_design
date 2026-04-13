`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2026 07:42:36 PM
// Design Name: 
// Module Name: assert_result
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Helper module for ALU testing 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module assert_result(
    input wire [15:0] S,
    input wire overflow,
    input wire zero,
    input wire [15:0] expected_S,
    input wire expected_zero,
    input wire expected_overflow,
    output wire test_failed
    );
    
assign test_failed = (S !== expected_S) || 
                         (overflow !== expected_overflow) || 
                         (zero !== expected_zero);
endmodule // assert_result
