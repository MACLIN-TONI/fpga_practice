
`timescale 1ns/1ps

module tb_debouncer;

    reg clk;
    reg rst_n;
    reg button_in;
    wire button_out;

    integer PASS = 0;
    integer FAIL = 0;

    // Small values for fast simulation
    debouncer #(
        .CLK_FREQ_HZ(1000),
        .DEBOUNCE_TIME_MS(5)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .button_in(button_in),
        .button_out(button_out)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_debouncer);
    end

    // 100 MHz equivalent simulation clock: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    task check_output;
        input expected;
        input [255:0] test_name;
        begin
            if (button_out === expected) begin
                $display("PASS: %0s", test_name);
                PASS = PASS + 1;
            end else begin
                $display("FAIL: %0s | Expected=%b Actual=%b",
                         test_name, expected, button_out);
                FAIL = FAIL + 1;
            end
        end
    endtask

    // Change button input away from the active clock edge
    task set_button;
        input value;
        begin
            @(negedge clk);
            button_in = value;
        end
    endtask

    // Wait a specified number of rising clock edges
    task wait_cycles;
        input integer cycles;
        integer i;
        begin
            for (i = 0; i < cycles; i = i + 1)
                @(posedge clk);
            #1;
        end
    endtask

    initial begin
        

        rst_n = 0;
        button_in = 0;

        wait_cycles(2);
        check_output(0, "Reset output is LOW");

        @(negedge clk);
        rst_n = 1;

        // Test 1: Short press pulse
        set_button(1);
        wait_cycles(2);
        set_button(0);
        wait_cycles(8);
        check_output(0, "Short pulse rejected");

        // Test 2: Bouncing press
        set_button(1);
        set_button(0);
        set_button(1);
        set_button(0);
        set_button(1);
        set_button(0);
        wait_cycles(8);
        check_output(0, "Bouncing press rejected");

        // Test 3: Stable press
        set_button(1);
        wait_cycles(12);
        check_output(1, "Stable press accepted");

        // Test 4: Bouncing release
        set_button(0);
        set_button(1);
        set_button(0);
        set_button(1);
        set_button(0);
        wait_cycles(8);
        check_output(1, "Bouncing release rejected");

        // Test 5: Stable release
        set_button(0);
        wait_cycles(12);
        check_output(0, "Stable release accepted");

        // Test 6: Reset while output is HIGH
        set_button(1);
        wait_cycles(12);
        check_output(1, "Press before reset");

        @(negedge clk);
        rst_n = 0;
        wait_cycles(2);
        check_output(0, "Reset clears output");

        $display("--------------------------------");
        $display("TOTAL PASS = %0d", PASS);
        $display("TOTAL FAIL = %0d", FAIL);
        $display("--------------------------------");

        $finish;
    end

endmodule
