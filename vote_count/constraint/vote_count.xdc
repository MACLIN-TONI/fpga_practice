set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports { clk }];

set_property -dict { PACKAGE_PIN P18 IOSTANDARD LVCMOS33 } [get_ports { areset_n }];

set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports { v_end }];

set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports {b2}];
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33 } [get_ports {b1}];

set_property -dict { PACKAGE_PIN R16 IOSTANDARD LVCMOS33 } [get_ports { out1 }];#LSB
set_property -dict { PACKAGE_PIN R17 IOSTANDARD LVCMOS33 } [get_ports { out2 }];
