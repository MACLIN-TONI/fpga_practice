`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2026 17:11:07
// Design Name: 
// Module Name: digital_clock
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


module digital_clock(
    input clk,
    input areset_n,
    output [3:0] digi_sel,
    output [7:0] seg
    );
    
    parameter CLK_FREQ = 50_000_000;
    parameter FREQ_BITS = $clog2(CLK_FREQ);
    
    
    reg [5:0] sec;
    reg [5:0] min;

    wire [3:0] sec_ones;
    wire [3:0] sec_tens;
    wire [3:0] min_ones;
    wire [3:0] min_tens;

    wire real_clk;

    freq_div fd(
        .sys_clk(clk),
        .areset_n(areset_n),
        .real_clk(real_clk)
    );
    
    // always @(posedge clk, negedge areset_n) begin
    //     if(!areset_n) begin
    //         sec_count <= 0;
    //         sec <= 0;
    //     end
    //     else if (sec_count == CLK_FREQ-1) begin
    //         if(sec == 59) begin
    //             sec <= 0;
    //         end
    //         else begin
    //             sec <= sec + 1;
    //         end
    //         sec_count <= 0;
    //     end
    //     else begin
    //         sec_count <= sec_count + 1;
    //     end
    // end

    always @(posedge real_clk, negedge areset_n) begin
        if(!areset_n) begin
            sec <= 0;
            min <= 0;
        end
        else if (sec == 59) begin
            if(min == 59) begin
                min <= 0;
                sec <= 0;
            end
            else begin
                min <= min + 1;
                sec <= 0;
            end
        end
        else begin
            sec <= sec + 1;
        end
    end
    
    // always @(posedge clk, negedge areset_n) begin
    //     if(!areset_n) begin
    //         min <= 0;
    //     end
    //     else if (sec == 59 && sec_count == CLK_FREQ-1) begin
    //         if(min == 59) begin
    //             min <= 0;
    //         end
    //         else begin
    //             min <= min + 1;
    //         end
            
    //     end
    //     else begin
    //         min <= min;
    //     end
    // end
    
    assign sec_ones = sec % 10;
    assign sec_tens = sec / 10;
    assign min_ones = min % 10;
    assign min_tens = min / 10;
    
    seg_7 dis(
        .clk(clk),
        .areset_n(areset_n),
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .min_ones(min_ones),
        .min_tens(min_tens),
        .digi_sel(digi_sel),
        .seg(seg)
    );
    
endmodule
