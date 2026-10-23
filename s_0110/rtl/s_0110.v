`timescale 1ns / 1ps
module s_0110 (
    input clk,
    input en,
    input areset_n,
    input in, 
    output reg out
);
    wire d_en;
    debouncer d1(
        .clk(clk),
        .rst_n(areset_n),
        .button_in(en),
        .button_out(d_en)
    );

    parameter a = 3'b000;
    parameter b = 3'b001;
    parameter c = 3'b010;
    parameter d = 3'b011;
    parameter e = 3'b100;

    reg [2:0] state, next;
    reg prev_den;
    
    always @(posedge clk, negedge areset_n) begin
        if(!areset_n) begin
            prev_den <= 1'b0;
        end
        else begin
            prev_den <= d_en;
        end
    end
    

    always @(posedge clk, negedge areset_n) begin
        if(~areset_n) begin
            state <= a;
        end
        else if(d_en && ~prev_den) begin
            state <= next;
        end
        else begin
            state <= state;
        end
    end

    always @(state, in) begin
        next = a;

        case (state) 
            a: begin
                if(in) begin
                    next = a;
                end
                else begin
                    next = b;
                end
            end

            b: begin
                if(in) begin
                    next = c;
                end
                else begin
                    next = b;
                end
            end

            c: begin
                if(in) begin
                    next = d;
                end
                else begin
                    next = b;
                end
            end

            d: begin
                if(in) begin
                    next = a;
                end
                else begin
                    next = e;
                end
            end

            e: begin
                if(in) begin
                    next = a;
                end
                else begin
                    next = b;
                end
            end
        endcase
    end

    always @(state) begin
        out = 0;
        if (state == e) begin
            out = 1;
        end
        else begin
            out = 0;
        end
    end

endmodule