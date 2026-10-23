`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 10:27:25
// Design Name: 
// Module Name: led
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


module led(
    input clk,
    input rst_n,
    input b1,
    input b2,
    output reg led_out
    );
    
    wire p1,p2;
    
    debouncer d1(
    .clk(clk),
    .rst_n(rst_n),
    .button_in(b1),
    .button_out(p1)
    );
    
    debouncer d2(
    .clk(clk),
    .rst_n(rst_n),
    .button_in(b2),
    .button_out(p2)
    );
    
    always @(posedge p1 , posedge p2, negedge rst_n) begin
        if(!rst_n) begin
            led_out <= 1'b0;
        end
        else if(p1) begin
            led_out <= 1'b1;
        end    
        else if(p2) begin
            led_out <= 1'b0;
        end
        
    end

endmodule
