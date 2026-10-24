`timescale 1ns/1ps
module tb_debouncer;
reg clk;
reg rst_n;
reg button_in;
wire button_out;

integer PASS = 0;
integer FAIL = 0;
	
debouncer #(
.CLK_FREQ_HZ(1000),
.DEBOUNCE_TIME_MS(5)
) dut(	
.clk(clk),
.rst_n(rst_n),
.button_in(button_in),
.button_out(button_out) 	
);

initial begin
	$dumpfile("waves/dump.vcd");
	$dumpvars(0,tb_debouncer);
end

initial begin
	clk = 0;
	rst_n = 0;
	button_in = 0;
	forever #5 clk = ~clk;
end

task check;
	input  exp;
	begin
		#1;
		if(exp === button_out) begin
			$display("PASS | button_out = %b | exp = %b",button_out, exp);
			PASS = PASS + 1;
		end
		else begin
			$display("FAIL | button_out = %b | exp = %b",button_out, exp);
			FAIL = FAIL + 1;
		end
	end

endtask


	
initial begin
	#7;
	rst_n = 1;
	#16;
	button_in = 0;
	#7;
	repeat(6) begin
		@(negedge clk) button_in = 1;
	end
	@(posedge clk);
	@(posedge clk) check(1);
	
	@(negedge clk) button_in = 0;
	repeat(6) @(posedge clk);

	@(posedge clk) check(0);
	
	@(negedge clk) button_in = 1;
	repeat(6) begin
		@(negedge clk) button_in = ~ button_in;
	end
	@(posedge clk) check(0);	
	
	repeat(6) @(posedge clk);
	@(negedge clk) check(1);

	#200;
	$finish;
end
        
	    

	

endmodule
