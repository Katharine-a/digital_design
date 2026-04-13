`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 10:15:30 AM
// Design Name: 
// Module Name: zero_flag
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Sets the zero flag to 1 iff S equals 16'b0
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module zero_flag(
    input wire [15:0] S,
    output wire zero
    );
    
    nor (zero,
         S[0], S[1], S[2], S[3], S[4], S[5], S[6], S[7],
         S[8], S[9], S[10], S[11], S[12], S[13], S[14], S[15]
         );
         
endmodule // zero_flag
