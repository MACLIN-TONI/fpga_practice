module freq_div (
    input sys_clk,
    input areset_n,
    output reg real_clk
);

    parameter CLK_FREQ = 25_000_000;
    parameter FREQ_BITS = $clog2(CLK_FREQ);
    reg [FREQ_BITS-1:0] f_count;

    always @(posedge sys_clk, negedge areset_n) begin
        if(!areset_n) begin
            real_clk <= 1'b0;
            f_count <= 0;
        end
        else if(f_count == CLK_FREQ-1) begin
            real_clk <= ~real_clk;
            f_count <= 0;
        end
        else begin
            f_count <= f_count + 1;
        end
    end
endmodule