`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2026 10:05:22 AM
// Design Name: 
// Module Name: btn_debounce
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Button Debouncing module and helpers.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module btn_debounce(
    input pb_1,
    input clk,
    output pb_out
);
    wire slow_clk;
    wire Q1,Q2,Q2_bar,Q0;
    clock_div u1(clk,slow_clk);
    my_dff d0(slow_clk, pb_1,Q0 );

    my_dff d1(slow_clk, Q0,Q1 );
    my_dff d2(slow_clk, Q1,Q2 );
    assign Q2_bar = ~Q2;
    assign pb_out = Q1 & Q2_bar;
endmodule // btn_debounce

// Slow clock for debouncing 
module clock_div(
    input Clk_100M,
    output reg slow_clk
);
    reg [26:0]counter=0;
    always @(posedge Clk_100M)
    begin
        counter <= (counter>=249999) ? 0:counter+1;
        slow_clk <= (counter < 125000) ? 1'b0:1'b1;
    end
endmodule // clock_div

// D-flip-flop
module my_dff(input DFF_CLOCK, D, output reg Q);

    always @ (posedge DFF_CLOCK) begin
        Q <= D;
    end
endmodule // my_dff
