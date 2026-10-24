`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 15:39:39
// Design Name: 
// Module Name: debouncer
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


module debouncer #(
    parameter integer FREQ = 50_000_000,
    parameter integer DB_TIME = 20
    )(
    input clk,
    input areset_n,
    input b_in,
    output reg b_out
    );
    
    localparam integer DB_COUNT = (FREQ / 1000) * DB_TIME;
    localparam integer DB_BITS = (DB_COUNT <= 1) ? 1 : $clog2(DB_COUNT);
    
    reg syn1, syn2;
    
    reg [DB_BITS-1:0] count;
    
    always @(posedge clk, negedge areset_n) begin
        if(!areset_n) begin
            syn1 <= 1'b0;
            syn2 <= 1'b0;
        end   
        else begin
            syn1 <= b_in;
            syn2 <= syn1;
        end 
    end
    
    always @(posedge clk, negedge areset_n) begin
        if(!areset_n) begin
            count <= 1'b0;
            b_out <= 1'b0;
        end    
        else if (b_out == syn2) begin
            count <= 1'b0;        
        end
        else if (count == DB_COUNT-1) begin
            b_out <= syn2;
            count <= 1'b0;        
        end 
        else begin
            count <= count + 1;        
        end
    end
    
    
    
    
    
endmodule
