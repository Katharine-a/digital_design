`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: rx
// Description: UART Receiver
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module rx(
    input wire clk,
    input wire rst,
    input wire rx_line, 
    output reg [7:0] rx_data,
    output reg rx_done
    );

    parameter RX_START = 2'b01;
    parameter RX_DATA  = 2'b10;
    parameter RX_STOP  = 2'b11;
    
    reg [1:0] state;
    reg [2:0] bit_idx;
    reg [7:0] shift_reg;
    
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            state <= RX_START;
            rx_data <= 8'd0;
            rx_done <= 1'b0;
            bit_idx <= 3'd0;
            shift_reg <= 8'd0;
        end else begin
            case (state)
                RX_START: begin
                    rx_done <= 1'b0;
                    if (rx_line == 1'b0) begin 
                        state <= RX_DATA; 
                        bit_idx <= 3'd0;
                    end
                end

                RX_DATA: begin
                    shift_reg[bit_idx] <= rx_line;
                    
                    if (bit_idx == 3'd7) begin
                        state <= RX_STOP;
                    end else begin
                        bit_idx <= bit_idx + 1'b1;
                    end
                end

                RX_STOP: begin
                    if (rx_line == 1'b1) begin
                        rx_data <= shift_reg;
                        rx_done <= 1'b1;
                    end
                    state <= RX_START;
                end

                default: state <= RX_START;
            endcase
        end
    end
endmodule // rx
