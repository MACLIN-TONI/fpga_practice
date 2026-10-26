set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports { clk }];
set_property -dict { PACKAGE_PIN P18 IOSTANDARD LVCMOS33 } [get_ports { areset_n }];



set_property -dict { PACKAGE_PIN T11 IOSTANDARD LVCMOS33 } [get_ports {digi_sel[0]}]; #LSB
set_property -dict { PACKAGE_PIN T10 IOSTANDARD LVCMOS33 } [get_ports {digi_sel[1]}];
set_property -dict { PACKAGE_PIN T12 IOSTANDARD LVCMOS33 } [get_ports {digi_sel[2]}];
set_property -dict { PACKAGE_PIN U12 IOSTANDARD LVCMOS33 } [get_ports {digi_sel[3]}];#MSB
 
set_property -dict { PACKAGE_PIN V13 IOSTANDARD LVCMOS33 } [get_ports {seg[7]}];#A
set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports {seg[6]}];#B
set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports {seg[5]}];#C
set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports {seg[4]}];#D
set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports {seg[3]}];#E
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports {seg[2]}];#F
set_property -dict { PACKAGE_PIN R14 IOSTANDARD LVCMOS33 } [get_ports {seg[1]}];#G
set_property -dict { PACKAGE_PIN Y16 IOSTANDARD LVCMOS33 } [get_ports {seg[0]}];#DP
 
