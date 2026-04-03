`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2026 10:26:51 AM
// Design Name: 
// Module Name: counter_4bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 4-bit up counter
// 
//////////////////////////////////////////////////////////////////////////////////

module top_module(
    input wire clk,
    input wire rst,
    output wire [3:0] led
);

wire clk_1Hz;

clk_div divider_inst(
    .clk(clk),
    .rst(rst),
    .output_clk(clk_1Hz)
);

counter_4bit counter_inst(
    .clk(clk_1Hz),
    .async_rst(rst),
    .count(led)
);
endmodule // top_module
