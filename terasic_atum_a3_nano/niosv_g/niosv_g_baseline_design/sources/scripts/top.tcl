# Copyright (C) 2026  Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and any partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, the Altera Quartus Prime License Agreement,
# the Altera IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Altera and sold by Altera or its authorized distributors.  Please
# refer to the Altera Software License Subscription Agreements 
# on the Quartus Prime software download page.

# Quartus Prime: Generate Tcl File for Project
# File: top.tcl
# Generated on: Wed May 13 03:05:59 2026

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "top"]} {
		puts "Project top is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists top]} {
		project_open -revision top top
	} else {
		project_new -revision top top
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name TOP_LEVEL_ENTITY top
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 26.1.1
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "00:27:24  MAY 11, 2026"
	set_global_assignment -name LAST_QUARTUS_VERSION "26.1.1 Pro Edition"
	set_global_assignment -name VERILOG_FILE pb_debounce.v
	set_global_assignment -name SYSTEMVERILOG_FILE top.sv
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name FAMILY "Agilex 3"
	set_global_assignment -name DEVICE A3CZ135BB18AE7S
	set_global_assignment -name BOARD "Atum Nios V Starter Kit"
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_global_assignment -name IP_FILE iopll.ip
	set_global_assignment -name IP_FILE reset_release.ip
	set_global_assignment -name VDS_FILE src/vds/qsys_top/qsys_top.vds -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_clock_in.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_intel_niosv_g_0.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_intel_onchip_memory_0.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_jtag_uart_0.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_pio_0.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_pio_1.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_reset_in.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_sysid_qsys_0.ip -tag "vds::qsys_top"
	set_location_assignment PIN_K43 -to clk_clk
	set_instance_assignment -name IO_STANDARD "1.2-V" -to clk_clk -entity top
	set_location_assignment PIN_E2 -to pio_1_external_connection_export[0]
	set_location_assignment PIN_K3 -to pio_1_external_connection_export[1]
	set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to pio_1_external_connection_export* -entity top
	set_location_assignment PIN_AG2 -to pio_0_external_connection_export[0]
	set_location_assignment PIN_AM6 -to pio_0_external_connection_export[1]
	set_location_assignment PIN_AF1 -to pio_0_external_connection_export[2]
	set_location_assignment PIN_AF2 -to pio_0_external_connection_export[3]
	set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to pio_0_external_connection_export* -entity top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
