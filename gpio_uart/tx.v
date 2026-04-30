`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: tx
// Description:  UART Transmitter
//////////////////////////////////////////////////////////////////////////////////

module tx(
    input wire clk,
    input wire rst,
    input wire tx_en, // SEND button
    input wire [7:0] tx_input_data,
    output reg tx_output_line
    );
    parameter TX_IDLE = 2'b00;
    parameter TX_START = 2'b01;
    parameter TX_DATA = 2'b10;
    parameter TX_STOP = 2'b11;
    
    reg [7:0] data_reg = 8'h00;
    reg [2:0] bit_idx; 
    reg [1:0] state = TX_IDLE;
    
    always @(posedge clk, posedge rst) begin 
        /* reset should reset all of the LEDs to off and cancel any ongoing transmission*/
        if (rst) begin
            tx_output_line <= 1'b1;
            state <= TX_IDLE;
            bit_idx <= 3'd0;
        end else begin
        case (state)
            TX_IDLE: begin
                tx_output_line <= 1'b1;
                if (tx_en) begin
                    data_reg <= tx_input_data;
                    bit_idx <= 3'd0;
                    state <= TX_START; 
                end
            end
            TX_START: begin
                tx_output_line <= 1'b0; 
                state <= TX_DATA;
            end
            TX_DATA: begin
                tx_output_line <= data_reg[bit_idx];
                if (bit_idx == 3'd7) begin
                    state <= TX_STOP;
                end else begin
                bit_idx <= bit_idx + 1;
                end
            end
            TX_STOP: begin
                tx_output_line <= 1'b1;
                state <= TX_IDLE;
            end
            default: begin
                state <= TX_IDLE;
            end
         endcase
        end   
    end
endmodule // tx
