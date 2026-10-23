`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 13:57:08
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
    parameter integer CLK_FREQ = 50_000_000,
    parameter integer DEBOUNCE_TIME = 20
    )(
    input clk,
    input areset_n,
    input b_in,
    output reg db_out
    );
    
    localparam integer DB_COUNT = ((CLK_FREQ)/1000) * DEBOUNCE_TIME;
    localparam integer DB_COUNT_BITS = (DB_COUNT <= 1) ? 1 : $clog2(DB_COUNT);
    
    reg [DB_COUNT_BITS-1 : 0] count;
    reg syn1, syn2;
    
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
            db_out <= 1'b0;
        end
        else begin
            if(syn2 == db_out) begin
                count <= 1'b0;
            end
            else if(count == DB_COUNT-1) begin
                db_out <= syn2;
                count <= 1'b0;
            end
            else begin
                count <= count + 1;
            end
        end    
    end
    
endmodule
