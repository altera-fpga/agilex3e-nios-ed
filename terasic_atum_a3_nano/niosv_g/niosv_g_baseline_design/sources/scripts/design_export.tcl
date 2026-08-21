load_package vds
# project_new top
# 
# Info: Current script was exported with Quartus Prime Pro Release 26.1.1 Build 65
# 
regexp {[\.0-9]+} $quartus(version) import_release
if {$import_release != "26.1.1"} {
	post_message -type error "Cannot import script exported from Quartus Prime Pro version \"26.1.1 Build 65\" into current release \"$import_release\".\n\tOpen, upgrade, and validate the original system in VDS to ensure design correctness."
	return
}
proc get_current_hier {} {
set current_hier [vds::get_current_hier]
if {$current_hier == "|"} {
	set current_hier ""
}
return $current_hier
}

project_open top

vds::create_system qsys_top
vds::create_cell -properties { parameters:EXPLICIT_CLOCK_RATE {50000000}  } -vlnv altera.com:ip:altera_clock_bridge: clock_in
vds::create_cell -properties { parameters:enableBranchPrediction {false} parameters:peripheralRegionABase {393216} parameters:peripheralRegionASize {4096} parameters:resetSlave {intel_onchip_memory_0.s1}  } -vlnv altera.com:ip:intel_niosv_g: intel_niosv_g_0
vds::create_cell -properties { parameters:memorySize {262144} parameters:useNonDefaultInitFile {true}  } -vlnv altera.com:ip:intel_onchip_memory: intel_onchip_memory_0
vds::create_cell -vlnv altera.com:ip:altera_avalon_jtag_uart: jtag_uart_0
vds::create_cell -properties { parameters:width {4}  } -vlnv altera.com:ip:altera_avalon_pio: pio_0
vds::create_cell -properties { parameters:direction {Input} parameters:width {2}  } -vlnv altera.com:ip:altera_avalon_pio: pio_1
vds::create_cell -vlnv altera.com:ip:altera_reset_bridge: reset_in
vds::create_cell -properties { parameters:id {43981}  } -vlnv altera.com:ip:altera_avalon_sysid_qsys: sysid_qsys_0
vds::connect_interface_net -dest intel_niosv_g_0|dm_agent -src intel_niosv_g_0|data_manager
vds::assign_base_address -connection intel_niosv_g_0.data_manager/intel_niosv_g_0.dm_agent 0x00040000
vds::connect_interface_net -dest intel_niosv_g_0|dm_agent -src intel_niosv_g_0|instruction_manager
vds::assign_base_address -connection intel_niosv_g_0.instruction_manager/intel_niosv_g_0.dm_agent 0x00040000
vds::connect_interface_net -dest intel_niosv_g_0|timer_sw_agent -src intel_niosv_g_0|data_manager
vds::assign_base_address -connection intel_niosv_g_0.data_manager/intel_niosv_g_0.timer_sw_agent 0x00050000
vds::connect_interface_net -dest jtag_uart_0|avalon_jtag_slave -src intel_niosv_g_0|data_manager
vds::assign_base_address -connection intel_niosv_g_0.data_manager/jtag_uart_0.avalon_jtag_slave 0x00060000
vds::connect_interface_net -dest sysid_qsys_0|control_slave -src intel_niosv_g_0|data_manager
vds::assign_base_address -connection intel_niosv_g_0.data_manager/sysid_qsys_0.control_slave 0x00050060
vds::connect_interface_net -dest intel_onchip_memory_0|s1 -src intel_niosv_g_0|data_manager
vds::assign_base_address -connection intel_niosv_g_0.data_manager/intel_onchip_memory_0.s1 0x0000
vds::connect_interface_net -dest pio_0|s1 -src intel_niosv_g_0|data_manager
vds::assign_base_address -connection intel_niosv_g_0.data_manager/pio_0.s1 0x00060050
vds::connect_interface_net -dest pio_1|s1 -src intel_niosv_g_0|data_manager
vds::assign_base_address -connection intel_niosv_g_0.data_manager/pio_1.s1 0x00060040
vds::connect_interface_net -dest intel_onchip_memory_0|s1 -src intel_niosv_g_0|instruction_manager
vds::assign_base_address -connection intel_niosv_g_0.instruction_manager/intel_onchip_memory_0.s1 0x0000
vds::connect_interface_net -dest jtag_uart_0|irq -src intel_niosv_g_0|platform_irq_rx
vds::set_interrupt_irq -connection intel_niosv_g_0.platform_irq_rx/jtag_uart_0.irq 0
vds::export_pin clock_in|in_clk clk
vds::connect_net -src clock_in|out_clk -dest reset_in|clk
vds::connect_net -src clock_in|out_clk -dest intel_niosv_g_0|clk
vds::connect_net -src clock_in|out_clk -dest jtag_uart_0|clk
vds::connect_net -src clock_in|out_clk -dest pio_0|clk
vds::connect_net -src clock_in|out_clk -dest pio_1|clk
vds::connect_net -src clock_in|out_clk -dest sysid_qsys_0|clk
vds::connect_net -src clock_in|out_clk -dest intel_onchip_memory_0|clk1
vds::export_pin pio_0|external_connection pio_0_external_connection
vds::export_pin pio_1|external_connection pio_1_external_connection
vds::export_pin reset_in|in_reset reset
vds::connect_net -src reset_in|out_reset -dest intel_niosv_g_0|reset
vds::connect_net -src reset_in|out_reset -dest pio_1|reset
vds::connect_net -src reset_in|out_reset -dest pio_0|reset
vds::connect_net -src reset_in|out_reset -dest jtag_uart_0|reset
vds::connect_net -src reset_in|out_reset -dest sysid_qsys_0|reset
vds::connect_net -src reset_in|out_reset -dest intel_onchip_memory_0|reset1
vds::set_domain_properties {qsys_mm.burstAdapterImplementation GENERIC_CONVERTER qsys_mm.clockCrossingAdapter AUTO qsys_mm.enableAllPipelines FALSE qsys_mm.enableEccProtection FALSE qsys_mm.enableInstrumentation FALSE qsys_mm.enableOutOfOrderSupport FALSE qsys_mm.fifoDepth 8 qsys_mm.insertDefaultSlave FALSE qsys_mm.interconnectResetSource DEFAULT qsys_mm.maxAdditionalLatency 1 qsys_mm.optimizeRdFifoSize FALSE qsys_mm.piplineType PIPELINE_STAGE qsys_mm.responseFifoType REGISTER_BASED qsys_mm.splitCommandsFor4KBoundary FALSE qsys_mm.syncResets TRUE qsys_mm.widthAdapterImplementation GENERIC_CONVERTER } intel_niosv_g_0.data_manager
vds::validate_system
vds::save_system qsys_top

post_message "Script completed successfully."
