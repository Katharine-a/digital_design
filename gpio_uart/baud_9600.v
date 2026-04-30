`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2026 10:24:09 AM
// Design Name: 
// Module Name: baud_9600
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Clock Divider producing 9600 Hz clock. Acts as Baud rate.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module baud_9600(
    input  wire clk,
    input  wire rst,
    output reg  tick
);
    parameter CLK_FREQ = 100_000_000;
    parameter BAUD     = 9600;
    
    /* TOGGLE every half-period. */
    /* 100,000,000 / 9600 / 2 = 5208.33 */
    parameter integer HALF_BIT_PERIOD = CLK_FREQ / (BAUD * 2);

    reg [$clog2(HALF_BIT_PERIOD)-1:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            tick  <= 0;
        end else begin
            if (count >= (HALF_BIT_PERIOD - 1)) begin
                count <= 0;
                tick  <= ~tick; 
            end else begin
                count <= count + 1;
            end
        end
     end
endmodule // baud_9600
