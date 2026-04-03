`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2026 11:10:08 AM
// Design Name: 
// Module Name: clk_div_tb
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

module counter_4bit_tb();
    reg  tb_clk;
    reg  tb_async_rst;
    wire [3:0] tb_count;
    
    counter_4bit UUT(
        .clk        (tb_clk),
        .async_rst  (tb_async_rst),
        .count      (tb_count)
        );
        
    always #5 tb_clk = ~tb_clk;
        
    initial begin : test_logic
    tb_clk = 0;
    #5
    tb_async_rst = 0;
    #5
    tb_async_rst = 1;
    #5
    tb_async_rst = 0;
    #60
    tb_async_rst = 1;
    #5                 
    tb_async_rst = 0;  
    #500
        $finish;
    end // test_logic
endmodule // counter_4bit_tb
    