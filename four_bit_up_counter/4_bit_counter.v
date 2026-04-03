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

module counter_4bit(
    input wire clk,
    input wire async_rst,
    output wire [3:0] count // does this have to be a wire, as in the spec
    );
    
    reg [3:0] count_reg;
    assign count = count_reg;
    
    always@(posedge clk, posedge async_rst) begin : proc_count
        if (async_rst) begin
            count_reg <= 4'd0;
        end else begin
            count_reg <= count_reg + 4'd1;
        end
    end // block: proc_count

endmodule // counter_4bit
