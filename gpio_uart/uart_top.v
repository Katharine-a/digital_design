`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCLA
// Engineer: 
// 
// Create Date: 04/22/2026 10:24:09 AM
// Design Name: 
// Module Name: uart_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Top-level module for UART hardware communication protocol
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module uart_top(
    input wire clk,              
    input wire rst,              
    input wire btn_send,         
    input wire [7:0] sw,         
    input wire rx_serial,        
    output wire tx_serial,       
    output wire [7:0] led        
    );

    /* Internal Signals */
    wire tick_9600;
    wire tick_153k;
    reg  clk_9600_reg = 0;
    reg  clk_153k_reg = 0;
    wire stable_btn_send;

    baud_9600 baud_gen_tx (
        .clk(clk),
        .rst(rst),
        .tick(tick_9600)
    );

    /* Button Debouncer */
    btn_debounce u_btn_debounce (
        .pb_1(btn_send),
        .clk(clk),
        .pb_out(stable_btn_send)
    );

    /* Transmitter Instance */
    tx transmitter_inst (
        .clk(tick_9600),
        .rst(rst),
        .tx_en(stable_btn_send),
        .tx_input_data(sw),
        .tx_output_line(tx_serial)
    );

    /* Receiver Instance */
    rx receiver_inst (
        .clk(tick_9600),
        .rst(rst),
        .rx_line(rx_serial),
        .rx_data(led),
        .rx_done()
    );
endmodule