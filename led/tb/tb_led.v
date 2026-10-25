`timescale 1ns/1ps
module tb_led;
	reg clk;
	reg rst_n;
	reg b1;
	reg b2;
	wire led_out;
	
	integer PASS = 0;
	integer FAIL = 0;

	led dut(
		.clk(clk),
		.rst_n(rst_n),
		.b1(b1),
		.b2(b2),
		.led_out(led_out)
	);

	initial begin
		$dumpfile("waves/dump.vcd");
		$dumpvars(0, tb_led);
	end

	initial begin
		clk = 0;
		rst_n = 0;
		b1 = 0;
		b2 = 0;
		forever #5 clk = ~clk;
	end

	task check;
		input t_b1;
		input t_b2;
		reg exp;
		begin
			b1 = t_b1;
			b2 = t_b2;
			
			
			repeat(10) begin
				@(posedge clk);
			end

			case({b1,b2})
				2'b00: exp = led_out;
			        	
				2'b01: exp = 1'b0;
				2'b10: exp = 1'b1;
				2'b11: exp = 1'b1;
			endcase
			#1;
			if (exp === led_out) begin
				$display("PASS | b1 = %b | b2 = %b | led_out = %b | exp = %b",b1,b2,led_out,exp);
				PASS = PASS + 1;
			end
			else begin
				$display("FAIL | b1 = %b | b2 = %b | led_out = %b | exp = %b",b1,b2,led_out,exp);
				FAIL = FAIL + 1;	
			end		
		end
	endtask

	initial begin
		#7; rst_n = 1;
		#21;
		for(integer i = 0; i < 4 ; i = i + 1) begin
			@(negedge clk) check((i/2),(i%2));
		end

		#120;
		$finish;
	end

endmodule
