`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

 
// Module Name: invalid_frame_rx_tb
// Description: Testbench for a UART Receiver Module for Edge Cases


//////////////////////////////////////////////////////////////////////////////////
module rx_tb();
    reg clk;
    reg rst;
    reg rx_line;
    wire [7:0] rx_data;
    wire rx_done;

    // Unit Under Test (UUT)
    rx uut (
        .clk(clk),
        .rst(rst),
        .rx_line(rx_line),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );
    
    /* Generate Clock */
    localparam BAUD_PERIOD = 10;
    always begin
        #(BAUD_PERIOD/2) clk = ~clk;
    end

task send_bit(input bit_val);
        begin
            rx_line = bit_val;    
            #(BAUD_PERIOD);        
        end
    endtask
    
    // Send Custom Frame
    task send_custom_frame(
        input [15:0] data,     
        input integer num_bits,
        input start_bit,       
        input stop_bit         
    );
        integer i;
        begin
            send_bit(start_bit);
            
            for (i = 0; i < num_bits; i = i + 1) begin
                send_bit(data[i]);
            end
            
            send_bit(stop_bit);
            
            send_bit(1);
        end
    endtask

    /* Main Testcases */
    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        rx_line = 1;
        
        #(BAUD_PERIOD * 2); 
        rst = 0;
        @(posedge clk);

        /* Valid 8-bit Frame (0x3C) */
        send_custom_frame(16'h003C, 8, 0, 1);
        #(BAUD_PERIOD * 5);

        /* Invalid Start Bit (Stays High) */
        // rx_done should remain low.
        send_custom_frame(16'h00AA, 8, 1, 1); 
        #(BAUD_PERIOD * 10);

        /* Invalid Stop Bit (Framing Error) */
        // If rx_line is 0 at Stop state, it shouldn't update rx_data or rx_done.
        send_custom_frame(16'h00A5, 8, 0, 0); 
        #(BAUD_PERIOD * 5);

        /* Data Frame Too Short (4 bits) */
        // This will test if the module gets stuck waiting for more bits.
        send_custom_frame(16'h000F, 4, 0, 1);
        #(BAUD_PERIOD * 10);

        /* Data Frame Too Long (12 bits) */
        // It should take the first 8 and then transition to Stop state.
        send_custom_frame(16'h0ABC, 12, 0, 1);
        $finish;
    end

endmodule