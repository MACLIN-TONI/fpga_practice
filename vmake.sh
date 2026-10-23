#!/bin/bash

dut=$1

if [ -z "$dut" ]; then
    echo "Usage: ./make.sh <dut_name>"
    exit 1
fi

mkdir -p "$dut"/{rtl,tb,sim,docs,waves}

cd "$dut" || exit 1

touch "rtl/$dut.v"
touch "tb/tb_$dut.v"

cat > Makefile <<EOF
DUT ?= $dut

RTL = rtl/\$(DUT).v
TB = tb/tb_\$(DUT).v
TOP = tb_\$(DUT)
OBJ_DIR = sim/obj_dir
SIM = \$(OBJ_DIR)/V\$(TOP)
WAVE = waves/dump.vcd
LOG = docs/\$(DUT).log

.PHONY: all compile run wave check clean

all: compile

compile:
	mkdir -p sim docs waves
	verilator --binary --timing --trace-vcd \\
		--top-module \$(TOP) \\
		--Mdir \$(OBJ_DIR) \\
		\$(RTL) \$(TB)

run: compile
	./\$(SIM) 2>&1 | tee \$(LOG)

wave: run
	gtkwave \$(WAVE) &

check: run
	@echo "---FAILURES---"
	@grep "FAIL" \$(LOG) || echo "NONE"
	@echo "---SUMMARY---"
	@grep -i "summary\\|PASS\\|FAIL" \$(LOG) | tail -2 || true

clean:
	rm -rf \$(OBJ_DIR)
	rm -f \$(WAVE) \$(LOG)
EOF