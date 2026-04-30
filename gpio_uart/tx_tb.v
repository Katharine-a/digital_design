`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: tx_tb
// Description: Testbench for a UART Transmitter Module
//////////////////////////////////////////////////////////////////////////////////

module tx_tb();
    reg clk;
    reg rst;
    reg tx_en;
    reg [7:0] tx_input_data;
    wire tx_output_line;
    
    tx u_tx(
    .clk(clk),
        .rst(rst),
        .tx_en(tx_en),
        .tx_input_data(tx_input_data),
        .tx_output_line(tx_output_line)
    );
    
    localparam BAUD_PERIOD = 10;
    always begin
        #(BAUD_PERIOD/2) clk = ~clk;
    end
    
initial begin
        clk = 0;
        rst = 1;
        tx_en = 0;
        tx_input_data = 8'h00;

        #(BAUD_PERIOD * 2);
        rst = 0;
        #(BAUD_PERIOD);

        tx_input_data = 8'hA5; /* Expected sequence: Start(0), 1, 0, 1, 0, 0, 1, 0, 1, Stop(1) */
        tx_en = 1;
        #(BAUD_PERIOD);
        tx_en = 0;

        #(BAUD_PERIOD * 11);

        tx_input_data = 8'hFF;
        tx_en = 1;
        #(BAUD_PERIOD);
        tx_en = 0;
        
        #(BAUD_PERIOD * 3);
        tx_input_data = 8'h00;
        
        #(BAUD_PERIOD * 8);

        tx_input_data = 8'hAA; 
        tx_en = 1;
        #(BAUD_PERIOD);
        tx_en = 0;

        #(BAUD_PERIOD * 4);
        rst = 1;           
        #(BAUD_PERIOD * 2);
        rst = 0;
        
        #(BAUD_PERIOD * 5);
        $finish;
    end
endmodule  // tx_tb 
    