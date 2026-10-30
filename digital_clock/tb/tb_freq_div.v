`timescale 1ns/1ps
module tb_freq_div;

    reg sys_clk;
    reg areset_n;
    wire real_clk;

    freq_div dut(
        .sys_clk(sys_clk),
        .areset_n(areset_n),
        .real_clk(real_clk)
    );

    initial begin
        $dumpfile("waves/dump.vcd");
        $dumpvars(0,tb_freq_div);
    end 

    initial begin
        sys_clk = 0;
        areset_n = 0;
        forever #5 sys_clk = ~sys_clk;
    end

    initial begin
        #7;
        areset_n = 1;


        #300;
        $finish;
    end



endmodule