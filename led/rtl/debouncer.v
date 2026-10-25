
module debouncer #(
    parameter integer CLK_FREQ_HZ = 1000,
    parameter integer DEBOUNCE_TIME_MS = 5
)(
    input  wire clk,
    input  wire rst_n,
    input  wire button_in,
    output reg  button_out
);

    localparam integer COUNT_MAX =
        (CLK_FREQ_HZ / 1000) * DEBOUNCE_TIME_MS;

    localparam integer COUNT_WIDTH =
        (COUNT_MAX <= 1) ? 1 : $clog2(COUNT_MAX);

    reg sync_1;
    reg sync_2;
    reg [COUNT_WIDTH-1:0] count;

    // Synchronize the asynchronous push-button input
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sync_1 <= 1'b0;
            sync_2 <= 1'b0;
        end else begin
            sync_1 <= button_in;
            sync_2 <= sync_1;
        end
    end

    // Accept a new button state only after it stays stable
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count      <= 0;
            button_out <= 1'b0;
        end else begin
            if (sync_2 == button_out) begin
                count <= 0;
            end else if (count == COUNT_MAX - 1) begin
                button_out <= sync_2;
                count      <= 0;
            end else begin
                count <= count + 1'b1;
            end
        end
    end

endmodule
