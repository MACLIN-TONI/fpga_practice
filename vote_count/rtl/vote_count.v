`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 14:20:26
// Design Name: 
// Module Name: vote_count
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


module vote_count(
    input clk,
    input areset_n,
    input v_end,
    input b1,
    input b2,
    output reg out1,
    output reg out2
    );
    wire db1,db2;
    
    debouncer d1(
        .clk(clk),
        .areset_n(areset_n),
        .b_in(b1),
        .db_out(db1)
    );
    
    debouncer d2(
        .clk(clk),
        .areset_n(areset_n),
        .b_in(b2),
        .db_out(db2)
    );
    
    reg [3:0] c1, c2;
    reg prev_db1, prev_db2;
    
    always @(posedge clk, negedge areset_n) begin
        if(!areset_n) begin
            prev_db1 <= 1'b0;
            prev_db2 <= 1'b0;
        end
        else begin
            prev_db1 <= db1;
            prev_db2 <= db2;
        end    
    end
    
    always @(posedge clk, negedge areset_n, posedge v_end) begin
        if(!areset_n) begin
            c1 <= 1'b0;
            c2 <= 1'b0;
            out1 <= 1'b0;
            out2 <= 1'b0;
        end
        else if(v_end) begin
            if(c1 == c2) begin
                out1 <= 1'b1;
                out2 <= 1'b1;
            end
            else if(c1 > c2) begin
                out1 <= 1'b1;
                out2 <= 1'b0;
            end
            else if (c1 < c2) begin
                out1 <= 1'b0;
                out2 <= 1'b1;
            end
            else begin
                out1 <= 1'b0;
                out2 <= 1'b0;
            end
            
        end
        else if(db1 && ~prev_db1) begin
            c1 <= c1 + 1;
        end
        else if(db2 && ~prev_db2) begin
            c2 <= c2 + 1;
        end
        else begin
            c1 <= c1;
            c2 <= c2;        
        end
    end
    
    
    
    
endmodule
