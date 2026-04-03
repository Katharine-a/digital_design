`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2026 11:03:24 AM
// Design Name: 
// Module Name: clk_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_div(
    input wire clk,
    input wire rst,
    output reg output_clk
);
    localparam integer div = 50_000_000;
    // The Basys3 clock is 100MHz (i.e. 100 mil clock cycles per second).
    // In order to blink the led at 1Hz, we toggle it every 50 mil cycles.
    reg [$clog2(div)-1:0] counter;

    always @(posedge clk) begin
        if (rst) begin
            counter <= 0;
            output_clk <= 0;
        end
        else if (counter == (div - 1)) begin
            counter <= 0;
            output_clk <= ~output_clk;
        end
        else begin
            counter <= counter + 1;
        end
    end

endmodule