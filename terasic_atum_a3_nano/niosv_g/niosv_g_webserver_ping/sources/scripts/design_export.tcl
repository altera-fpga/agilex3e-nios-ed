package require ::quartus::project

post_message [pwd]

if {[is_project_open]} {
  project_close
}

# Check that the right project is open
set need_to_close_project 0
if {[is_project_open]} {
    if {[string compare $quartus(project) "top"]} {
        puts "Project top is not open"
        exit 1
    }
} else {
    # Only open if not already open
    if {[project_exists top]} {
        project_open -revision top top
        puts "Project top is open"
    } else {
        puts "Project top does not exist"
        exit 1
    }
    set need_to_close_project 1
}

load_package vds
# project_new top
# 
# Info: Current script was exported with Quartus Prime Pro Release 26.1.0 Build 101
# 
regexp {[\.0-9]+} $quartus(version) import_release
if {$import_release != "26.1.0"} {
	post_message -type error "Cannot import script exported from Quartus Prime Pro version \"26.1.0 Build 101\" into current release \"$import_release\".\n\tOpen, upgrade, and validate the original system in VDS to ensure design correctness."
	return
}
proc get_current_hier {} {
set current_hier [vds::get_current_hier]
if {$current_hier == "|"} {
	set current_hier ""
}
return $current_hier
}

vds::create_system qsys_top
vds::create_cell -properties { parameters:SDRAM_MHZ {75}  } -vlnv :ip:core_sdram_axi4:1.3 core_sdram_axi4_0
vds::create_cell -properties { parameters:resetOffset {134217728} parameters:peripheralRegionASize {65536} parameters:peripheralRegionABase {67698688} parameters:instCacheSize {0} parameters:enableBranchPrediction {false} parameters:dataCacheSize {0}  } -vlnv altera.com:ip:intel_niosv_g:4.1.0 intel_niosv_g_4
vds::create_cell -properties { parameters:EXPLICIT_CLOCK_RATE {100000000}  } -vlnv altera.com:ip:altera_clock_bridge:19.2.0 proc_clk
vds::create_cell -vlnv altera.com:ip:altera_reset_bridge:19.2.0 proc_rst
vds::create_cell -properties { parameters:EXPLICIT_CLOCK_RATE {75000000}  } -vlnv altera.com:ip:altera_clock_bridge:19.2.0 sdram_clock
vds::create_cell -vlnv altera.com:ip:altera_reset_bridge:19.2.0 sdram_reset
vds::create_cell -properties { parameters:memorySize {524288} parameters:initMemContent {false}  } -vlnv altera.com:ip:intel_onchip_memory:1.4.11 sys_cpu_ram
vds::create_cell -properties { parameters:memorySize {512}  } -vlnv altera.com:ip:intel_onchip_memory:1.4.11 sys_desc_mem
vds::create_cell -vlnv altera.com:ip:altera_avalon_jtag_uart:19.3.2 sys_jtag_uart
vds::create_cell -properties { parameters:ux_txeq_post_tap_1 {5} parameters:ux_txeq_main_tap {52} parameters:rx_adaptation_mode {manual} parameters:mdio_clk_div {50} parameters:ifGMII {RGMII} parameters:enable_mac_flow_ctrl {true} parameters:enable_hd_logic {false} parameters:ing_addr {13} parameters:enable_gmii_loopback {true} parameters:useMDIO {true} parameters:eg_addr {13} parameters:core_variation {MAC_ONLY}  } -vlnv altera.com:ip:intel_eth_tse:12.0.0 sys_tse
vds::create_cell -properties { parameters:TRANSFER_TYPE {Unaligned Accesses} parameters:MODE {2} parameters:MAX_BURST_COUNT {256} parameters:ERROR_WIDTH {6} parameters:PREFETCHER_ENABLE {1} parameters:PACKET_ENABLE {1} parameters:MAX_BYTE {262144} parameters:ERROR_ENABLE {1} parameters:DATA_FIFO_DEPTH {2048} parameters:BURST_WRAPPING_SUPPORT {1}  } -vlnv altera.com:ip:altera_msgdma:19.3.3 sys_tse_msgdma_rx
vds::create_cell -properties { parameters:TRANSFER_TYPE {Unaligned Accesses} parameters:MODE {1} parameters:ERROR_WIDTH {1} parameters:PREFETCHER_ENABLE {1} parameters:MAX_BYTE {262144} parameters:PACKET_ENABLE {1} parameters:ERROR_ENABLE {1} parameters:DATA_FIFO_DEPTH {2048}  } -vlnv altera.com:ip:altera_msgdma:19.3.3 sys_tse_msgdma_tx
vds::connect_interface_net -dest core_sdram_axi4_0|axi4_slave -src intel_niosv_g_4|data_manager
vds::assign_base_address -connection intel_niosv_g_4.data_manager/core_sdram_axi4_0.axi4_slave 0x08000000
vds::connect_interface_net -dest core_sdram_axi4_0|axi4_slave -src intel_niosv_g_4|instruction_manager
vds::assign_base_address -connection intel_niosv_g_4.instruction_manager/core_sdram_axi4_0.axi4_slave 0x08000000
vds::connect_interface_net -dest intel_niosv_g_4|dm_agent -src intel_niosv_g_4|data_manager
vds::assign_base_address -connection intel_niosv_g_4.data_manager/intel_niosv_g_4.dm_agent 0x04080000
vds::connect_interface_net -dest intel_niosv_g_4|dm_agent -src intel_niosv_g_4|instruction_manager
vds::assign_base_address -connection intel_niosv_g_4.instruction_manager/intel_niosv_g_4.dm_agent 0x04080000
vds::connect_interface_net -dest intel_niosv_g_4|timer_sw_agent -src intel_niosv_g_4|data_manager
vds::assign_base_address -connection intel_niosv_g_4.data_manager/intel_niosv_g_4.timer_sw_agent 0x04090040
vds::connect_interface_net -dest sys_jtag_uart|avalon_jtag_slave -src intel_niosv_g_4|data_manager
vds::assign_base_address -connection intel_niosv_g_4.data_manager/sys_jtag_uart.avalon_jtag_slave 0x040900e0
vds::connect_interface_net -dest sys_tse|control_port -src intel_niosv_g_4|data_manager
vds::assign_base_address -connection intel_niosv_g_4.data_manager/sys_tse.control_port 0x04090400
vds::connect_interface_net -dest sys_tse_msgdma_rx|csr -src intel_niosv_g_4|data_manager
vds::assign_base_address -connection intel_niosv_g_4.data_manager/sys_tse_msgdma_rx.csr 0x040900c0
vds::connect_interface_net -dest sys_tse_msgdma_tx|csr -src intel_niosv_g_4|data_manager
vds::assign_base_address -connection intel_niosv_g_4.data_manager/sys_tse_msgdma_tx.csr 0x040900a0
vds::connect_interface_net -dest sys_tse_msgdma_rx|prefetcher_csr -src intel_niosv_g_4|data_manager
vds::assign_base_address -connection intel_niosv_g_4.data_manager/sys_tse_msgdma_rx.prefetcher_csr 0x04090080
vds::connect_interface_net -dest sys_tse_msgdma_tx|prefetcher_csr -src intel_niosv_g_4|data_manager
vds::assign_base_address -connection intel_niosv_g_4.data_manager/sys_tse_msgdma_tx.prefetcher_csr 0x04090020
vds::connect_interface_net -dest sys_cpu_ram|s1 -src intel_niosv_g_4|data_manager
vds::assign_base_address -connection intel_niosv_g_4.data_manager/sys_cpu_ram.s1 0x04000000
vds::connect_interface_net -dest sys_desc_mem|s1 -src intel_niosv_g_4|data_manager
vds::assign_base_address -connection intel_niosv_g_4.data_manager/sys_desc_mem.s1 0x04092000
vds::connect_interface_net -dest sys_cpu_ram|s1 -src intel_niosv_g_4|instruction_manager
vds::assign_base_address -connection intel_niosv_g_4.instruction_manager/sys_cpu_ram.s1 0x04000000
vds::connect_interface_net -dest sys_tse_msgdma_rx|csr_irq -src intel_niosv_g_4|platform_irq_rx
vds::set_interrupt_irq -connection intel_niosv_g_4.platform_irq_rx/sys_tse_msgdma_rx.csr_irq 1
vds::connect_interface_net -dest sys_tse_msgdma_tx|csr_irq -src intel_niosv_g_4|platform_irq_rx
vds::set_interrupt_irq -connection intel_niosv_g_4.platform_irq_rx/sys_tse_msgdma_tx.csr_irq 2
vds::connect_interface_net -dest sys_jtag_uart|irq -src intel_niosv_g_4|platform_irq_rx
vds::set_interrupt_irq -connection intel_niosv_g_4.platform_irq_rx/sys_jtag_uart.irq 0
vds::connect_interface_net -dest sys_cpu_ram|s1 -src sys_tse_msgdma_tx|mm_read
vds::assign_base_address -connection sys_tse_msgdma_tx.mm_read/sys_cpu_ram.s1 0x04000000
vds::connect_interface_net -dest sys_cpu_ram|s1 -src sys_tse_msgdma_rx|mm_write
vds::assign_base_address -connection sys_tse_msgdma_rx.mm_write/sys_cpu_ram.s1 0x04000000
vds::connect_interface_net -dest sys_desc_mem|s1 -src sys_tse_msgdma_rx|descriptor_read_master
vds::assign_base_address -connection sys_tse_msgdma_rx.descriptor_read_master/sys_desc_mem.s1 0x04092000
vds::connect_interface_net -dest sys_desc_mem|s1 -src sys_tse_msgdma_tx|descriptor_read_master
vds::assign_base_address -connection sys_tse_msgdma_tx.descriptor_read_master/sys_desc_mem.s1 0x04092000
vds::connect_interface_net -dest sys_desc_mem|s1 -src sys_tse_msgdma_rx|descriptor_write_master
vds::assign_base_address -connection sys_tse_msgdma_rx.descriptor_write_master/sys_desc_mem.s1 0x04092000
vds::connect_interface_net -dest sys_desc_mem|s1 -src sys_tse_msgdma_tx|descriptor_write_master
vds::assign_base_address -connection sys_tse_msgdma_tx.descriptor_write_master/sys_desc_mem.s1 0x04092000
vds::connect_interface_net -dest sys_tse|transmit -src sys_tse_msgdma_tx|st_source
vds::connect_interface_net -dest sys_tse_msgdma_rx|st_sink -src sys_tse|receive
vds::export_interface_pin sys_tse|mac_status_connection sys_tse_mac_status_connection
vds::export_interface_pin sys_tse|mac_rgmii_connection sys_tse_mac_rgmii_connection
vds::export_interface_pin sys_tse|mac_mdio_connection sys_tse_mac_mdio_connection
vds::export_interface_pin sys_tse|mac_misc_connection triple_speed_ethernet_0_mac_misc_connection
vds::export_interface_pin core_sdram_axi4_0|sdram core_sdram_axi4_0_sdram
vds::export_pin sys_tse|pcs_mac_rx_clock_connection sys_tse_pcs_mac_rx_clock_connection
vds::export_pin sys_tse|pcs_mac_tx_clock_connection sys_tse_pcs_mac_tx_clock_connection
vds::export_pin sdram_reset|in_reset sdram_rst
vds::export_pin sdram_clock|in_clk sdram_clk
vds::export_pin proc_rst|in_reset proc_rst
vds::export_pin proc_clk|in_clk proc_clk
vds::connect_net -src sdram_reset|out_reset -dest core_sdram_axi4_0|reset_sink
vds::connect_net -src proc_rst|out_reset -dest intel_niosv_g_4|reset
vds::connect_net -src proc_rst|out_reset -dest sys_jtag_uart|reset
vds::connect_net -src proc_rst|out_reset -dest sys_cpu_ram|reset1
vds::connect_net -src proc_rst|out_reset -dest sys_desc_mem|reset1
vds::connect_net -src proc_rst|out_reset -dest sys_tse|reset_connection
vds::connect_net -src proc_rst|out_reset -dest sys_tse_msgdma_rx|reset_n
vds::connect_net -src proc_rst|out_reset -dest sys_tse_msgdma_tx|reset_n
vds::connect_net -src sdram_clock|out_clk -dest sdram_reset|clk
vds::connect_net -src sdram_clock|out_clk -dest core_sdram_axi4_0|clock_sample_sink
vds::connect_net -src sdram_clock|out_clk -dest core_sdram_axi4_0|clock_sink
vds::connect_net -src proc_clk|out_clk -dest intel_niosv_g_4|clk
vds::connect_net -src proc_clk|out_clk -dest proc_rst|clk
vds::connect_net -src proc_clk|out_clk -dest sys_jtag_uart|clk
vds::connect_net -src proc_clk|out_clk -dest sys_cpu_ram|clk1
vds::connect_net -src proc_clk|out_clk -dest sys_desc_mem|clk1
vds::connect_net -src proc_clk|out_clk -dest sys_tse_msgdma_rx|clock
vds::connect_net -src proc_clk|out_clk -dest sys_tse_msgdma_tx|clock
vds::connect_net -src proc_clk|out_clk -dest sys_tse|control_port_clock_connection
vds::connect_net -src proc_clk|out_clk -dest sys_tse|receive_clock_connection
vds::connect_net -src proc_clk|out_clk -dest sys_tse|transmit_clock_connection
vds::set_domain_properties {qsys_mm.splitCommandsFor4KBoundary FALSE qsys_mm.burstAdapterImplementation GENERIC_CONVERTER qsys_mm.maxAdditionalLatency 1 qsys_mm.clockCrossingAdapter HANDSHAKE qsys_mm.interconnectResetSource DEFAULT qsys_mm.enableEccProtection FALSE qsys_mm.enableInstrumentation FALSE qsys_mm.enableOutOfOrderSupport FALSE qsys_mm.fifoDepth 8 qsys_mm.responseFifoType REGISTER_BASED qsys_mm.widthAdapterImplementation GENERIC_CONVERTER qsys_mm.insertDefaultSlave FALSE qsys_mm.piplineType PIPELINE_STAGE qsys_mm.syncResets TRUE qsys_mm.enableAllPipelines FALSE qsys_mm.optimizeRdFifoSize FALSE } intel_niosv_g_4.data_manager
vds::set_pipelines {mm_interconnect_0|sys_tse_msgdma_tx_descriptor_write_master_agent.cp/router_005.sink 1 mm_interconnect_0|sys_tse_msgdma_tx_csr_agent.rp/router_015.sink 0 mm_interconnect_0|crosser_007.out/cmd_mux_009.sink0 0 mm_interconnect_0|cmd_mux_003 0 mm_interconnect_0|cmd_mux_007 0 mm_interconnect_0|sys_tse_msgdma_rx_prefetcher_csr_agent.rp/router_018.sink 0 mm_interconnect_0|sys_tse_msgdma_rx_mm_write_agent.cp/router_009.sink 0 mm_interconnect_0|sys_tse_msgdma_rx_descriptor_read_master_agent.cp/router_002.sink 1 mm_interconnect_0|cmd_demux_006.src2/crosser_021.in 0 mm_interconnect_0|sys_tse_msgdma_rx_csr_agent.rp/router_014.sink 0 mm_interconnect_0|cmd_demux_001.src4/crosser_014.in 0 mm_interconnect_0|crosser_013.out/cmd_mux_004.sink1 0 mm_interconnect_0|sys_desc_mem_s1_agent.rp/router_021.sink 0 mm_interconnect_0|rsp_demux_001.src3/crosser_035.in 0 mm_interconnect_0|router_017.src/rsp_demux_007.sink 0 mm_interconnect_0|sys_cpu_ram_s1_agent.rp/router_020.sink 0 mm_interconnect_0|rsp_mux_007.src/intel_niosv_g_0_instruction_manager_rd_limiter.rsp_sink 0 mm_interconnect_0|intel_niosv_g_0_instruction_manager_wr_limiter.rsp_src/intel_niosv_g_0_instruction_manager_agent.write_rp 0 mm_interconnect_0|rsp_mux_008.src/sys_tse_msgdma_tx_mm_read_limiter.rsp_sink 0 mm_interconnect_0|cmd_demux_006.src0/crosser_020.in 0 mm_interconnect_0|crosser_031.out/rsp_mux_001.sink0 0 mm_interconnect_0|rsp_mux_005.src/sys_tse_msgdma_tx_descriptor_write_master_agent.rp 0 mm_interconnect_0|rsp_demux_012.src0/rsp_mux.sink11 0 mm_interconnect_0|intel_niosv_g_0_instruction_manager_rd_limiter.rsp_src/intel_niosv_g_0_instruction_manager_agent.read_rp 0 mm_interconnect_0|cmd_mux_009 0 mm_interconnect_0|rsp_demux_011.src5/rsp_mux_005.sink0 0 mm_interconnect_0|rsp_demux_008.src1/crosser_051.in 0 mm_interconnect_0|cmd_demux.src4/crosser_004.in 0 mm_interconnect_0|rsp_demux_011.src3/rsp_mux_003.sink0 0 mm_interconnect_0|router_008.src/sys_tse_msgdma_tx_mm_read_limiter.cmd_sink 0 mm_interconnect_0|rsp_demux_011.src2/rsp_mux_002.sink0 0 mm_interconnect_0|cmd_demux.src10/crosser_009.in 0 mm_interconnect_0|rsp_demux_010.src1/crosser_055.in 0 mm_interconnect_0|rsp_demux_008.src0/crosser_050.in 0 mm_interconnect_0|cmd_demux_001.src2/crosser_012.in 0 mm_interconnect_0|router_015.src/rsp_demux_005.sink 0 mm_interconnect_0|crosser_046.out/rsp_mux.sink6 0 mm_interconnect_0|rsp_demux_006.src3/rsp_mux_007.sink1 0 mm_interconnect_0|crosser_038.out/rsp_mux_008.sink1 0 mm_interconnect_0|rsp_demux_012.src1/rsp_mux_001.sink11 0 mm_interconnect_0|rsp_demux_006.src1/rsp_mux_001.sink5 0 mm_interconnect_0|crosser_036.out/rsp_mux_001.sink1 0 mm_interconnect_0|rsp_demux_006.src0/rsp_mux.sink5 0 mm_interconnect_0|rsp_demux_005.src0/crosser_044.in 0 mm_interconnect_0|rsp_demux_009.src0/crosser_052.in 0 mm_interconnect_0|rsp_demux_004.src1/crosser_043.in 0 mm_interconnect_0|crosser_035.out/rsp_mux_009.sink0 0 mm_interconnect_0|rsp_demux_003.src1/crosser_041.in 0 mm_interconnect_0|cmd_demux_001.src6/crosser_015.in 0 mm_interconnect_0|cmd_mux_004.src/sys_tse_msgdma_rx_csr_agent.cp 1 mm_interconnect_0|rsp_demux_003.src0/crosser_040.in 0 mm_interconnect_0|rsp_demux_002.src3/crosser_039.in 0 mm_interconnect_0|crosser_020.out/cmd_mux_001.sink1 1 mm_interconnect_0|rsp_mux_006.src/intel_niosv_g_0_instruction_manager_wr_limiter.rsp_sink 0 mm_interconnect_0|intel_niosv_g_0_data_manager_agent.read_cp/router_001.sink 1 mm_interconnect_0|rsp_demux_002.src2/crosser_038.in 0 mm_interconnect_0|router_010.src/rsp_demux.sink 0 mm_interconnect_0|rsp_demux_002.src1/crosser_037.in 0 mm_interconnect_0|intel_niosv_g_0_data_manager_agent.write_cp/router.sink 1 mm_interconnect_0|rsp_demux_011.src1/crosser_059.in 0 mm_interconnect_0|sys_jtag_uart_avalon_jtag_slave_agent.rp/router_010.sink 0 mm_interconnect_0|rsp_demux_002.src0/crosser_036.in 0 mm_interconnect_0|rsp_demux_001.src2/crosser_034.in 0 mm_interconnect_0|rsp_demux_001.src0/crosser_032.in 0 mm_interconnect_0|crosser_058.out/rsp_mux.sink10 0 mm_interconnect_0|cmd_mux_010.src/sys_cpu_ram_s1_agent.cp 0 mm_interconnect_0|rsp_demux.src1/crosser_031.in 0 mm_interconnect_0|router_002.src/cmd_demux_002.sink 0 mm_interconnect_0|crosser_008.out/cmd_mux_010.sink0 0 mm_interconnect_0|cmd_mux_001 0 mm_interconnect_0|crosser_021.out/cmd_mux_007.sink2 1 mm_interconnect_0|router_021.src/rsp_demux_011.sink 0 mm_interconnect_0|router_014.src/rsp_demux_004.sink 0 mm_interconnect_0|sys_tse_msgdma_rx_descriptor_write_master_agent.cp/router_004.sink 1 mm_interconnect_0|router_018.src/rsp_demux_008.sink 0 mm_interconnect_0|router_013.src/rsp_demux_003.sink 0 mm_interconnect_0|router_011.src/core_sdram_axi4_0_axi4_slave_wr_rsp_width_adapter.sink 0 mm_interconnect_0|rsp_demux_007.src2/crosser_048.in 0 mm_interconnect_0|router_009.src/cmd_demux_009.sink 0 mm_interconnect_0|sys_tse_msgdma_tx_descriptor_read_master_agent.cp/router_003.sink 1 mm_interconnect_0|rsp_mux_009.src/sys_tse_msgdma_rx_mm_write_agent.rp 0 mm_interconnect_0|router_006.src/intel_niosv_g_0_instruction_manager_wr_limiter.cmd_sink 0 mm_interconnect_0|crosser_011.out/cmd_mux_002.sink0 1 mm_interconnect_0|router_016.src/rsp_demux_006.sink 0 mm_interconnect_0|router_005.src/cmd_demux_005.sink 0 mm_interconnect_0|cmd_mux_001.src/core_sdram_axi4_0_axi4_slave_wr_cmd_width_adapter.sink 0 mm_interconnect_0|intel_niosv_g_0_dm_agent_agent.rp/router_016.sink 0 mm_interconnect_0|sys_tse_msgdma_tx_mm_read_limiter.rsp_src/sys_tse_msgdma_tx_mm_read_agent.rp 0 mm_interconnect_0|router_004.src/cmd_demux_004.sink 0 mm_interconnect_0|sys_tse_msgdma_tx_mm_read_agent.cp/router_008.sink 1 mm_interconnect_0|rsp_demux_011.src4/rsp_mux_004.sink0 0 mm_interconnect_0|rsp_mux_004.src/sys_tse_msgdma_rx_descriptor_write_master_agent.rp 0 mm_interconnect_0|router_001.src/cmd_demux_001.sink 0 mm_interconnect_0|router_003.src/cmd_demux_003.sink 0 mm_interconnect_0|intel_niosv_g_0_timer_sw_agent_agent.m0/intel_niosv_g_0_timer_sw_agent_translator.avalon_universal_slave_0 1 mm_interconnect_0|intel_niosv_g_0_instruction_manager_wr_limiter.cmd_src/cmd_demux_006.sink 0 mm_interconnect_0|intel_niosv_g_0_instruction_manager_rd_limiter.cmd_src/cmd_demux_007.sink 0 mm_interconnect_0|crosser_017.out/cmd_mux_009.sink1 0 mm_interconnect_0|rsp_demux_001.src1/crosser_033.in 0 mm_interconnect_0|sys_tse_msgdma_tx_prefetcher_csr_agent.rp/router_019.sink 0 mm_interconnect_0|rsp_demux_010.src0/crosser_054.in 0 mm_interconnect_0|intel_niosv_g_0_instruction_manager_agent.write_cp/router_006.sink 1 mm_interconnect_0|sys_tse_control_port_agent.rp/router_013.sink 0 mm_interconnect_0|intel_niosv_g_0_timer_sw_agent_agent.rp/router_022.sink 0 mm_interconnect_0|intel_niosv_g_0_instruction_manager_agent.read_cp/router_007.sink 1 mm_interconnect_0|router_022.src/rsp_demux_012.sink 0 mm_interconnect_0|fifo_0_in_csr_agent.rp/router_017.sink 0 mm_interconnect_0|cmd_mux 0 mm_interconnect_0|crosser_042.out/rsp_mux.sink3 0 mm_interconnect_0|crosser_059.out/rsp_mux_001.sink10 0 mm_interconnect_0|crosser_006.out/cmd_mux_008.sink0 0 mm_interconnect_0|crosser_056.out/rsp_mux_006.sink3 0 mm_interconnect_0|cmd_mux_012 0 mm_interconnect_0|rsp_demux_006.src2/rsp_mux_006.sink1 0 mm_interconnect_0|crosser_055.out/rsp_mux_001.sink9 0 mm_interconnect_0|cmd_mux_006.src/intel_niosv_g_0_dm_agent_agent.cp 1 mm_interconnect_0|cmd_demux.src5/cmd_mux_006.sink0 0 mm_interconnect_0|rsp_demux.src0/crosser_030.in 0 mm_interconnect_0|cmd_mux_007.src/fifo_0_in_csr_agent.cp 0 mm_interconnect_0|cmd_mux_002 0 mm_interconnect_0|cmd_mux_004 0 mm_interconnect_0|rsp_mux.src/intel_niosv_g_0_data_manager_agent.write_rp 0 mm_interconnect_0|cmd_mux_002.src/core_sdram_axi4_0_axi4_slave_rd_cmd_width_adapter.sink 0 mm_interconnect_0|crosser_053.out/rsp_mux_001.sink8 0 mm_interconnect_0|cmd_demux.src9/crosser_008.in 0 mm_interconnect_0|cmd_mux_005 0 mm_interconnect_0|crosser_024.out/cmd_mux_007.sink3 1 mm_interconnect_0|crosser.out/cmd_mux.sink0 0 mm_interconnect_0|cmd_mux.src/sys_jtag_uart_avalon_jtag_slave_agent.cp 1 mm_interconnect_0|cmd_demux_009.src0/crosser_028.in 0 mm_interconnect_0|crosser_019.out/cmd_mux_011.sink1 0 mm_interconnect_0|cmd_demux_008.src1/crosser_027.in 0 mm_interconnect_0|cmd_mux_008.src/sys_tse_msgdma_rx_prefetcher_csr_agent.cp 1 mm_interconnect_0|cmd_demux_007.src3/crosser_025.in 0 mm_interconnect_0|core_sdram_axi4_0_axi4_slave_rd_cmd_width_adapter.src/core_sdram_axi4_0_axi4_slave_agent.read_cp 0 mm_interconnect_0|rsp_demux_010.src3/crosser_057.in 0 mm_interconnect_0|cmd_demux_001.src9/crosser_018.in 0 mm_interconnect_0|cmd_demux_009.src1/crosser_029.in 0 mm_interconnect_0|cmd_demux_001.src8/crosser_017.in 0 mm_interconnect_0|cmd_demux.src3/crosser_003.in 0 mm_interconnect_0|rsp_mux_001.src/intel_niosv_g_0_data_manager_agent.read_rp 0 mm_interconnect_0|router_012.src/core_sdram_axi4_0_axi4_slave_rd_rsp_width_adapter.sink 0 mm_interconnect_0|cmd_demux_007.src1/cmd_mux_006.sink3 0 mm_interconnect_0|crosser_028.out/cmd_mux_001.sink3 0 mm_interconnect_0|cmd_demux.src8/crosser_007.in 0 mm_interconnect_0|cmd_demux_004.src0/cmd_mux_011.sink4 0 mm_interconnect_0|router.src/cmd_demux.sink 0 mm_interconnect_0|cmd_mux_005.src/sys_tse_msgdma_tx_csr_agent.cp 1 mm_interconnect_0|router_007.src/intel_niosv_g_0_instruction_manager_rd_limiter.cmd_sink 0 mm_interconnect_0|cmd_demux.src0/crosser.in 0 mm_interconnect_0|crosser_047.out/rsp_mux_001.sink6 0 mm_interconnect_0|crosser_002.out/cmd_mux_003.sink0 0 mm_interconnect_0|rsp_demux_007.src0/crosser_046.in 0 mm_interconnect_0|cmd_mux_003.src/sys_tse_control_port_agent.cp 1 mm_interconnect_0|cmd_demux.src2/crosser_002.in 0 mm_interconnect_0|cmd_demux_003.src0/cmd_mux_011.sink3 0 mm_interconnect_0|cmd_demux.src11/cmd_mux_012.sink0 0 mm_interconnect_0|cmd_mux_011 0 mm_interconnect_0|cmd_demux_008.src0/crosser_026.in 0 mm_interconnect_0|cmd_demux_001.src10/crosser_019.in 0 mm_interconnect_0|cmd_demux.src7/crosser_006.in 0 mm_interconnect_0|cmd_demux_007.src2/crosser_024.in 0 mm_interconnect_0|core_sdram_axi4_0_axi4_slave_agent.read_rp/router_012.sink 0 mm_interconnect_0|rsp_demux_010.src2/crosser_056.in 0 mm_interconnect_0|crosser_014.out/cmd_mux_005.sink1 0 mm_interconnect_0|crosser_018.out/cmd_mux_010.sink1 0 mm_interconnect_0|rsp_demux_011.src0/crosser_058.in 0 mm_interconnect_0|cmd_mux_008 0 mm_interconnect_0|cmd_demux_006.src3/crosser_022.in 0 mm_interconnect_0|crosser_032.out/rsp_mux.sink1 0 mm_interconnect_0|cmd_demux.src6/crosser_005.in 0 mm_interconnect_0|crosser_041.out/rsp_mux_001.sink2 0 mm_interconnect_0|cmd_demux_001.src5/cmd_mux_006.sink1 0 mm_interconnect_0|router_020.src/rsp_demux_010.sink 0 mm_interconnect_0|cmd_demux_005.src0/cmd_mux_011.sink5 0 mm_interconnect_0|rsp_demux_009.src1/crosser_053.in 0 mm_interconnect_0|cmd_demux.src1/crosser_001.in 0 mm_interconnect_0|cmd_demux_001.src1/crosser_011.in 0 mm_interconnect_0|crosser_040.out/rsp_mux.sink2 0 mm_interconnect_0|crosser_003.out/cmd_mux_004.sink0 0 mm_interconnect_0|crosser_022.out/cmd_mux_010.sink2 0 mm_interconnect_0|cmd_demux_001.src11/cmd_mux_012.sink1 0 mm_interconnect_0|crosser_029.out/cmd_mux_002.sink3 0 mm_interconnect_0|crosser_027.out/cmd_mux_002.sink2 1 mm_interconnect_0|crosser_052.out/rsp_mux.sink8 0 mm_interconnect_0|crosser_026.out/cmd_mux_001.sink2 1 mm_interconnect_0|rsp_demux_005.src1/crosser_045.in 0 mm_interconnect_0|rsp_mux_003.src/sys_tse_msgdma_tx_descriptor_read_master_agent.rp 0 mm_interconnect_0|cmd_demux_001.src3/crosser_013.in 0 mm_interconnect_0|crosser_015.out/cmd_mux_007.sink1 0 mm_interconnect_0|cmd_demux_001.src7/crosser_016.in 0 mm_interconnect_0|core_sdram_axi4_0_axi4_slave_rd_rsp_width_adapter.src/rsp_demux_002.sink 0 mm_interconnect_0|rsp_mux_002.src/sys_tse_msgdma_rx_descriptor_read_master_agent.rp 0 mm_interconnect_0|cmd_mux_009.src/sys_tse_msgdma_tx_prefetcher_csr_agent.cp 1 mm_interconnect_0|router_019.src/rsp_demux_009.sink 0 mm_interconnect_0|crosser_044.out/rsp_mux.sink4 0 mm_interconnect_0|cmd_mux_010 0 mm_interconnect_0|rsp_demux_007.src1/crosser_047.in 0 mm_interconnect_0|cmd_mux_006 0 mm_interconnect_0|cmd_mux_011.src/sys_desc_mem_s1_agent.cp 1 mm_interconnect_0|crosser_012.out/cmd_mux_003.sink1 0 mm_interconnect_0|cmd_mux_012.src/intel_niosv_g_0_timer_sw_agent_agent.cp 0 mm_interconnect_0|crosser_051.out/rsp_mux_001.sink7 0 mm_interconnect_0|core_sdram_axi4_0_axi4_slave_wr_rsp_width_adapter.src/rsp_demux_001.sink 0 mm_interconnect_0|crosser_001.out/cmd_mux_001.sink0 0 mm_interconnect_0|crosser_004.out/cmd_mux_005.sink0 0 mm_interconnect_0|crosser_030.out/rsp_mux.sink0 0 mm_interconnect_0|cmd_demux_001.src0/crosser_010.in 0 mm_interconnect_0|sys_tse_msgdma_tx_mm_read_limiter.cmd_src/cmd_demux_008.sink 0 mm_interconnect_0|cmd_demux_007.src0/crosser_023.in 0 mm_interconnect_0|crosser_009.out/cmd_mux_011.sink0 0 mm_interconnect_0|crosser_033.out/rsp_mux_006.sink0 0 mm_interconnect_0|crosser_050.out/rsp_mux.sink7 0 mm_interconnect_0|crosser_010.out/cmd_mux.sink1 0 mm_interconnect_0|crosser_037.out/rsp_mux_007.sink0 0 mm_interconnect_0|core_sdram_axi4_0_axi4_slave_wr_cmd_width_adapter.src/core_sdram_axi4_0_axi4_slave_agent.write_cp 0 mm_interconnect_0|crosser_016.out/cmd_mux_008.sink1 0 mm_interconnect_0|rsp_demux_007.src3/crosser_049.in 0 mm_interconnect_0|crosser_034.out/rsp_mux_008.sink0 0 mm_interconnect_0|crosser_023.out/cmd_mux_002.sink1 1 mm_interconnect_0|crosser_025.out/cmd_mux_010.sink3 1 mm_interconnect_0|crosser_057.out/rsp_mux_007.sink3 0 mm_interconnect_0|crosser_054.out/rsp_mux.sink9 0 mm_interconnect_0|cmd_demux_002.src0/cmd_mux_011.sink2 0 mm_interconnect_0|crosser_049.out/rsp_mux_007.sink2 0 mm_interconnect_0|rsp_demux_004.src0/crosser_042.in 0 mm_interconnect_0|crosser_039.out/rsp_mux_009.sink1 0 mm_interconnect_0|crosser_005.out/cmd_mux_007.sink0 0 mm_interconnect_0|cmd_demux_006.src1/cmd_mux_006.sink2 0 mm_interconnect_0|crosser_043.out/rsp_mux_001.sink3 0 mm_interconnect_0|crosser_045.out/rsp_mux_001.sink4 0 mm_interconnect_0|crosser_048.out/rsp_mux_006.sink2 0 mm_interconnect_0|core_sdram_axi4_0_axi4_slave_agent.write_rp/router_011.sink 0 }
vds::validate_system
vds::save_system qsys_top

post_message "Script completed successfully."

# Close project
if {$need_to_close_project} {
 project_close
}

# cd ..
post_message [pwd]
