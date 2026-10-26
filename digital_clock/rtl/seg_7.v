`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2026 16:47:13
// Design Name: 
// Module Name: seg_7
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


module seg_7(
    input clk,
    input areset_n,
    input [3:0] sec_ones,
    input [3:0] sec_tens,
    input [3:0] min_ones,
    input [3:0] min_tens,
    output reg [3:0] digi_sel,
    output reg [7:0] seg
    );
        
    reg [1:0] digit;
    reg [3:0] value;
    reg [5:0] f_count;
    
    always @(posedge clk, negedge areset_n) begin
        if(!areset_n) begin
            f_count <= 0;
            digit <= 2'b00;
        end
        else if (f_count == 50) begin
            digit <= digit + 1;
            f_count <= 0;
        end
        else begin
            f_count <= f_count + 1;
        end
    end
    
    always @(*) begin
        case (digit) 
            2'b00: digi_sel = 4'b1000;
            2'b01: digi_sel = 4'b0100;
            2'b10: digi_sel = 4'b0010;
            2'b11: digi_sel = 4'b0001;
            default : digi_sel = 4'b0000;
        endcase
    end
    
    always @(*) begin
        case (digit) 
            2'b00: value = sec_ones;
            2'b01: value = sec_tens;
            2'b10: value = min_ones;
            2'b11: value = min_tens;
            default: value = 4'b0000;
        endcase
    end
    
    always @(*) begin
        case (value)
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
endmodule
