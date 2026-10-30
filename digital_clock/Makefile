DUT ?= digital_clock

//RTL = rtl/$(DUT).v rtl/freq_div.v rtl/seg_7.v
RTL = rtl/freq_div.v 
TB = tb/tb_$(DUT).v
TOP = tb_$(DUT)
SIM = sim/sim.out
WAVE = waves/dump.vcd
LOG = docs/$(DUT).log

compile:
	iverilog -g2012 -o $(SIM) $(RTL) $(TB)

run: compile
	vvp $(SIM) | tee $(LOG)

wave: run
	gtkwave $(WAVE) &

check: run
	@echo "---FAILURES---"
	@grep "FAIL" $(LOG) || echo "NONE"
	@echo "---SUMMARY---"
	@grep "summary\|PASS\|FAIL" $(LOG) | tail -2

clean:
	rm -f $(SIM) $(WAVE) $(LOG)

.PHONY: compile run wave check clean
