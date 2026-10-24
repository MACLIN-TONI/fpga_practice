`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2026 15:36:21
// Design Name: 
// Module Name: led_7_segment
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


module led_7_segment(
    input clk,
    input areset_n,
    input b_in,
    output reg [3:0] digi_sel,
    output reg [7:0] seg
    );
    
    wire db;
    reg prev_db;
    integer count;
    
    debouncer d1(
        .clk(clk),
        .areset_n(areset_n),
        .b_in(b_in),
        .b_out(db)
    );
    
    always @(posedge clk, negedge areset_n) begin
        if(!areset_n) begin
            prev_db <= 1'b0;
        end
        else begin
            prev_db <= db;
        end
    end
    
    always @(posedge clk, negedge areset_n) begin
        if(!areset_n) begin
            count <= 0;
        end
        else if(db && ~prev_db) begin
            count <= count + 1; 
        end    
        else begin
            count <= count;
        end
    end
    
    reg [3:0] ones;
    reg [3:0] tens;
    
    reg digit;
    reg [3:0] f_count;
    
    always @(posedge clk, negedge areset_n) begin
        if(!areset_n) begin
            digit <= 1'b0;
            f_count <= 1'b0;
        end
        else if(f_count == 15) begin
            digit <= ~digit;
            f_count <= 0;
        end
        else begin
            f_count <= f_count + 1;
        end
        
    end
    
    always @(count) begin
        ones = count % 10;
        tens = count / 10;
    end
    
    always @(digit) begin
        if(!digit) begin
            digi_sel = 4'b1000;
            case (ones)
                0: seg = 8'b00000011;
                1: seg = 8'b10011111;
                2: seg = 8'b00100101;
                3: seg = 8'b00001101;
                4: seg = 8'b10011001;
                5: seg = 8'b01001001;
                6: seg = 8'b01000001;
                7: seg = 8'b00011111;
                8: seg = 8'b00000001;
                9: seg = 8'b00001001;
                default: seg = 8'b11111111;
            endcase
        end
        else begin
            digi_sel = 4'b0100;
            case (tens)
                0: seg = 8'b00000011;
                1: seg = 8'b10011111;
                2: seg = 8'b00100101;
                3: seg = 8'b00001101;
                4: seg = 8'b10011001;
                5: seg = 8'b01001001;
                6: seg = 8'b01000001;
                7: seg = 8'b00011111;
                8: seg = 8'b00000001;
                9: seg = 8'b00001001;
                default: seg = 8'b11111111;
            endcase
        end
    end
    
endmodule
