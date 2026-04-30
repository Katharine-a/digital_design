`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

 
// Module Name: rx_tb
// Description: Testbench for a UART Receiver Module


//////////////////////////////////////////////////////////////////////////////////
module rx_tb();
    reg clk;
    reg rst;
    reg rx_line;
    wire [7:0] rx_data;
    wire rx_done;

    rx uut (
        .clk(clk),
        .rst(rst),
        .rx_line(rx_line),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );
    
    /* Generate a simulated Baud rate */
    localparam BAUD_PERIOD = 10;
    always begin
        #(BAUD_PERIOD/2) clk = ~clk;
    end

    task send_bit(input bit_val);
        begin
            rx_line = bit_val;
            @(posedge clk);
        end
    endtask

    task send_byte(input [7:0] data);
        integer i;
        begin
            send_bit(0);
            for (i = 0; i < 8; i = i + 1) begin
                send_bit(data[i]);
            end
            send_bit(1);
        end
    endtask

    /* Main Testcases */
    initial begin
        clk = 0;
        rst = 1;
        rx_line = 1;
        
        #(BAUD_PERIOD * 2); 
        rst = 0;
        @(posedge clk);

        send_byte(8'h3C);
        
        wait(rx_done);
        repeat(5) @(posedge clk);

        send_byte(8'hA5);
        send_byte(8'h5A);
        
        #(BAUD_PERIOD * 5);
        $finish;
    end

endmodule //rx_tb