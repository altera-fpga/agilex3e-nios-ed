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
# Generated on: Mon Mar  9 01:12:23 2026

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
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 26.1.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "02:50:42  MARCH 06, 2026"
	set_global_assignment -name LAST_QUARTUS_VERSION "26.1.0 Pro Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 100
	set_global_assignment -name DEVICE A3CZ135BB18AE7S
	set_global_assignment -name FAMILY "Agilex 3"
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (Verilog)"
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_global_assignment -name PRESERVE_UNUSED_XCVR_CHANNEL ON
	set_global_assignment -name GENERATE_COMPRESSED_SOF ON
	set_global_assignment -name AUTO_RESTART_CONFIGURATION OFF
	set_global_assignment -name STRATIXV_CONFIGURATION_SCHEME "AVST X8"
	set_global_assignment -name ON_CHIP_BITSTREAM_DECOMPRESSION OFF
	set_global_assignment -name USE_CONF_DONE SDM_IO5
	set_global_assignment -name USE_HPS_COLD_RESET SDM_IO12
	set_global_assignment -name DEVICE_INITIALIZATION_CLOCK OSC_CLK_1_125MHZ
	set_global_assignment -name PWRMGT_VOLTAGE_OUTPUT_FORMAT "LINEAR FORMAT"
	set_global_assignment -name PWRMGT_LINEAR_FORMAT_N "-12"
	set_global_assignment -name POWER_APPLY_THERMAL_MARGIN ADDITIONAL
	set_global_assignment -name POWER_THERMAL_SOLVER_MODE FIND_MAX_TJ
	set_global_assignment -name BOARD default
	set_global_assignment -name VERILOG_FILE top.v
	set_global_assignment -name IP_FILE sys_pll.ip
	set_global_assignment -name VERILOG_FILE sdram_axi.v
	set_global_assignment -name VERILOG_FILE sdram_axi_pmem.v
	set_global_assignment -name VERILOG_FILE sdram_axi_core.v
	set_global_assignment -name IP_FILE reset_release.ip
	set_global_assignment -name IP_FILE issp.ip
	set_global_assignment -name IP_SEARCH_PATHS "../custom_logic/core_sdram_axi/**/*"
	set_global_assignment -name VDS_FILE src/vds/qsys_top/qsys_top.vds -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_core_sdram_axi4_0.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_intel_niosv_g_4.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_proc_clk.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_proc_rst.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_sdram_clock.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_sdram_reset.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_sys_cpu_ram.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_sys_desc_mem.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_sys_jtag_uart.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_sys_tse.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_sys_tse_msgdma_rx.ip -tag "vds::qsys_top"
	set_global_assignment -name VDS_IP_FILE src/vds/qsys_top/ip/qsys_top_sys_tse_msgdma_tx.ip -tag "vds::qsys_top"
	set_instance_assignment -name PARTITION_COLOUR 4289977599 -to top -entity top
	set_instance_assignment -name PARTITION_COLOUR 4285964287 -to auto_fab_0 -entity top
	set_location_assignment PIN_K43 -to CLK_50M
	set_instance_assignment -name IO_STANDARD "1.2-V" -to CLK_50M -entity top
	# IOBANK_6D
	set_location_assignment PIN_BH7 -to MDIO -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_BB9 -to MDC -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_AW12 -to phy_resetn -comment IOBANK_6D
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to MDC -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to MDIO -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to phy_resetn -entity top
	# IOBANK_6D
	set_location_assignment PIN_BF12 -to rgmii_in[0] -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_BF9 -to rgmii_in[1] -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_BB12 -to rgmii_in[2] -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_BH3 -to rgmii_in[3] -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_BH10 -to rgmii_out[0] -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_BK10 -to rgmii_out[1] -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_BM2 -to rgmii_out[2] -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_BM3 -to rgmii_out[3] -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_AY6 -to rgmii_txclk -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_AU6 -to rgmii_txctl -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_AT9 -to rgmii_rxclk -comment IOBANK_6D
	# IOBANK_6D
	set_location_assignment PIN_AU4 -to rgmii_rxctl -comment IOBANK_6D
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to rgmii* -entity top
	set_instance_assignment -name INPUT_DELAY_CHAIN 45 -to rgmii_rxctl -entity top
	set_instance_assignment -name INPUT_DELAY_CHAIN 45 -to rgmii_in[0] -entity top
	set_instance_assignment -name INPUT_DELAY_CHAIN 45 -to rgmii_in[1] -entity top
	set_instance_assignment -name INPUT_DELAY_CHAIN 45 -to rgmii_in[2] -entity top
	set_instance_assignment -name INPUT_DELAY_CHAIN 45 -to rgmii_in[3] -entity top
	set_location_assignment PIN_BK40 -to DRAM_CKE
	set_location_assignment PIN_BN34 -to DRAM_CS_n
	set_location_assignment PIN_BM31 -to DRAM_RAS_n
	set_location_assignment PIN_BH40 -to DRAM_CAS_n
	set_location_assignment PIN_BM34 -to DRAM_WE_n
	set_location_assignment PIN_BE6 -to DRAM_DQM[0]
	set_location_assignment PIN_BM19 -to DRAM_DQM[1]
	set_location_assignment PIN_BJ2 -to DRAM_DQM[2]
	set_location_assignment PIN_BM14 -to DRAM_DQM[3]
	set_location_assignment PIN_BN26 -to DRAM_ADDR[0]
	set_location_assignment PIN_BH27 -to DRAM_ADDR[1]
	set_location_assignment PIN_BM26 -to DRAM_ADDR[2]
	set_location_assignment PIN_BH21 -to DRAM_ADDR[3]
	set_location_assignment PIN_BH26 -to DRAM_ADDR[4]
	set_location_assignment PIN_BH18 -to DRAM_ADDR[5]
	set_location_assignment PIN_BK18 -to DRAM_ADDR[6]
	set_location_assignment PIN_BH32 -to DRAM_ADDR[7]
	set_location_assignment PIN_BM24 -to DRAM_ADDR[8]
	set_location_assignment PIN_BH35 -to DRAM_ADDR[9]
	set_location_assignment PIN_BN27 -to DRAM_ADDR[10]
	set_location_assignment PIN_BN29 -to DRAM_ADDR[11]
	set_location_assignment PIN_BK26 -to DRAM_ADDR[12]
	set_location_assignment PIN_BH43 -to DRAM_BA[0]
	set_location_assignment PIN_BM29 -to DRAM_BA[1]
	set_location_assignment PIN_BM50 -to DRAM_DQ[0]
	set_location_assignment PIN_BM51 -to DRAM_DQ[1]
	set_location_assignment PIN_BN47 -to DRAM_DQ[2]
	set_location_assignment PIN_BM47 -to DRAM_DQ[3]
	set_location_assignment PIN_BL51 -to DRAM_DQ[4]
	set_location_assignment PIN_BH50 -to DRAM_DQ[5]
	set_location_assignment PIN_BK50 -to DRAM_DQ[6]
	set_location_assignment PIN_BH46 -to DRAM_DQ[7]
	set_location_assignment PIN_BM37 -to DRAM_DQ[8]
	set_location_assignment PIN_BN37 -to DRAM_DQ[9]
	set_location_assignment PIN_BM42 -to DRAM_DQ[10]
	set_location_assignment PIN_BN42 -to DRAM_DQ[11]
	set_location_assignment PIN_BM44 -to DRAM_DQ[12]
	set_location_assignment PIN_BN45 -to DRAM_DQ[13]
	set_location_assignment PIN_BN39 -to DRAM_DQ[14]
	set_location_assignment PIN_BM45 -to DRAM_DQ[15]
	set_location_assignment PIN_BG2 -to DRAM_DQ[16]
	set_location_assignment PIN_BA2 -to DRAM_DQ[17]
	set_location_assignment PIN_BC2 -to DRAM_DQ[18]
	set_location_assignment PIN_BJ1 -to DRAM_DQ[19]
	set_location_assignment PIN_BE4 -to DRAM_DQ[20]
	set_location_assignment PIN_BG1 -to DRAM_DQ[21]
	set_location_assignment PIN_BC1 -to DRAM_DQ[22]
	set_location_assignment PIN_BD1 -to DRAM_DQ[23]
	set_location_assignment PIN_BN5 -to DRAM_DQ[24]
	set_location_assignment PIN_BM9 -to DRAM_DQ[25]
	set_location_assignment PIN_BM8 -to DRAM_DQ[26]
	set_location_assignment PIN_BN11 -to DRAM_DQ[27]
	set_location_assignment PIN_BN8 -to DRAM_DQ[28]
	set_location_assignment PIN_BN14 -to DRAM_DQ[29]
	set_location_assignment PIN_BM11 -to DRAM_DQ[30]
	set_location_assignment PIN_BN16 -to DRAM_DQ[31]
	set_location_assignment PIN_BK32 -to DRAM_CLK
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_CLK -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_CKE -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[0] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[1] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[2] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[3] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[4] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[5] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[6] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[7] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[8] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[9] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[10] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[11] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_ADDR[12] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_BA[0] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_BA[1] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[0] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[1] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[2] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[3] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[4] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[5] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[6] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[7] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[8] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[9] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[10] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[11] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[12] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[13] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[14] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[15] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[16] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[17] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[18] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[19] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[20] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[21] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[22] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[23] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[24] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[25] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[26] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[27] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[28] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[29] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[30] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQ[31] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_CS_n -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_WE_n -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_CAS_n -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_RAS_n -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQM[0] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQM[1] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQM[2] -entity top
	set_instance_assignment -name IO_STANDARD "1.8-V LVCMOS" -to DRAM_DQM[3] -entity top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
