package require -exact qsys 26.1

# create the system "nios_system"
proc do_create_nios_system {} {
	# create the system
	create_system nios_system
	set_project_property BOARD {default}
	set_project_property DEVICE {A3CZ135BB18AE7S}
	set_project_property DEVICE_FAMILY {Agilex 3}
	set_project_property HIDE_FROM_IP_CATALOG {false}
	set_use_testbench_naming_pattern 0 {}

	# add HDL parameters

	# add the components
	add_component clock_in ip/nios_system/clock_in.ip altera_clock_bridge clock_in
	load_component clock_in
	set_component_parameter_value EXPLICIT_CLOCK_RATE {50000000.0}
	set_component_parameter_value NUM_CLOCK_OUTPUTS {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation clock_in
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface in_clk clock INPUT
	set_instantiation_interface_parameter_value in_clk clockRate {0}
	set_instantiation_interface_parameter_value in_clk externallyDriven {false}
	set_instantiation_interface_parameter_value in_clk ptfSchematicName {}
	add_instantiation_interface_port in_clk in_clk clk 1 STD_LOGIC Input
	add_instantiation_interface out_clk clock OUTPUT
	set_instantiation_interface_parameter_value out_clk associatedDirectClock {in_clk}
	set_instantiation_interface_parameter_value out_clk clockRate {50000000}
	set_instantiation_interface_parameter_value out_clk clockRateKnown {true}
	set_instantiation_interface_parameter_value out_clk externallyDriven {false}
	set_instantiation_interface_parameter_value out_clk ptfSchematicName {}
	set_instantiation_interface_sysinfo_parameter_value out_clk clock_rate {50000000}
	add_instantiation_interface_port out_clk out_clk clk 1 STD_LOGIC Output
	save_instantiation
	add_component iopll ip/nios_system/iopll.ip altera_iopll iopll
	load_component iopll
	set_component_parameter_value gui_active_clk {0}
	set_component_parameter_value gui_c_cnt_in_src0 {c_m_cnt_in_src_ph_mux_clk}
	set_component_parameter_value gui_c_cnt_in_src1 {c_m_cnt_in_src_ph_mux_clk}
	set_component_parameter_value gui_c_cnt_in_src2 {c_m_cnt_in_src_ph_mux_clk}
	set_component_parameter_value gui_c_cnt_in_src3 {c_m_cnt_in_src_ph_mux_clk}
	set_component_parameter_value gui_c_cnt_in_src4 {c_m_cnt_in_src_ph_mux_clk}
	set_component_parameter_value gui_c_cnt_in_src5 {c_m_cnt_in_src_ph_mux_clk}
	set_component_parameter_value gui_c_cnt_in_src6 {c_m_cnt_in_src_ph_mux_clk}
	set_component_parameter_value gui_c_cnt_in_src7 {c_m_cnt_in_src_ph_mux_clk}
	set_component_parameter_value gui_c_cnt_in_src8 {c_m_cnt_in_src_ph_mux_clk}
	set_component_parameter_value gui_cal_code_hex_file {iossm.hex}
	set_component_parameter_value gui_cal_converge {0}
	set_component_parameter_value gui_cal_error {cal_clean}
	set_component_parameter_value gui_cascade_counter0 {0}
	set_component_parameter_value gui_cascade_counter1 {0}
	set_component_parameter_value gui_cascade_counter10 {0}
	set_component_parameter_value gui_cascade_counter11 {0}
	set_component_parameter_value gui_cascade_counter12 {0}
	set_component_parameter_value gui_cascade_counter13 {0}
	set_component_parameter_value gui_cascade_counter14 {0}
	set_component_parameter_value gui_cascade_counter15 {0}
	set_component_parameter_value gui_cascade_counter16 {0}
	set_component_parameter_value gui_cascade_counter17 {0}
	set_component_parameter_value gui_cascade_counter2 {0}
	set_component_parameter_value gui_cascade_counter3 {0}
	set_component_parameter_value gui_cascade_counter4 {0}
	set_component_parameter_value gui_cascade_counter5 {0}
	set_component_parameter_value gui_cascade_counter6 {0}
	set_component_parameter_value gui_cascade_counter7 {0}
	set_component_parameter_value gui_cascade_counter8 {0}
	set_component_parameter_value gui_cascade_counter9 {0}
	set_component_parameter_value gui_cascade_outclk_index {5}
	set_component_parameter_value gui_clk_bad {0}
	set_component_parameter_value gui_clock_name_global {0}
	set_component_parameter_value gui_clock_name_instantiation {0}
	set_component_parameter_value gui_clock_name_string0 {outclk0}
	set_component_parameter_value gui_clock_name_string1 {outclk1}
	set_component_parameter_value gui_clock_name_string10 {outclk10}
	set_component_parameter_value gui_clock_name_string11 {outclk11}
	set_component_parameter_value gui_clock_name_string12 {outclk12}
	set_component_parameter_value gui_clock_name_string13 {outclk13}
	set_component_parameter_value gui_clock_name_string14 {outclk14}
	set_component_parameter_value gui_clock_name_string15 {outclk15}
	set_component_parameter_value gui_clock_name_string16 {outclk16}
	set_component_parameter_value gui_clock_name_string17 {outclk17}
	set_component_parameter_value gui_clock_name_string2 {outclk2}
	set_component_parameter_value gui_clock_name_string3 {outclk3}
	set_component_parameter_value gui_clock_name_string4 {outclk4}
	set_component_parameter_value gui_clock_name_string5 {outclk5}
	set_component_parameter_value gui_clock_name_string6 {outclk6}
	set_component_parameter_value gui_clock_name_string7 {outclk7}
	set_component_parameter_value gui_clock_name_string8 {outclk8}
	set_component_parameter_value gui_clock_name_string9 {outclk9}
	set_component_parameter_value gui_clock_to_compensate {0}
	set_component_parameter_value gui_debug_mode {0}
	set_component_parameter_value gui_divide_factor_c0 {6}
	set_component_parameter_value gui_divide_factor_c1 {6}
	set_component_parameter_value gui_divide_factor_c10 {6}
	set_component_parameter_value gui_divide_factor_c11 {6}
	set_component_parameter_value gui_divide_factor_c12 {6}
	set_component_parameter_value gui_divide_factor_c13 {6}
	set_component_parameter_value gui_divide_factor_c14 {6}
	set_component_parameter_value gui_divide_factor_c15 {6}
	set_component_parameter_value gui_divide_factor_c16 {6}
	set_component_parameter_value gui_divide_factor_c17 {6}
	set_component_parameter_value gui_divide_factor_c2 {6}
	set_component_parameter_value gui_divide_factor_c3 {6}
	set_component_parameter_value gui_divide_factor_c4 {6}
	set_component_parameter_value gui_divide_factor_c5 {6}
	set_component_parameter_value gui_divide_factor_c6 {6}
	set_component_parameter_value gui_divide_factor_c7 {6}
	set_component_parameter_value gui_divide_factor_c8 {6}
	set_component_parameter_value gui_divide_factor_c9 {6}
	set_component_parameter_value gui_divide_factor_n {1}
	set_component_parameter_value gui_dps_cntr {C0}
	set_component_parameter_value gui_dps_dir {Positive}
	set_component_parameter_value gui_dps_num {1}
	set_component_parameter_value gui_dsm_out_sel {1st_order}
	set_component_parameter_value gui_duty_cycle0 {50.0}
	set_component_parameter_value gui_duty_cycle1 {50.0}
	set_component_parameter_value gui_duty_cycle10 {50.0}
	set_component_parameter_value gui_duty_cycle11 {50.0}
	set_component_parameter_value gui_duty_cycle12 {50.0}
	set_component_parameter_value gui_duty_cycle13 {50.0}
	set_component_parameter_value gui_duty_cycle14 {50.0}
	set_component_parameter_value gui_duty_cycle15 {50.0}
	set_component_parameter_value gui_duty_cycle16 {50.0}
	set_component_parameter_value gui_duty_cycle17 {50.0}
	set_component_parameter_value gui_duty_cycle2 {50.0}
	set_component_parameter_value gui_duty_cycle3 {50.0}
	set_component_parameter_value gui_duty_cycle4 {50.0}
	set_component_parameter_value gui_duty_cycle5 {50.0}
	set_component_parameter_value gui_duty_cycle6 {50.0}
	set_component_parameter_value gui_duty_cycle7 {50.0}
	set_component_parameter_value gui_duty_cycle8 {50.0}
	set_component_parameter_value gui_duty_cycle9 {50.0}
	set_component_parameter_value gui_en_adv_params {0}
	set_component_parameter_value gui_en_dps_ports {0}
	set_component_parameter_value gui_en_extclkout_ports {0}
	set_component_parameter_value gui_en_hvio_reconf {0}
	set_component_parameter_value gui_en_iossm_reconf {0}
	set_component_parameter_value gui_en_lvds_ports {Disabled}
	set_component_parameter_value gui_en_periphery_ports {0}
	set_component_parameter_value gui_en_phout_ports {0}
	set_component_parameter_value gui_en_reconf {0}
	set_component_parameter_value gui_enable_cascade_in {0}
	set_component_parameter_value gui_enable_cascade_out {0}
	set_component_parameter_value gui_enable_mif_dps {0}
	set_component_parameter_value gui_enable_output_counter_cascading {0}
	set_component_parameter_value gui_enable_permit_cal {0}
	set_component_parameter_value gui_enable_upstream_out_clk {0}
	set_component_parameter_value gui_existing_mif_file_path {~/pll.mif}
	set_component_parameter_value gui_extclkout_0_source {C0}
	set_component_parameter_value gui_extclkout_1_source {C0}
	set_component_parameter_value gui_extclkout_source {C0}
	set_component_parameter_value gui_feedback_clock {Global Clock}
	set_component_parameter_value gui_fix_vco_frequency {0}
	set_component_parameter_value gui_fixed_vco_frequency {600.0}
	set_component_parameter_value gui_fixed_vco_frequency_ps {1667.0}
	set_component_parameter_value gui_frac_multiply_factor {1.0}
	set_component_parameter_value gui_fractional_cout {32}
	set_component_parameter_value gui_include_iossm {0}
	set_component_parameter_value gui_location_type {I/O Bank}
	set_component_parameter_value gui_lock_setting {Low Lock Time}
	set_component_parameter_value gui_mif_config_name {unnamed}
	set_component_parameter_value gui_mif_gen_options {Generate New MIF File}
	set_component_parameter_value gui_multiply_factor {6}
	set_component_parameter_value gui_multiply_fraction {0}
	set_component_parameter_value gui_new_mif_file_path {~/pll.mif}
	set_component_parameter_value gui_number_of_clocks {3}
	set_component_parameter_value gui_operation_mode {direct}
	set_component_parameter_value gui_output_clock_frequency0 {80.0}
	set_component_parameter_value gui_output_clock_frequency1 {80.0}
	set_component_parameter_value gui_output_clock_frequency10 {100.0}
	set_component_parameter_value gui_output_clock_frequency11 {100.0}
	set_component_parameter_value gui_output_clock_frequency12 {100.0}
	set_component_parameter_value gui_output_clock_frequency13 {100.0}
	set_component_parameter_value gui_output_clock_frequency14 {100.0}
	set_component_parameter_value gui_output_clock_frequency15 {100.0}
	set_component_parameter_value gui_output_clock_frequency16 {100.0}
	set_component_parameter_value gui_output_clock_frequency17 {100.0}
	set_component_parameter_value gui_output_clock_frequency2 {80.0}
	set_component_parameter_value gui_output_clock_frequency3 {50.0}
	set_component_parameter_value gui_output_clock_frequency4 {74.25}
	set_component_parameter_value gui_output_clock_frequency5 {100.0}
	set_component_parameter_value gui_output_clock_frequency6 {100.0}
	set_component_parameter_value gui_output_clock_frequency7 {100.0}
	set_component_parameter_value gui_output_clock_frequency8 {100.0}
	set_component_parameter_value gui_output_clock_frequency9 {100.0}
	set_component_parameter_value gui_output_clock_frequency_ps0 {12500.0}
	set_component_parameter_value gui_output_clock_frequency_ps1 {12500.0}
	set_component_parameter_value gui_output_clock_frequency_ps10 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps11 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps12 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps13 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps14 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps15 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps16 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps17 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps2 {12500.0}
	set_component_parameter_value gui_output_clock_frequency_ps3 {20000.0}
	set_component_parameter_value gui_output_clock_frequency_ps4 {13468.013}
	set_component_parameter_value gui_output_clock_frequency_ps5 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps6 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps7 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps8 {10000.0}
	set_component_parameter_value gui_output_clock_frequency_ps9 {10000.0}
	set_component_parameter_value gui_parameter_table_hex_file {seq_params_sim.hex}
	set_component_parameter_value gui_phase_shift0 {0.0}
	set_component_parameter_value gui_phase_shift1 {-200.0}
	set_component_parameter_value gui_phase_shift10 {0.0}
	set_component_parameter_value gui_phase_shift11 {0.0}
	set_component_parameter_value gui_phase_shift12 {0.0}
	set_component_parameter_value gui_phase_shift13 {0.0}
	set_component_parameter_value gui_phase_shift14 {0.0}
	set_component_parameter_value gui_phase_shift15 {0.0}
	set_component_parameter_value gui_phase_shift16 {0.0}
	set_component_parameter_value gui_phase_shift17 {0.0}
	set_component_parameter_value gui_phase_shift2 {55.0}
	set_component_parameter_value gui_phase_shift3 {0.0}
	set_component_parameter_value gui_phase_shift4 {0.0}
	set_component_parameter_value gui_phase_shift5 {0.0}
	set_component_parameter_value gui_phase_shift6 {0.0}
	set_component_parameter_value gui_phase_shift7 {0.0}
	set_component_parameter_value gui_phase_shift8 {0.0}
	set_component_parameter_value gui_phase_shift9 {0.0}
	set_component_parameter_value gui_phase_shift_deg0 {0.0}
	set_component_parameter_value gui_phase_shift_deg1 {-70.0}
	set_component_parameter_value gui_phase_shift_deg10 {0.0}
	set_component_parameter_value gui_phase_shift_deg11 {0.0}
	set_component_parameter_value gui_phase_shift_deg12 {0.0}
	set_component_parameter_value gui_phase_shift_deg13 {0.0}
	set_component_parameter_value gui_phase_shift_deg14 {0.0}
	set_component_parameter_value gui_phase_shift_deg15 {0.0}
	set_component_parameter_value gui_phase_shift_deg16 {0.0}
	set_component_parameter_value gui_phase_shift_deg17 {0.0}
	set_component_parameter_value gui_phase_shift_deg2 {125.0}
	set_component_parameter_value gui_phase_shift_deg3 {0.0}
	set_component_parameter_value gui_phase_shift_deg4 {0.0}
	set_component_parameter_value gui_phase_shift_deg5 {0.0}
	set_component_parameter_value gui_phase_shift_deg6 {0.0}
	set_component_parameter_value gui_phase_shift_deg7 {0.0}
	set_component_parameter_value gui_phase_shift_deg8 {0.0}
	set_component_parameter_value gui_phase_shift_deg9 {0.0}
	set_component_parameter_value gui_phout_division {1}
	set_component_parameter_value gui_pll_auto_reset {1}
	set_component_parameter_value gui_pll_bandwidth_preset {Low}
	set_component_parameter_value gui_pll_cal_done {0}
	set_component_parameter_value gui_pll_cascading_mode {adjpllin}
	set_component_parameter_value gui_pll_freqcal_en {1}
	set_component_parameter_value gui_pll_freqcal_req_flag {1}
	set_component_parameter_value gui_pll_m_cnt_in_src {c_m_cnt_in_src_ph_mux_clk}
	set_component_parameter_value gui_pll_mode {Integer-N PLL}
	set_component_parameter_value gui_pll_tclk_mux_en {0}
	set_component_parameter_value gui_pll_tclk_sel {pll_tclk_m_src}
	set_component_parameter_value gui_pll_type {S10_Simple}
	set_component_parameter_value gui_pll_vco_freq_band_0 {pll_freq_clk0_band18}
	set_component_parameter_value gui_pll_vco_freq_band_1 {pll_freq_clk1_band18}
	set_component_parameter_value gui_prot_mode {UNUSED}
	set_component_parameter_value gui_ps_units0 {ps}
	set_component_parameter_value gui_ps_units1 {degrees}
	set_component_parameter_value gui_ps_units10 {ps}
	set_component_parameter_value gui_ps_units11 {ps}
	set_component_parameter_value gui_ps_units12 {ps}
	set_component_parameter_value gui_ps_units13 {ps}
	set_component_parameter_value gui_ps_units14 {ps}
	set_component_parameter_value gui_ps_units15 {ps}
	set_component_parameter_value gui_ps_units16 {ps}
	set_component_parameter_value gui_ps_units17 {ps}
	set_component_parameter_value gui_ps_units2 {degrees}
	set_component_parameter_value gui_ps_units3 {ps}
	set_component_parameter_value gui_ps_units4 {ps}
	set_component_parameter_value gui_ps_units5 {ps}
	set_component_parameter_value gui_ps_units6 {ps}
	set_component_parameter_value gui_ps_units7 {ps}
	set_component_parameter_value gui_ps_units8 {ps}
	set_component_parameter_value gui_ps_units9 {ps}
	set_component_parameter_value gui_refclk1_frequency {100.0}
	set_component_parameter_value gui_refclk_might_change {0}
	set_component_parameter_value gui_refclk_switch {0}
	set_component_parameter_value gui_reference_clock_frequency {50.0}
	set_component_parameter_value gui_reference_clock_frequency_ps {20000.0}
	set_component_parameter_value gui_set_locked_as_reset {0}
	set_component_parameter_value gui_simulation_type {0}
	set_component_parameter_value gui_skip_sdc_generation {0}
	set_component_parameter_value gui_switchover_delay {0}
	set_component_parameter_value gui_switchover_mode {Automatic Switchover}
	set_component_parameter_value gui_use_NDFB_modes {0}
	set_component_parameter_value gui_use_coreclk {0}
	set_component_parameter_value gui_use_fractional_division {0}
	set_component_parameter_value gui_use_locked {0}
	set_component_parameter_value gui_use_logical {0}
	set_component_parameter_value gui_use_slvs_refclk {0}
	set_component_parameter_value gui_use_slvs_refclk1 {0}
	set_component_parameter_value gui_user_base_address {0}
	set_component_parameter_value gui_usr_device_speed_grade {1}
	set_component_parameter_value gui_vco_frequency {600.0}
	set_component_parameter_value hp_qsys_scripting_mode {0}
	set_component_parameter_value system_info_device_iobank_rev {}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation iopll
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.dts.compatible {altr,pll}
	set_instantiation_assignment_value embeddedsw.dts.group {clock}
	set_instantiation_assignment_value embeddedsw.dts.vendor {altr}
	add_instantiation_interface refclk clock INPUT
	set_instantiation_interface_parameter_value refclk clockRate {50000000}
	set_instantiation_interface_parameter_value refclk externallyDriven {false}
	set_instantiation_interface_parameter_value refclk ptfSchematicName {}
	set_instantiation_interface_assignment_value refclk ui.blockdiagram.direction {input}
	add_instantiation_interface_port refclk refclk clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {}
	set_instantiation_interface_parameter_value reset synchronousEdges {NONE}
	set_instantiation_interface_assignment_value reset ui.blockdiagram.direction {input}
	add_instantiation_interface_port reset rst reset 1 STD_LOGIC Input
	add_instantiation_interface outclk0 clock OUTPUT
	set_instantiation_interface_parameter_value outclk0 associatedDirectClock {}
	set_instantiation_interface_parameter_value outclk0 clockRate {80000000}
	set_instantiation_interface_parameter_value outclk0 clockRateKnown {true}
	set_instantiation_interface_parameter_value outclk0 externallyDriven {false}
	set_instantiation_interface_parameter_value outclk0 ptfSchematicName {}
	set_instantiation_interface_assignment_value outclk0 ui.blockdiagram.direction {output}
	set_instantiation_interface_sysinfo_parameter_value outclk0 clock_rate {80000000}
	add_instantiation_interface_port outclk0 outclk_0 clk 1 STD_LOGIC Output
	add_instantiation_interface outclk1 clock OUTPUT
	set_instantiation_interface_parameter_value outclk1 associatedDirectClock {}
	set_instantiation_interface_parameter_value outclk1 clockRate {80000000}
	set_instantiation_interface_parameter_value outclk1 clockRateKnown {true}
	set_instantiation_interface_parameter_value outclk1 externallyDriven {false}
	set_instantiation_interface_parameter_value outclk1 ptfSchematicName {}
	set_instantiation_interface_assignment_value outclk1 ui.blockdiagram.direction {output}
	set_instantiation_interface_sysinfo_parameter_value outclk1 clock_rate {80000000}
	add_instantiation_interface_port outclk1 outclk_1 clk 1 STD_LOGIC Output
	add_instantiation_interface outclk2 clock OUTPUT
	set_instantiation_interface_parameter_value outclk2 associatedDirectClock {}
	set_instantiation_interface_parameter_value outclk2 clockRate {80000000}
	set_instantiation_interface_parameter_value outclk2 clockRateKnown {true}
	set_instantiation_interface_parameter_value outclk2 externallyDriven {false}
	set_instantiation_interface_parameter_value outclk2 ptfSchematicName {}
	set_instantiation_interface_assignment_value outclk2 ui.blockdiagram.direction {output}
	set_instantiation_interface_sysinfo_parameter_value outclk2 clock_rate {80000000}
	add_instantiation_interface_port outclk2 outclk_2 clk 1 STD_LOGIC Output
	save_instantiation
	add_component jtag_uart ip/nios_system/jtag_uart.ip altera_avalon_jtag_uart jtag_uart
	load_component jtag_uart
	set_component_parameter_value allowMultipleConnections {0}
	set_component_parameter_value hubInstanceID {0}
	set_component_parameter_value printingMethod {0}
	set_component_parameter_value readBufferDepth {64}
	set_component_parameter_value readIRQThreshold {8}
	set_component_parameter_value simInputCharacterStream {}
	set_component_parameter_value simInteractiveOptions {NO_INTERACTIVE_WINDOWS}
	set_component_parameter_value useRegistersForReadBuffer {0}
	set_component_parameter_value useRegistersForWriteBuffer {0}
	set_component_parameter_value useRelativePathForSimFile {0}
	set_component_parameter_value writeBufferDepth {64}
	set_component_parameter_value writeIRQThreshold {8}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation jtag_uart
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DEPTH {64}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_THRESHOLD {8}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITE_DEPTH {64}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITE_THRESHOLD {8}
	set_instantiation_assignment_value embeddedsw.dts.compatible {altr,juart-1.0}
	set_instantiation_assignment_value embeddedsw.dts.group {serial}
	set_instantiation_assignment_value embeddedsw.dts.name {juart}
	set_instantiation_assignment_value embeddedsw.dts.vendor {altr}
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clk clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clk}
	set_instantiation_interface_parameter_value reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset rst_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface avalon_jtag_slave avalon INPUT
	set_instantiation_interface_parameter_value avalon_jtag_slave addressAlignment {NATIVE}
	set_instantiation_interface_parameter_value avalon_jtag_slave addressGroup {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave addressSpan {2}
	set_instantiation_interface_parameter_value avalon_jtag_slave addressUnits {WORDS}
	set_instantiation_interface_parameter_value avalon_jtag_slave alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave associatedClock {clk}
	set_instantiation_interface_parameter_value avalon_jtag_slave associatedReset {reset}
	set_instantiation_interface_parameter_value avalon_jtag_slave bitsPerSymbol {8}
	set_instantiation_interface_parameter_value avalon_jtag_slave bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave bridgesToMaster {}
	set_instantiation_interface_parameter_value avalon_jtag_slave burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value avalon_jtag_slave constantBurstBehavior {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave dfhFeatureId {35}
	set_instantiation_interface_parameter_value avalon_jtag_slave dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave dfhFeatureType {3}
	set_instantiation_interface_parameter_value avalon_jtag_slave dfhGroupId {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave dfhParameterData {}
	set_instantiation_interface_parameter_value avalon_jtag_slave dfhParameterDataLength {}
	set_instantiation_interface_parameter_value avalon_jtag_slave dfhParameterId {}
	set_instantiation_interface_parameter_value avalon_jtag_slave dfhParameterName {}
	set_instantiation_interface_parameter_value avalon_jtag_slave dfhParameterVersion {}
	set_instantiation_interface_parameter_value avalon_jtag_slave explicitAddressSpan {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave holdTime {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave interleaveBursts {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave isBigEndian {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave isFlash {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave isMemoryDevice {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave linewrapBursts {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave minimumReadLatency {1}
	set_instantiation_interface_parameter_value avalon_jtag_slave minimumResponseLatency {1}
	set_instantiation_interface_parameter_value avalon_jtag_slave minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value avalon_jtag_slave prSafe {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave printableDevice {true}
	set_instantiation_interface_parameter_value avalon_jtag_slave readLatency {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave readWaitStates {1}
	set_instantiation_interface_parameter_value avalon_jtag_slave readWaitTime {1}
	set_instantiation_interface_parameter_value avalon_jtag_slave registerIncomingSignals {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave setupTime {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave timingUnits {Cycles}
	set_instantiation_interface_parameter_value avalon_jtag_slave transparentBridge {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave waitrequestAllowance {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value avalon_jtag_slave wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value avalon_jtag_slave writeLatency {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave writeWaitStates {0}
	set_instantiation_interface_parameter_value avalon_jtag_slave writeWaitTime {0}
	set_instantiation_interface_assignment_value avalon_jtag_slave embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value avalon_jtag_slave embeddedsw.configuration.isMemoryDevice {0}
	set_instantiation_interface_assignment_value avalon_jtag_slave embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value avalon_jtag_slave embeddedsw.configuration.isPrintableDevice {1}
	set_instantiation_interface_sysinfo_parameter_value avalon_jtag_slave address_map {<address-map><slave name='avalon_jtag_slave' start='0x0' end='0x8' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value avalon_jtag_slave address_width {3}
	set_instantiation_interface_sysinfo_parameter_value avalon_jtag_slave max_slave_data_width {32}
	add_instantiation_interface_port avalon_jtag_slave av_chipselect chipselect 1 STD_LOGIC Input
	add_instantiation_interface_port avalon_jtag_slave av_address address 1 STD_LOGIC Input
	add_instantiation_interface_port avalon_jtag_slave av_read_n read_n 1 STD_LOGIC Input
	add_instantiation_interface_port avalon_jtag_slave av_readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port avalon_jtag_slave av_write_n write_n 1 STD_LOGIC Input
	add_instantiation_interface_port avalon_jtag_slave av_writedata writedata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port avalon_jtag_slave av_waitrequest waitrequest 1 STD_LOGIC Output
	add_instantiation_interface irq interrupt INPUT
	set_instantiation_interface_parameter_value irq associatedAddressablePoint {avalon_jtag_slave}
	set_instantiation_interface_parameter_value irq associatedClock {clk}
	set_instantiation_interface_parameter_value irq associatedReset {reset}
	set_instantiation_interface_parameter_value irq bridgedReceiverOffset {0}
	set_instantiation_interface_parameter_value irq bridgesToReceiver {}
	set_instantiation_interface_parameter_value irq irqScheme {NONE}
	add_instantiation_interface_port irq av_irq irq 1 STD_LOGIC Output
	save_instantiation
	add_component mm_bridge_peripheral ip/nios_system/mm_bridge_peripheral.ip altera_avalon_mm_bridge mm_bridge_peripheral
	load_component mm_bridge_peripheral
	set_component_parameter_value ADDRESS_UNITS {SYMBOLS}
	set_component_parameter_value ADDRESS_WIDTH {18}
	set_component_parameter_value DATA_WIDTH {32}
	set_component_parameter_value LINEWRAPBURSTS {0}
	set_component_parameter_value M0_WAITREQUEST_ALLOWANCE {0}
	set_component_parameter_value MAX_BURST_SIZE {1}
	set_component_parameter_value MAX_PENDING_RESPONSES {4}
	set_component_parameter_value MAX_PENDING_WRITES {0}
	set_component_parameter_value PIPELINE_COMMAND {1}
	set_component_parameter_value PIPELINE_RESPONSE {1}
	set_component_parameter_value S0_WAITREQUEST_ALLOWANCE {0}
	set_component_parameter_value SYMBOL_WIDTH {8}
	set_component_parameter_value SYNC_RESET {1}
	set_component_parameter_value USE_AUTO_ADDRESS_WIDTH {0}
	set_component_parameter_value USE_RESPONSE {0}
	set_component_parameter_value USE_WRITERESPONSE {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation mm_bridge_peripheral
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clk clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clk}
	set_instantiation_interface_parameter_value reset synchronousEdges {BOTH}
	add_instantiation_interface_port reset reset reset 1 STD_LOGIC Input
	add_instantiation_interface s0 avalon INPUT
	set_instantiation_interface_parameter_value s0 addressAlignment {DYNAMIC}
	set_instantiation_interface_parameter_value s0 addressGroup {0}
	set_instantiation_interface_parameter_value s0 addressSpan {262144}
	set_instantiation_interface_parameter_value s0 addressUnits {SYMBOLS}
	set_instantiation_interface_parameter_value s0 alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value s0 associatedClock {clk}
	set_instantiation_interface_parameter_value s0 associatedReset {reset}
	set_instantiation_interface_parameter_value s0 bitsPerSymbol {8}
	set_instantiation_interface_parameter_value s0 bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value s0 bridgesToMaster {m0}
	set_instantiation_interface_parameter_value s0 burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value s0 burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value s0 constantBurstBehavior {false}
	set_instantiation_interface_parameter_value s0 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value s0 dfhFeatureId {35}
	set_instantiation_interface_parameter_value s0 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value s0 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value s0 dfhFeatureType {3}
	set_instantiation_interface_parameter_value s0 dfhGroupId {0}
	set_instantiation_interface_parameter_value s0 dfhParameterData {}
	set_instantiation_interface_parameter_value s0 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value s0 dfhParameterId {}
	set_instantiation_interface_parameter_value s0 dfhParameterName {}
	set_instantiation_interface_parameter_value s0 dfhParameterVersion {}
	set_instantiation_interface_parameter_value s0 explicitAddressSpan {0}
	set_instantiation_interface_parameter_value s0 holdTime {0}
	set_instantiation_interface_parameter_value s0 interleaveBursts {false}
	set_instantiation_interface_parameter_value s0 isBigEndian {false}
	set_instantiation_interface_parameter_value s0 isFlash {false}
	set_instantiation_interface_parameter_value s0 isMemoryDevice {false}
	set_instantiation_interface_parameter_value s0 isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value s0 linewrapBursts {false}
	set_instantiation_interface_parameter_value s0 maximumPendingReadTransactions {4}
	set_instantiation_interface_parameter_value s0 maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value s0 minimumReadLatency {1}
	set_instantiation_interface_parameter_value s0 minimumResponseLatency {1}
	set_instantiation_interface_parameter_value s0 minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value s0 prSafe {false}
	set_instantiation_interface_parameter_value s0 printableDevice {false}
	set_instantiation_interface_parameter_value s0 readLatency {0}
	set_instantiation_interface_parameter_value s0 readWaitStates {0}
	set_instantiation_interface_parameter_value s0 readWaitTime {0}
	set_instantiation_interface_parameter_value s0 registerIncomingSignals {false}
	set_instantiation_interface_parameter_value s0 registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value s0 setupTime {0}
	set_instantiation_interface_parameter_value s0 timingUnits {Cycles}
	set_instantiation_interface_parameter_value s0 transparentBridge {false}
	set_instantiation_interface_parameter_value s0 waitrequestAllowance {0}
	set_instantiation_interface_parameter_value s0 waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value s0 wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value s0 writeLatency {0}
	set_instantiation_interface_parameter_value s0 writeWaitStates {0}
	set_instantiation_interface_parameter_value s0 writeWaitTime {0}
	set_instantiation_interface_assignment_value s0 embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value s0 embeddedsw.configuration.isMemoryDevice {0}
	set_instantiation_interface_assignment_value s0 embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value s0 embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_sysinfo_parameter_value s0 address_map {}
	set_instantiation_interface_sysinfo_parameter_value s0 address_width {}
	set_instantiation_interface_sysinfo_parameter_value s0 max_slave_data_width {}
	add_instantiation_interface_port s0 s0_waitrequest waitrequest 1 STD_LOGIC Output
	add_instantiation_interface_port s0 s0_readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s0 s0_readdatavalid readdatavalid 1 STD_LOGIC Output
	add_instantiation_interface_port s0 s0_burstcount burstcount 1 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_writedata writedata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_address address 18 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_write write 1 STD_LOGIC Input
	add_instantiation_interface_port s0 s0_read read 1 STD_LOGIC Input
	add_instantiation_interface_port s0 s0_byteenable byteenable 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s0 s0_debugaccess debugaccess 1 STD_LOGIC Input
	add_instantiation_interface m0 avalon OUTPUT
	set_instantiation_interface_parameter_value m0 adaptsTo {}
	set_instantiation_interface_parameter_value m0 addressGroup {0}
	set_instantiation_interface_parameter_value m0 addressUnits {SYMBOLS}
	set_instantiation_interface_parameter_value m0 alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value m0 associatedClock {clk}
	set_instantiation_interface_parameter_value m0 associatedReset {reset}
	set_instantiation_interface_parameter_value m0 bitsPerSymbol {8}
	set_instantiation_interface_parameter_value m0 burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value m0 burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value m0 constantBurstBehavior {false}
	set_instantiation_interface_parameter_value m0 dBSBigEndian {false}
	set_instantiation_interface_parameter_value m0 doStreamReads {false}
	set_instantiation_interface_parameter_value m0 doStreamWrites {false}
	set_instantiation_interface_parameter_value m0 enableConcurrentSubordinateAccess {0}
	set_instantiation_interface_parameter_value m0 holdTime {0}
	set_instantiation_interface_parameter_value m0 interleaveBursts {false}
	set_instantiation_interface_parameter_value m0 isAsynchronous {false}
	set_instantiation_interface_parameter_value m0 isBigEndian {false}
	set_instantiation_interface_parameter_value m0 isReadable {false}
	set_instantiation_interface_parameter_value m0 isWriteable {false}
	set_instantiation_interface_parameter_value m0 linewrapBursts {false}
	set_instantiation_interface_parameter_value m0 maxAddressWidth {32}
	set_instantiation_interface_parameter_value m0 maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value m0 maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value m0 minimumReadLatency {1}
	set_instantiation_interface_parameter_value m0 minimumResponseLatency {1}
	set_instantiation_interface_parameter_value m0 optimizedReadsWithBE {0}
	set_instantiation_interface_parameter_value m0 prSafe {false}
	set_instantiation_interface_parameter_value m0 readLatency {0}
	set_instantiation_interface_parameter_value m0 readWaitTime {1}
	set_instantiation_interface_parameter_value m0 registerIncomingSignals {false}
	set_instantiation_interface_parameter_value m0 registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value m0 setupTime {0}
	set_instantiation_interface_parameter_value m0 timingUnits {Cycles}
	set_instantiation_interface_parameter_value m0 waitrequestAllowance {0}
	set_instantiation_interface_parameter_value m0 waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value m0 writeWaitTime {0}
	add_instantiation_interface_port m0 m0_waitrequest waitrequest 1 STD_LOGIC Input
	add_instantiation_interface_port m0 m0_readdata readdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port m0 m0_readdatavalid readdatavalid 1 STD_LOGIC Input
	add_instantiation_interface_port m0 m0_burstcount burstcount 1 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_writedata writedata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_address address 18 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_write write 1 STD_LOGIC Output
	add_instantiation_interface_port m0 m0_read read 1 STD_LOGIC Output
	add_instantiation_interface_port m0 m0_byteenable byteenable 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port m0 m0_debugaccess debugaccess 1 STD_LOGIC Output
	save_instantiation
	add_component niosv_g ip/nios_system/niosv_g.ip intel_niosv_g niosv_g
	load_component niosv_g
	set_component_parameter_value Blind_Window_Period {1000}
	set_component_parameter_value CLICenabledInterruptMode {0}
	set_component_parameter_value CLICenabledShadowRegisterFiles {1}
	set_component_parameter_value CUSTOM_OP {}
	set_component_parameter_value Default_Timeout_Period {255}
	set_component_parameter_value SUB_OP {}
	set_component_parameter_value alignCLICVectorTable {8}
	set_component_parameter_value basicInterruptMode {0}
	set_component_parameter_value basicShadowRegisterFiles {0}
	set_component_parameter_value dataCacheSize {4096}
	set_component_parameter_value disableFsqrtFdiv {0}
	set_component_parameter_value dtcm1Base {0}
	set_component_parameter_value dtcm1InitFile {}
	set_component_parameter_value dtcm1Size {0}
	set_component_parameter_value dtcm2Base {0}
	set_component_parameter_value dtcm2InitFile {}
	set_component_parameter_value dtcm2Size {0}
	set_component_parameter_value enableBranchPrediction {1}
	set_component_parameter_value enableCLICInterruptEdgeTriggerConfig {0}
	set_component_parameter_value enableCLICInterruptPolarityConfig {0}
	set_component_parameter_value enableCLICSelectiveHardwareVectoring {0}
	set_component_parameter_value enableCoreLevelInterruptController {0}
	set_component_parameter_value enableDebug {1}
	set_component_parameter_value enableDebugReset {0}
	set_component_parameter_value enableECCFull {0}
	set_component_parameter_value enableECCLite {0}
	set_component_parameter_value enableFPU {0}
	set_component_parameter_value enableLockstep {0}
	set_component_parameter_value enableLockstepExtRst {0}
	set_component_parameter_value enableMulDiv {1}
	set_component_parameter_value funct3 {}
	set_component_parameter_value funct7_l {}
	set_component_parameter_value funct7_u {}
	set_component_parameter_value hartId {0}
	set_component_parameter_value instCacheSize {4096}
	set_component_parameter_value itcm1Base {0}
	set_component_parameter_value itcm1InitFile {}
	set_component_parameter_value itcm1Size {0}
	set_component_parameter_value itcm2Base {0}
	set_component_parameter_value itcm2InitFile {}
	set_component_parameter_value itcm2Size {0}
	set_component_parameter_value mnemonic {}
	set_component_parameter_value numCLICDebugTriggers {0}
	set_component_parameter_value numCLICLevels {2}
	set_component_parameter_value numCLICPlatformInterrupts {16}
	set_component_parameter_value numCLICPriorities {8}
	set_component_parameter_value opcode {}
	set_component_parameter_value peripheralRegionABase {524288}
	set_component_parameter_value peripheralRegionASize {524288}
	set_component_parameter_value peripheralRegionBBase {0}
	set_component_parameter_value peripheralRegionBSize {0}
	set_component_parameter_value resetOffset {0}
	set_component_parameter_value resetSlave {sdram.axi4_slave}
	set_component_parameter_value useResetReq {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation niosv_g
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.CLIC_EN {false}
	set_instantiation_assignment_value embeddedsw.CMacro.CPU_FREQ {80000000u}
	set_instantiation_assignment_value embeddedsw.CMacro.DATA_ADDR_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.CMacro.DCACHE_LINE_SIZE {32}
	set_instantiation_assignment_value embeddedsw.CMacro.DCACHE_LINE_SIZE_LOG2 {5}
	set_instantiation_assignment_value embeddedsw.CMacro.DCACHE_SIZE {4096}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_CSR_SUPPORT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_DEBUG_STUB {}
	set_instantiation_assignment_value embeddedsw.CMacro.ICACHE_LINE_SIZE {32}
	set_instantiation_assignment_value embeddedsw.CMacro.ICACHE_LINE_SIZE_LOG2 {5}
	set_instantiation_assignment_value embeddedsw.CMacro.ICACHE_SIZE {4096}
	set_instantiation_assignment_value embeddedsw.CMacro.INST_ADDR_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.CMacro.INT_MODE {0}
	set_instantiation_assignment_value embeddedsw.CMacro.MTIME_OFFSET {0x00011000}
	set_instantiation_assignment_value embeddedsw.CMacro.NIOSV_CORE_VARIANT {3}
	set_instantiation_assignment_value embeddedsw.CMacro.NUM_GPR {32}
	set_instantiation_assignment_value embeddedsw.CMacro.NUM_SRF_BANKS {1}
	set_instantiation_assignment_value embeddedsw.CMacro.RESET_ADDR {0x04000000}
	set_instantiation_assignment_value embeddedsw.CMacro.TICKS_PER_SEC {no_quote(NIOSV_INTERNAL_TIMER_TICKS_PER_SECOND)}
	set_instantiation_assignment_value embeddedsw.CMacro.TIMER_DEVICE_TYPE {2}
	set_instantiation_assignment_value embeddedsw.configuration.HDLSimCachesCleared {1}
	set_instantiation_assignment_value embeddedsw.configuration.NiosVDTCM1Base {0}
	set_instantiation_assignment_value embeddedsw.configuration.NiosVDTCM1Size {0}
	set_instantiation_assignment_value embeddedsw.configuration.NiosVDTCM2Base {0}
	set_instantiation_assignment_value embeddedsw.configuration.NiosVDTCM2Size {0}
	set_instantiation_assignment_value embeddedsw.configuration.NiosVITCM1Base {0}
	set_instantiation_assignment_value embeddedsw.configuration.NiosVITCM1Size {0}
	set_instantiation_assignment_value embeddedsw.configuration.NiosVITCM2Base {0}
	set_instantiation_assignment_value embeddedsw.configuration.NiosVITCM2Size {0}
	set_instantiation_assignment_value embeddedsw.configuration.NiosVTCMVersion {4.0.0}
	set_instantiation_assignment_value embeddedsw.configuration.cpuArchitecture {Bantam Lake}
	set_instantiation_assignment_value embeddedsw.configuration.fpuEnabled {0}
	set_instantiation_assignment_value embeddedsw.configuration.fsqrtFdivDisabled {0}
	set_instantiation_assignment_value embeddedsw.configuration.interruptMode {0}
	set_instantiation_assignment_value embeddedsw.configuration.isTimerDevice {1}
	set_instantiation_assignment_value embeddedsw.configuration.numGpr {32}
	set_instantiation_assignment_value embeddedsw.configuration.resetOffset {0}
	set_instantiation_assignment_value embeddedsw.configuration.resetSlave {sdram.axi4_slave}
	set_instantiation_assignment_value embeddedsw.dts.params.altr,reset-addr {0x04000000}
	set_instantiation_assignment_value embeddedsw.dts.params.clock-frequency {80000000u}
	set_instantiation_assignment_value embeddedsw.dts.params.dcache-line-size {32}
	set_instantiation_assignment_value embeddedsw.dts.params.dcache-size {4096}
	set_instantiation_assignment_value embeddedsw.dts.params.icache-line-size {32}
	set_instantiation_assignment_value embeddedsw.dts.params.icache-size {4096}
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clk clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clk}
	set_instantiation_interface_parameter_value reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset reset_reset reset 1 STD_LOGIC Input
	add_instantiation_interface platform_irq_rx interrupt OUTPUT
	set_instantiation_interface_parameter_value platform_irq_rx associatedAddressablePoint {}
	set_instantiation_interface_parameter_value platform_irq_rx associatedClock {clk}
	set_instantiation_interface_parameter_value platform_irq_rx associatedReset {reset}
	set_instantiation_interface_parameter_value platform_irq_rx irqMap {}
	set_instantiation_interface_parameter_value platform_irq_rx irqScheme {INDIVIDUAL_REQUESTS}
	add_instantiation_interface_port platform_irq_rx platform_irq_rx_irq irq 16 STD_LOGIC_VECTOR Input
	add_instantiation_interface instruction_manager axi4 OUTPUT
	set_instantiation_interface_parameter_value instruction_manager addressCheck {false}
	set_instantiation_interface_parameter_value instruction_manager associatedClock {clk}
	set_instantiation_interface_parameter_value instruction_manager associatedReset {reset}
	set_instantiation_interface_parameter_value instruction_manager combinedIssuingCapability {8}
	set_instantiation_interface_parameter_value instruction_manager dataCheck {false}
	set_instantiation_interface_parameter_value instruction_manager enableConcurrentSubordinateAccess {0}
	set_instantiation_interface_parameter_value instruction_manager isTranslator {false}
	set_instantiation_interface_parameter_value instruction_manager issuesFIXEDBursts {true}
	set_instantiation_interface_parameter_value instruction_manager issuesINCRBursts {true}
	set_instantiation_interface_parameter_value instruction_manager issuesWRAPBursts {true}
	set_instantiation_interface_parameter_value instruction_manager maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value instruction_manager maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value instruction_manager maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value instruction_manager noRepeatedIdsBetweenSubordinates {0}
	set_instantiation_interface_parameter_value instruction_manager optionalAssociatedReset {false}
	set_instantiation_interface_parameter_value instruction_manager poison {false}
	set_instantiation_interface_parameter_value instruction_manager readIssuingCapability {8}
	set_instantiation_interface_parameter_value instruction_manager securityAttribute {false}
	set_instantiation_interface_parameter_value instruction_manager traceSignals {false}
	set_instantiation_interface_parameter_value instruction_manager trustzoneAware {true}
	set_instantiation_interface_parameter_value instruction_manager uniqueIdSupport {false}
	set_instantiation_interface_parameter_value instruction_manager userData {false}
	set_instantiation_interface_parameter_value instruction_manager wakeupSignals {false}
	set_instantiation_interface_parameter_value instruction_manager writeIssuingCapability {1}
	add_instantiation_interface_port instruction_manager instruction_manager_awsize awsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_awlen awlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_awburst awburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_wlast wlast 1 STD_LOGIC Output
	add_instantiation_interface_port instruction_manager instruction_manager_arsize arsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_arlen arlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_arburst arburst 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_rlast rlast 1 STD_LOGIC Input
	add_instantiation_interface_port instruction_manager instruction_manager_awaddr awaddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_awprot awprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_awvalid awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port instruction_manager instruction_manager_awready awready 1 STD_LOGIC Input
	add_instantiation_interface_port instruction_manager instruction_manager_wdata wdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_wstrb wstrb 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_wvalid wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port instruction_manager instruction_manager_wready wready 1 STD_LOGIC Input
	add_instantiation_interface_port instruction_manager instruction_manager_bresp bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port instruction_manager instruction_manager_bvalid bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port instruction_manager instruction_manager_bready bready 1 STD_LOGIC Output
	add_instantiation_interface_port instruction_manager instruction_manager_araddr araddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_arprot arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port instruction_manager instruction_manager_arvalid arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port instruction_manager instruction_manager_arready arready 1 STD_LOGIC Input
	add_instantiation_interface_port instruction_manager instruction_manager_rdata rdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port instruction_manager instruction_manager_rresp rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port instruction_manager instruction_manager_rvalid rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port instruction_manager instruction_manager_rready rready 1 STD_LOGIC Output
	add_instantiation_interface data_manager axi4 OUTPUT
	set_instantiation_interface_parameter_value data_manager addressCheck {false}
	set_instantiation_interface_parameter_value data_manager associatedClock {clk}
	set_instantiation_interface_parameter_value data_manager associatedReset {reset}
	set_instantiation_interface_parameter_value data_manager combinedIssuingCapability {1}
	set_instantiation_interface_parameter_value data_manager dataCheck {false}
	set_instantiation_interface_parameter_value data_manager enableConcurrentSubordinateAccess {0}
	set_instantiation_interface_parameter_value data_manager isTranslator {false}
	set_instantiation_interface_parameter_value data_manager issuesFIXEDBursts {true}
	set_instantiation_interface_parameter_value data_manager issuesINCRBursts {true}
	set_instantiation_interface_parameter_value data_manager issuesWRAPBursts {true}
	set_instantiation_interface_parameter_value data_manager maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value data_manager maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value data_manager maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value data_manager noRepeatedIdsBetweenSubordinates {0}
	set_instantiation_interface_parameter_value data_manager optionalAssociatedReset {false}
	set_instantiation_interface_parameter_value data_manager poison {false}
	set_instantiation_interface_parameter_value data_manager readIssuingCapability {1}
	set_instantiation_interface_parameter_value data_manager securityAttribute {false}
	set_instantiation_interface_parameter_value data_manager traceSignals {false}
	set_instantiation_interface_parameter_value data_manager trustzoneAware {true}
	set_instantiation_interface_parameter_value data_manager uniqueIdSupport {false}
	set_instantiation_interface_parameter_value data_manager userData {false}
	set_instantiation_interface_parameter_value data_manager wakeupSignals {false}
	set_instantiation_interface_parameter_value data_manager writeIssuingCapability {1}
	add_instantiation_interface_port data_manager data_manager_awsize awsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_awlen awlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_wlast wlast 1 STD_LOGIC Output
	add_instantiation_interface_port data_manager data_manager_arsize arsize 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_arlen arlen 8 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_rlast rlast 1 STD_LOGIC Input
	add_instantiation_interface_port data_manager data_manager_awaddr awaddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_awprot awprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_awvalid awvalid 1 STD_LOGIC Output
	add_instantiation_interface_port data_manager data_manager_awready awready 1 STD_LOGIC Input
	add_instantiation_interface_port data_manager data_manager_wdata wdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_wstrb wstrb 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_wvalid wvalid 1 STD_LOGIC Output
	add_instantiation_interface_port data_manager data_manager_wready wready 1 STD_LOGIC Input
	add_instantiation_interface_port data_manager data_manager_bresp bresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port data_manager data_manager_bvalid bvalid 1 STD_LOGIC Input
	add_instantiation_interface_port data_manager data_manager_bready bready 1 STD_LOGIC Output
	add_instantiation_interface_port data_manager data_manager_araddr araddr 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_arprot arprot 3 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port data_manager data_manager_arvalid arvalid 1 STD_LOGIC Output
	add_instantiation_interface_port data_manager data_manager_arready arready 1 STD_LOGIC Input
	add_instantiation_interface_port data_manager data_manager_rdata rdata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port data_manager data_manager_rresp rresp 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port data_manager data_manager_rvalid rvalid 1 STD_LOGIC Input
	add_instantiation_interface_port data_manager data_manager_rready rready 1 STD_LOGIC Output
	add_instantiation_interface timer_sw_agent avalon INPUT
	set_instantiation_interface_parameter_value timer_sw_agent addressAlignment {DYNAMIC}
	set_instantiation_interface_parameter_value timer_sw_agent addressGroup {0}
	set_instantiation_interface_parameter_value timer_sw_agent addressSpan {64}
	set_instantiation_interface_parameter_value timer_sw_agent addressUnits {SYMBOLS}
	set_instantiation_interface_parameter_value timer_sw_agent alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value timer_sw_agent associatedClock {clk}
	set_instantiation_interface_parameter_value timer_sw_agent associatedReset {reset}
	set_instantiation_interface_parameter_value timer_sw_agent bitsPerSymbol {8}
	set_instantiation_interface_parameter_value timer_sw_agent bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value timer_sw_agent bridgesToMaster {}
	set_instantiation_interface_parameter_value timer_sw_agent burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value timer_sw_agent burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value timer_sw_agent constantBurstBehavior {false}
	set_instantiation_interface_parameter_value timer_sw_agent dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value timer_sw_agent dfhFeatureId {35}
	set_instantiation_interface_parameter_value timer_sw_agent dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value timer_sw_agent dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value timer_sw_agent dfhFeatureType {3}
	set_instantiation_interface_parameter_value timer_sw_agent dfhGroupId {0}
	set_instantiation_interface_parameter_value timer_sw_agent dfhParameterData {}
	set_instantiation_interface_parameter_value timer_sw_agent dfhParameterDataLength {}
	set_instantiation_interface_parameter_value timer_sw_agent dfhParameterId {}
	set_instantiation_interface_parameter_value timer_sw_agent dfhParameterName {}
	set_instantiation_interface_parameter_value timer_sw_agent dfhParameterVersion {}
	set_instantiation_interface_parameter_value timer_sw_agent explicitAddressSpan {0}
	set_instantiation_interface_parameter_value timer_sw_agent holdTime {0}
	set_instantiation_interface_parameter_value timer_sw_agent interleaveBursts {false}
	set_instantiation_interface_parameter_value timer_sw_agent isBigEndian {false}
	set_instantiation_interface_parameter_value timer_sw_agent isFlash {false}
	set_instantiation_interface_parameter_value timer_sw_agent isMemoryDevice {false}
	set_instantiation_interface_parameter_value timer_sw_agent isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value timer_sw_agent linewrapBursts {false}
	set_instantiation_interface_parameter_value timer_sw_agent maximumPendingReadTransactions {2}
	set_instantiation_interface_parameter_value timer_sw_agent maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value timer_sw_agent minimumReadLatency {1}
	set_instantiation_interface_parameter_value timer_sw_agent minimumResponseLatency {1}
	set_instantiation_interface_parameter_value timer_sw_agent minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value timer_sw_agent prSafe {false}
	set_instantiation_interface_parameter_value timer_sw_agent printableDevice {false}
	set_instantiation_interface_parameter_value timer_sw_agent readLatency {0}
	set_instantiation_interface_parameter_value timer_sw_agent readWaitStates {1}
	set_instantiation_interface_parameter_value timer_sw_agent readWaitTime {1}
	set_instantiation_interface_parameter_value timer_sw_agent registerIncomingSignals {false}
	set_instantiation_interface_parameter_value timer_sw_agent registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value timer_sw_agent setupTime {0}
	set_instantiation_interface_parameter_value timer_sw_agent timingUnits {Cycles}
	set_instantiation_interface_parameter_value timer_sw_agent transparentBridge {false}
	set_instantiation_interface_parameter_value timer_sw_agent waitrequestAllowance {0}
	set_instantiation_interface_parameter_value timer_sw_agent waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value timer_sw_agent wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value timer_sw_agent writeLatency {0}
	set_instantiation_interface_parameter_value timer_sw_agent writeWaitStates {0}
	set_instantiation_interface_parameter_value timer_sw_agent writeWaitTime {0}
	set_instantiation_interface_assignment_value timer_sw_agent embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value timer_sw_agent embeddedsw.configuration.isMemoryDevice {0}
	set_instantiation_interface_assignment_value timer_sw_agent embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value timer_sw_agent embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_assignment_value timer_sw_agent qsys.ui.connect {data_manager}
	set_instantiation_interface_sysinfo_parameter_value timer_sw_agent address_map {<address-map><slave name='timer_sw_agent' start='0x0' end='0x40' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value timer_sw_agent address_width {6}
	set_instantiation_interface_sysinfo_parameter_value timer_sw_agent max_slave_data_width {32}
	add_instantiation_interface_port timer_sw_agent timer_sw_agent_address address 6 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port timer_sw_agent timer_sw_agent_byteenable byteenable 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port timer_sw_agent timer_sw_agent_read read 1 STD_LOGIC Input
	add_instantiation_interface_port timer_sw_agent timer_sw_agent_readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port timer_sw_agent timer_sw_agent_write write 1 STD_LOGIC Input
	add_instantiation_interface_port timer_sw_agent timer_sw_agent_writedata writedata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port timer_sw_agent timer_sw_agent_waitrequest waitrequest 1 STD_LOGIC Output
	add_instantiation_interface_port timer_sw_agent timer_sw_agent_readdatavalid readdatavalid 1 STD_LOGIC Output
	add_instantiation_interface dm_agent avalon INPUT
	set_instantiation_interface_parameter_value dm_agent addressAlignment {DYNAMIC}
	set_instantiation_interface_parameter_value dm_agent addressGroup {0}
	set_instantiation_interface_parameter_value dm_agent addressSpan {65536}
	set_instantiation_interface_parameter_value dm_agent addressUnits {SYMBOLS}
	set_instantiation_interface_parameter_value dm_agent alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value dm_agent associatedClock {clk}
	set_instantiation_interface_parameter_value dm_agent associatedReset {reset}
	set_instantiation_interface_parameter_value dm_agent bitsPerSymbol {8}
	set_instantiation_interface_parameter_value dm_agent bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value dm_agent bridgesToMaster {}
	set_instantiation_interface_parameter_value dm_agent burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value dm_agent burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value dm_agent constantBurstBehavior {false}
	set_instantiation_interface_parameter_value dm_agent dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value dm_agent dfhFeatureId {35}
	set_instantiation_interface_parameter_value dm_agent dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value dm_agent dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value dm_agent dfhFeatureType {3}
	set_instantiation_interface_parameter_value dm_agent dfhGroupId {0}
	set_instantiation_interface_parameter_value dm_agent dfhParameterData {}
	set_instantiation_interface_parameter_value dm_agent dfhParameterDataLength {}
	set_instantiation_interface_parameter_value dm_agent dfhParameterId {}
	set_instantiation_interface_parameter_value dm_agent dfhParameterName {}
	set_instantiation_interface_parameter_value dm_agent dfhParameterVersion {}
	set_instantiation_interface_parameter_value dm_agent explicitAddressSpan {0}
	set_instantiation_interface_parameter_value dm_agent holdTime {0}
	set_instantiation_interface_parameter_value dm_agent interleaveBursts {false}
	set_instantiation_interface_parameter_value dm_agent isBigEndian {false}
	set_instantiation_interface_parameter_value dm_agent isFlash {false}
	set_instantiation_interface_parameter_value dm_agent isMemoryDevice {false}
	set_instantiation_interface_parameter_value dm_agent isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value dm_agent linewrapBursts {false}
	set_instantiation_interface_parameter_value dm_agent maximumPendingReadTransactions {2}
	set_instantiation_interface_parameter_value dm_agent maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value dm_agent minimumReadLatency {1}
	set_instantiation_interface_parameter_value dm_agent minimumResponseLatency {1}
	set_instantiation_interface_parameter_value dm_agent minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value dm_agent prSafe {false}
	set_instantiation_interface_parameter_value dm_agent printableDevice {false}
	set_instantiation_interface_parameter_value dm_agent readLatency {0}
	set_instantiation_interface_parameter_value dm_agent readWaitStates {1}
	set_instantiation_interface_parameter_value dm_agent readWaitTime {1}
	set_instantiation_interface_parameter_value dm_agent registerIncomingSignals {false}
	set_instantiation_interface_parameter_value dm_agent registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value dm_agent setupTime {0}
	set_instantiation_interface_parameter_value dm_agent timingUnits {Cycles}
	set_instantiation_interface_parameter_value dm_agent transparentBridge {false}
	set_instantiation_interface_parameter_value dm_agent waitrequestAllowance {0}
	set_instantiation_interface_parameter_value dm_agent waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value dm_agent wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value dm_agent writeLatency {0}
	set_instantiation_interface_parameter_value dm_agent writeWaitStates {0}
	set_instantiation_interface_parameter_value dm_agent writeWaitTime {0}
	set_instantiation_interface_assignment_value dm_agent embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value dm_agent embeddedsw.configuration.isMemoryDevice {0}
	set_instantiation_interface_assignment_value dm_agent embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value dm_agent embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_assignment_value dm_agent qsys.ui.connect {instruction_manager,data_manager}
	set_instantiation_interface_sysinfo_parameter_value dm_agent address_map {<address-map><slave name='dm_agent' start='0x0' end='0x10000' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value dm_agent address_width {16}
	set_instantiation_interface_sysinfo_parameter_value dm_agent max_slave_data_width {32}
	add_instantiation_interface_port dm_agent dm_agent_address address 16 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port dm_agent dm_agent_read read 1 STD_LOGIC Input
	add_instantiation_interface_port dm_agent dm_agent_readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port dm_agent dm_agent_write write 1 STD_LOGIC Input
	add_instantiation_interface_port dm_agent dm_agent_writedata writedata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port dm_agent dm_agent_waitrequest waitrequest 1 STD_LOGIC Output
	add_instantiation_interface_port dm_agent dm_agent_readdatavalid readdatavalid 1 STD_LOGIC Output
	save_instantiation
	add_component onchip_memory ip/nios_system/onchip_memory.ip intel_onchip_memory onchip_memory
	load_component onchip_memory
	set_component_parameter_value AXI_interface {1}
	set_component_parameter_value allowInSystemMemoryContentEditor {0}
	set_component_parameter_value blockType {AUTO}
	set_component_parameter_value clockEnable {0}
	set_component_parameter_value copyInitFile {0}
	set_component_parameter_value dataWidth {32}
	set_component_parameter_value dataWidth2 {32}
	set_component_parameter_value dualPort {0}
	set_component_parameter_value ecc_check {0}
	set_component_parameter_value ecc_encoder_bypass {0}
	set_component_parameter_value ecc_pipeline_reg {0}
	set_component_parameter_value enPRInitMode {0}
	set_component_parameter_value enableDiffWidth {0}
	set_component_parameter_value gui_debugaccess {0}
	set_component_parameter_value idWidth {1}
	set_component_parameter_value initMemContent {0}
	set_component_parameter_value initializationFileName {ram.hex}
	set_component_parameter_value instanceID {NONE}
	set_component_parameter_value interfaceType {0}
	set_component_parameter_value lvl1OutputRegA {0}
	set_component_parameter_value lvl1OutputRegB {0}
	set_component_parameter_value lvl2OutputRegA {0}
	set_component_parameter_value lvl2OutputRegB {0}
	set_component_parameter_value memorySize {524280.0}
	set_component_parameter_value poison_enable {0}
	set_component_parameter_value readDuringWriteMode_Mixed {DONT_CARE}
	set_component_parameter_value resetrequest_enabled {1}
	set_component_parameter_value singleClockOperation {0}
	set_component_parameter_value tightly_coupled_ecc {0}
	set_component_parameter_value useNonDefaultInitFile {0}
	set_component_parameter_value writable {1}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation onchip_memory
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CONTENTS_INFO {""}
	set_instantiation_assignment_value embeddedsw.CMacro.DUAL_PORT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.GUI_RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_CONTENTS_FILE {UNUSED}
	set_instantiation_assignment_value embeddedsw.CMacro.INIT_MEM_CONTENT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.INSTANCE_ID {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.NON_DEFAULT_INIT_FILE_ENABLED {0}
	set_instantiation_assignment_value embeddedsw.CMacro.RAM_BLOCK_TYPE {AUTO}
	set_instantiation_assignment_value embeddedsw.CMacro.READ_DURING_WRITE_MODE {DONT_CARE}
	set_instantiation_assignment_value embeddedsw.CMacro.SINGLE_CLOCK_OP {0}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_MULTIPLE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.SIZE_VALUE {524280}
	set_instantiation_assignment_value embeddedsw.CMacro.WRITABLE {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.DAT_SYM_INSTALL_DIR {SIM_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_DAT_SYM {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.GENERATE_HEX {1}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HAS_BYTE_LANE {0}
	set_instantiation_assignment_value embeddedsw.memoryInfo.HEX_INSTALL_DIR {QPF_DIR}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_DATA_WIDTH {32}
	set_instantiation_assignment_value embeddedsw.memoryInfo.MEM_INIT_FILENAME {UNUSED}
	set_instantiation_assignment_value postgeneration.simulation.init_file.param_name {INIT_FILE}
	set_instantiation_assignment_value postgeneration.simulation.init_file.type {MEM_INIT}
	add_instantiation_interface clk1 clock INPUT
	set_instantiation_interface_parameter_value clk1 clockRate {0}
	set_instantiation_interface_parameter_value clk1 externallyDriven {false}
	set_instantiation_interface_parameter_value clk1 ptfSchematicName {}
	add_instantiation_interface_port clk1 clk clk 1 STD_LOGIC Input
	add_instantiation_interface s1 avalon INPUT
	set_instantiation_interface_parameter_value s1 addressAlignment {DYNAMIC}
	set_instantiation_interface_parameter_value s1 addressGroup {0}
	set_instantiation_interface_parameter_value s1 addressSpan {524280}
	set_instantiation_interface_parameter_value s1 addressUnits {WORDS}
	set_instantiation_interface_parameter_value s1 alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value s1 associatedClock {clk1}
	set_instantiation_interface_parameter_value s1 associatedReset {reset1}
	set_instantiation_interface_parameter_value s1 bitsPerSymbol {8}
	set_instantiation_interface_parameter_value s1 bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value s1 burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value s1 burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value s1 constantBurstBehavior {false}
	set_instantiation_interface_parameter_value s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value s1 dfhParameterData {}
	set_instantiation_interface_parameter_value s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value s1 dfhParameterId {}
	set_instantiation_interface_parameter_value s1 dfhParameterName {}
	set_instantiation_interface_parameter_value s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value s1 explicitAddressSpan {524280}
	set_instantiation_interface_parameter_value s1 holdTime {0}
	set_instantiation_interface_parameter_value s1 interleaveBursts {false}
	set_instantiation_interface_parameter_value s1 isBigEndian {false}
	set_instantiation_interface_parameter_value s1 isFlash {false}
	set_instantiation_interface_parameter_value s1 isMemoryDevice {true}
	set_instantiation_interface_parameter_value s1 isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value s1 linewrapBursts {false}
	set_instantiation_interface_parameter_value s1 maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value s1 maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value s1 minimumReadLatency {1}
	set_instantiation_interface_parameter_value s1 minimumResponseLatency {1}
	set_instantiation_interface_parameter_value s1 minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value s1 prSafe {false}
	set_instantiation_interface_parameter_value s1 printableDevice {false}
	set_instantiation_interface_parameter_value s1 readLatency {1}
	set_instantiation_interface_parameter_value s1 readWaitStates {0}
	set_instantiation_interface_parameter_value s1 readWaitTime {0}
	set_instantiation_interface_parameter_value s1 registerIncomingSignals {false}
	set_instantiation_interface_parameter_value s1 registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value s1 setupTime {0}
	set_instantiation_interface_parameter_value s1 timingUnits {Cycles}
	set_instantiation_interface_parameter_value s1 transparentBridge {false}
	set_instantiation_interface_parameter_value s1 waitrequestAllowance {0}
	set_instantiation_interface_parameter_value s1 waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value s1 wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value s1 writeLatency {0}
	set_instantiation_interface_parameter_value s1 writeWaitStates {0}
	set_instantiation_interface_parameter_value s1 writeWaitTime {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isMemoryDevice {1}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_sysinfo_parameter_value s1 address_map {<address-map><slave name='s1' start='0x0' end='0x7FFF8' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value s1 address_width {19}
	set_instantiation_interface_sysinfo_parameter_value s1 max_slave_data_width {32}
	add_instantiation_interface_port s1 address address 17 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 read read 1 STD_LOGIC Input
	add_instantiation_interface_port s1 readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port s1 byteenable byteenable 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 write write 1 STD_LOGIC Input
	add_instantiation_interface_port s1 writedata writedata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface reset1 reset INPUT
	set_instantiation_interface_parameter_value reset1 associatedClock {clk1}
	set_instantiation_interface_parameter_value reset1 synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset1 reset reset 1 STD_LOGIC Input
	add_instantiation_interface_port reset1 reset_req reset_req 1 STD_LOGIC Input
	save_instantiation
	add_component pio_key ip/nios_system/pio_key.ip altera_avalon_pio pio_key
	load_component pio_key
	set_component_parameter_value bitClearingEdgeCapReg {0}
	set_component_parameter_value bitModifyingOutReg {0}
	set_component_parameter_value captureEdge {1}
	set_component_parameter_value direction {Input}
	set_component_parameter_value edgeType {FALLING}
	set_component_parameter_value generateIRQ {1}
	set_component_parameter_value irqType {EDGE}
	set_component_parameter_value resetValue {0.0}
	set_component_parameter_value simDoTestBenchWiring {0}
	set_component_parameter_value simDrivenValue {4.0}
	set_component_parameter_value width {4}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation pio_key
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.BIT_CLEARING_EDGE_REGISTER {0}
	set_instantiation_assignment_value embeddedsw.CMacro.BIT_MODIFYING_OUTPUT_REGISTER {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CAPTURE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.DATA_WIDTH {4}
	set_instantiation_assignment_value embeddedsw.CMacro.DO_TEST_BENCH_WIRING {0}
	set_instantiation_assignment_value embeddedsw.CMacro.DRIVEN_SIM_VALUE {4}
	set_instantiation_assignment_value embeddedsw.CMacro.EDGE_TYPE {FALLING}
	set_instantiation_assignment_value embeddedsw.CMacro.FREQ {80000000}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_IN {1}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_OUT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_TRI {0}
	set_instantiation_assignment_value embeddedsw.CMacro.IRQ_TYPE {EDGE}
	set_instantiation_assignment_value embeddedsw.CMacro.RESET_VALUE {0}
	set_instantiation_assignment_value embeddedsw.dts.compatible {altr,pio-1.0}
	set_instantiation_assignment_value embeddedsw.dts.group {gpio}
	set_instantiation_assignment_value embeddedsw.dts.name {pio}
	set_instantiation_assignment_value embeddedsw.dts.params.altr,gpio-bank-width {4}
	set_instantiation_assignment_value embeddedsw.dts.params.altr,interrupt-type {2}
	set_instantiation_assignment_value embeddedsw.dts.params.altr,interrupt_type {2}
	set_instantiation_assignment_value embeddedsw.dts.params.edge_type {1}
	set_instantiation_assignment_value embeddedsw.dts.params.level_trigger {0}
	set_instantiation_assignment_value embeddedsw.dts.params.resetvalue {0}
	set_instantiation_assignment_value embeddedsw.dts.vendor {altr}
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clk clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clk}
	set_instantiation_interface_parameter_value reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset reset_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface s1 avalon INPUT
	set_instantiation_interface_parameter_value s1 addressAlignment {NATIVE}
	set_instantiation_interface_parameter_value s1 addressGroup {0}
	set_instantiation_interface_parameter_value s1 addressSpan {4}
	set_instantiation_interface_parameter_value s1 addressUnits {WORDS}
	set_instantiation_interface_parameter_value s1 alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value s1 associatedClock {clk}
	set_instantiation_interface_parameter_value s1 associatedReset {reset}
	set_instantiation_interface_parameter_value s1 bitsPerSymbol {8}
	set_instantiation_interface_parameter_value s1 bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value s1 burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value s1 burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value s1 constantBurstBehavior {false}
	set_instantiation_interface_parameter_value s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value s1 dfhParameterData {}
	set_instantiation_interface_parameter_value s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value s1 dfhParameterId {}
	set_instantiation_interface_parameter_value s1 dfhParameterName {}
	set_instantiation_interface_parameter_value s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value s1 explicitAddressSpan {0}
	set_instantiation_interface_parameter_value s1 holdTime {0}
	set_instantiation_interface_parameter_value s1 interleaveBursts {false}
	set_instantiation_interface_parameter_value s1 isBigEndian {false}
	set_instantiation_interface_parameter_value s1 isFlash {false}
	set_instantiation_interface_parameter_value s1 isMemoryDevice {false}
	set_instantiation_interface_parameter_value s1 isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value s1 linewrapBursts {false}
	set_instantiation_interface_parameter_value s1 maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value s1 maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value s1 minimumReadLatency {1}
	set_instantiation_interface_parameter_value s1 minimumResponseLatency {1}
	set_instantiation_interface_parameter_value s1 minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value s1 prSafe {false}
	set_instantiation_interface_parameter_value s1 printableDevice {false}
	set_instantiation_interface_parameter_value s1 readLatency {0}
	set_instantiation_interface_parameter_value s1 readWaitStates {1}
	set_instantiation_interface_parameter_value s1 readWaitTime {1}
	set_instantiation_interface_parameter_value s1 registerIncomingSignals {false}
	set_instantiation_interface_parameter_value s1 registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value s1 setupTime {0}
	set_instantiation_interface_parameter_value s1 timingUnits {Cycles}
	set_instantiation_interface_parameter_value s1 transparentBridge {false}
	set_instantiation_interface_parameter_value s1 waitrequestAllowance {0}
	set_instantiation_interface_parameter_value s1 waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value s1 wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value s1 writeLatency {0}
	set_instantiation_interface_parameter_value s1 writeWaitStates {0}
	set_instantiation_interface_parameter_value s1 writeWaitTime {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isMemoryDevice {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_sysinfo_parameter_value s1 address_map {<address-map><slave name='s1' start='0x0' end='0x10' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value s1 address_width {4}
	set_instantiation_interface_sysinfo_parameter_value s1 max_slave_data_width {32}
	add_instantiation_interface_port s1 address address 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 write_n write_n 1 STD_LOGIC Input
	add_instantiation_interface_port s1 writedata writedata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 chipselect chipselect 1 STD_LOGIC Input
	add_instantiation_interface_port s1 readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface external_connection conduit INPUT
	set_instantiation_interface_parameter_value external_connection associatedClock {}
	set_instantiation_interface_parameter_value external_connection associatedReset {}
	set_instantiation_interface_parameter_value external_connection prSafe {false}
	add_instantiation_interface_port external_connection in_port export 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface irq interrupt INPUT
	set_instantiation_interface_parameter_value irq associatedAddressablePoint {s1}
	set_instantiation_interface_parameter_value irq associatedClock {clk}
	set_instantiation_interface_parameter_value irq associatedReset {reset}
	set_instantiation_interface_parameter_value irq bridgedReceiverOffset {0}
	set_instantiation_interface_parameter_value irq bridgesToReceiver {}
	set_instantiation_interface_parameter_value irq irqScheme {NONE}
	set_instantiation_interface_assignment_value irq embeddedsw.dts.irq.tx_type {RISING_EDGE}
	add_instantiation_interface_port irq irq irq 1 STD_LOGIC Output
	save_instantiation
	add_component pio_led ip/nios_system/pio_led.ip altera_avalon_pio pio_led
	load_component pio_led
	set_component_parameter_value bitClearingEdgeCapReg {0}
	set_component_parameter_value bitModifyingOutReg {0}
	set_component_parameter_value captureEdge {0}
	set_component_parameter_value direction {Output}
	set_component_parameter_value edgeType {RISING}
	set_component_parameter_value generateIRQ {0}
	set_component_parameter_value irqType {LEVEL}
	set_component_parameter_value resetValue {0.0}
	set_component_parameter_value simDoTestBenchWiring {0}
	set_component_parameter_value simDrivenValue {0.0}
	set_component_parameter_value width {10}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation pio_led
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.BIT_CLEARING_EDGE_REGISTER {0}
	set_instantiation_assignment_value embeddedsw.CMacro.BIT_MODIFYING_OUTPUT_REGISTER {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CAPTURE {0}
	set_instantiation_assignment_value embeddedsw.CMacro.DATA_WIDTH {10}
	set_instantiation_assignment_value embeddedsw.CMacro.DO_TEST_BENCH_WIRING {0}
	set_instantiation_assignment_value embeddedsw.CMacro.DRIVEN_SIM_VALUE {0}
	set_instantiation_assignment_value embeddedsw.CMacro.EDGE_TYPE {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.FREQ {80000000}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_IN {0}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_OUT {1}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_TRI {0}
	set_instantiation_assignment_value embeddedsw.CMacro.IRQ_TYPE {NONE}
	set_instantiation_assignment_value embeddedsw.CMacro.RESET_VALUE {0}
	set_instantiation_assignment_value embeddedsw.dts.compatible {altr,pio-1.0}
	set_instantiation_assignment_value embeddedsw.dts.group {gpio}
	set_instantiation_assignment_value embeddedsw.dts.name {pio}
	set_instantiation_assignment_value embeddedsw.dts.params.altr,gpio-bank-width {10}
	set_instantiation_assignment_value embeddedsw.dts.params.resetvalue {0}
	set_instantiation_assignment_value embeddedsw.dts.vendor {altr}
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clk clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clk}
	set_instantiation_interface_parameter_value reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset reset_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface s1 avalon INPUT
	set_instantiation_interface_parameter_value s1 addressAlignment {NATIVE}
	set_instantiation_interface_parameter_value s1 addressGroup {0}
	set_instantiation_interface_parameter_value s1 addressSpan {4}
	set_instantiation_interface_parameter_value s1 addressUnits {WORDS}
	set_instantiation_interface_parameter_value s1 alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value s1 associatedClock {clk}
	set_instantiation_interface_parameter_value s1 associatedReset {reset}
	set_instantiation_interface_parameter_value s1 bitsPerSymbol {8}
	set_instantiation_interface_parameter_value s1 bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value s1 burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value s1 burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value s1 constantBurstBehavior {false}
	set_instantiation_interface_parameter_value s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value s1 dfhParameterData {}
	set_instantiation_interface_parameter_value s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value s1 dfhParameterId {}
	set_instantiation_interface_parameter_value s1 dfhParameterName {}
	set_instantiation_interface_parameter_value s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value s1 explicitAddressSpan {0}
	set_instantiation_interface_parameter_value s1 holdTime {0}
	set_instantiation_interface_parameter_value s1 interleaveBursts {false}
	set_instantiation_interface_parameter_value s1 isBigEndian {false}
	set_instantiation_interface_parameter_value s1 isFlash {false}
	set_instantiation_interface_parameter_value s1 isMemoryDevice {false}
	set_instantiation_interface_parameter_value s1 isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value s1 linewrapBursts {false}
	set_instantiation_interface_parameter_value s1 maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value s1 maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value s1 minimumReadLatency {1}
	set_instantiation_interface_parameter_value s1 minimumResponseLatency {1}
	set_instantiation_interface_parameter_value s1 minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value s1 prSafe {false}
	set_instantiation_interface_parameter_value s1 printableDevice {false}
	set_instantiation_interface_parameter_value s1 readLatency {0}
	set_instantiation_interface_parameter_value s1 readWaitStates {1}
	set_instantiation_interface_parameter_value s1 readWaitTime {1}
	set_instantiation_interface_parameter_value s1 registerIncomingSignals {false}
	set_instantiation_interface_parameter_value s1 registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value s1 setupTime {0}
	set_instantiation_interface_parameter_value s1 timingUnits {Cycles}
	set_instantiation_interface_parameter_value s1 transparentBridge {false}
	set_instantiation_interface_parameter_value s1 waitrequestAllowance {0}
	set_instantiation_interface_parameter_value s1 waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value s1 wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value s1 writeLatency {0}
	set_instantiation_interface_parameter_value s1 writeWaitStates {0}
	set_instantiation_interface_parameter_value s1 writeWaitTime {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isMemoryDevice {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_sysinfo_parameter_value s1 address_map {<address-map><slave name='s1' start='0x0' end='0x10' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value s1 address_width {4}
	set_instantiation_interface_sysinfo_parameter_value s1 max_slave_data_width {32}
	add_instantiation_interface_port s1 address address 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 write_n write_n 1 STD_LOGIC Input
	add_instantiation_interface_port s1 writedata writedata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 chipselect chipselect 1 STD_LOGIC Input
	add_instantiation_interface_port s1 readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface external_connection conduit INPUT
	set_instantiation_interface_parameter_value external_connection associatedClock {}
	set_instantiation_interface_parameter_value external_connection associatedReset {}
	set_instantiation_interface_parameter_value external_connection prSafe {false}
	add_instantiation_interface_port external_connection out_port export 10 STD_LOGIC_VECTOR Output
	save_instantiation
	add_component pio_sw ip/nios_system/pio_sw.ip altera_avalon_pio pio_sw
	load_component pio_sw
	set_component_parameter_value bitClearingEdgeCapReg {0}
	set_component_parameter_value bitModifyingOutReg {0}
	set_component_parameter_value captureEdge {1}
	set_component_parameter_value direction {Input}
	set_component_parameter_value edgeType {ANY}
	set_component_parameter_value generateIRQ {1}
	set_component_parameter_value irqType {EDGE}
	set_component_parameter_value resetValue {0.0}
	set_component_parameter_value simDoTestBenchWiring {1}
	set_component_parameter_value simDrivenValue {0.0}
	set_component_parameter_value width {10}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation pio_sw
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.BIT_CLEARING_EDGE_REGISTER {0}
	set_instantiation_assignment_value embeddedsw.CMacro.BIT_MODIFYING_OUTPUT_REGISTER {0}
	set_instantiation_assignment_value embeddedsw.CMacro.CAPTURE {1}
	set_instantiation_assignment_value embeddedsw.CMacro.DATA_WIDTH {10}
	set_instantiation_assignment_value embeddedsw.CMacro.DO_TEST_BENCH_WIRING {1}
	set_instantiation_assignment_value embeddedsw.CMacro.DRIVEN_SIM_VALUE {0}
	set_instantiation_assignment_value embeddedsw.CMacro.EDGE_TYPE {ANY}
	set_instantiation_assignment_value embeddedsw.CMacro.FREQ {80000000}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_IN {1}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_OUT {0}
	set_instantiation_assignment_value embeddedsw.CMacro.HAS_TRI {0}
	set_instantiation_assignment_value embeddedsw.CMacro.IRQ_TYPE {EDGE}
	set_instantiation_assignment_value embeddedsw.CMacro.RESET_VALUE {0}
	set_instantiation_assignment_value embeddedsw.dts.compatible {altr,pio-1.0}
	set_instantiation_assignment_value embeddedsw.dts.group {gpio}
	set_instantiation_assignment_value embeddedsw.dts.name {pio}
	set_instantiation_assignment_value embeddedsw.dts.params.altr,gpio-bank-width {10}
	set_instantiation_assignment_value embeddedsw.dts.params.altr,interrupt-type {3}
	set_instantiation_assignment_value embeddedsw.dts.params.altr,interrupt_type {3}
	set_instantiation_assignment_value embeddedsw.dts.params.edge_type {2}
	set_instantiation_assignment_value embeddedsw.dts.params.level_trigger {0}
	set_instantiation_assignment_value embeddedsw.dts.params.resetvalue {0}
	set_instantiation_assignment_value embeddedsw.dts.vendor {altr}
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clk clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clk}
	set_instantiation_interface_parameter_value reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset reset_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface s1 avalon INPUT
	set_instantiation_interface_parameter_value s1 addressAlignment {NATIVE}
	set_instantiation_interface_parameter_value s1 addressGroup {0}
	set_instantiation_interface_parameter_value s1 addressSpan {4}
	set_instantiation_interface_parameter_value s1 addressUnits {WORDS}
	set_instantiation_interface_parameter_value s1 alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value s1 associatedClock {clk}
	set_instantiation_interface_parameter_value s1 associatedReset {reset}
	set_instantiation_interface_parameter_value s1 bitsPerSymbol {8}
	set_instantiation_interface_parameter_value s1 bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value s1 bridgesToMaster {}
	set_instantiation_interface_parameter_value s1 burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value s1 burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value s1 constantBurstBehavior {false}
	set_instantiation_interface_parameter_value s1 dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureId {35}
	set_instantiation_interface_parameter_value s1 dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value s1 dfhFeatureType {3}
	set_instantiation_interface_parameter_value s1 dfhGroupId {0}
	set_instantiation_interface_parameter_value s1 dfhParameterData {}
	set_instantiation_interface_parameter_value s1 dfhParameterDataLength {}
	set_instantiation_interface_parameter_value s1 dfhParameterId {}
	set_instantiation_interface_parameter_value s1 dfhParameterName {}
	set_instantiation_interface_parameter_value s1 dfhParameterVersion {}
	set_instantiation_interface_parameter_value s1 explicitAddressSpan {0}
	set_instantiation_interface_parameter_value s1 holdTime {0}
	set_instantiation_interface_parameter_value s1 interleaveBursts {false}
	set_instantiation_interface_parameter_value s1 isBigEndian {false}
	set_instantiation_interface_parameter_value s1 isFlash {false}
	set_instantiation_interface_parameter_value s1 isMemoryDevice {false}
	set_instantiation_interface_parameter_value s1 isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value s1 linewrapBursts {false}
	set_instantiation_interface_parameter_value s1 maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value s1 maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value s1 minimumReadLatency {1}
	set_instantiation_interface_parameter_value s1 minimumResponseLatency {1}
	set_instantiation_interface_parameter_value s1 minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value s1 prSafe {false}
	set_instantiation_interface_parameter_value s1 printableDevice {false}
	set_instantiation_interface_parameter_value s1 readLatency {0}
	set_instantiation_interface_parameter_value s1 readWaitStates {1}
	set_instantiation_interface_parameter_value s1 readWaitTime {1}
	set_instantiation_interface_parameter_value s1 registerIncomingSignals {false}
	set_instantiation_interface_parameter_value s1 registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value s1 setupTime {0}
	set_instantiation_interface_parameter_value s1 timingUnits {Cycles}
	set_instantiation_interface_parameter_value s1 transparentBridge {false}
	set_instantiation_interface_parameter_value s1 waitrequestAllowance {0}
	set_instantiation_interface_parameter_value s1 waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value s1 wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value s1 writeLatency {0}
	set_instantiation_interface_parameter_value s1 writeWaitStates {0}
	set_instantiation_interface_parameter_value s1 writeWaitTime {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isMemoryDevice {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value s1 embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_sysinfo_parameter_value s1 address_map {<address-map><slave name='s1' start='0x0' end='0x10' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value s1 address_width {4}
	set_instantiation_interface_sysinfo_parameter_value s1 max_slave_data_width {32}
	add_instantiation_interface_port s1 address address 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 write_n write_n 1 STD_LOGIC Input
	add_instantiation_interface_port s1 writedata writedata 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port s1 chipselect chipselect 1 STD_LOGIC Input
	add_instantiation_interface_port s1 readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface external_connection conduit INPUT
	set_instantiation_interface_parameter_value external_connection associatedClock {}
	set_instantiation_interface_parameter_value external_connection associatedReset {}
	set_instantiation_interface_parameter_value external_connection prSafe {false}
	add_instantiation_interface_port external_connection in_port export 10 STD_LOGIC_VECTOR Input
	add_instantiation_interface irq interrupt INPUT
	set_instantiation_interface_parameter_value irq associatedAddressablePoint {s1}
	set_instantiation_interface_parameter_value irq associatedClock {clk}
	set_instantiation_interface_parameter_value irq associatedReset {reset}
	set_instantiation_interface_parameter_value irq bridgedReceiverOffset {0}
	set_instantiation_interface_parameter_value irq bridgesToReceiver {}
	set_instantiation_interface_parameter_value irq irqScheme {NONE}
	set_instantiation_interface_assignment_value irq embeddedsw.dts.irq.tx_type {RISING_EDGE}
	add_instantiation_interface_port irq irq irq 1 STD_LOGIC Output
	save_instantiation
	add_component reset_bridge ip/nios_system/reset_bridge.ip altera_reset_bridge reset_bridge
	load_component reset_bridge
	set_component_parameter_value ACTIVE_LOW_RESET {1}
	set_component_parameter_value NUM_RESET_OUTPUTS {1}
	set_component_parameter_value SYNCHRONOUS_EDGES {deassert}
	set_component_parameter_value SYNC_RESET {1}
	set_component_parameter_value USE_RESET_REQUEST {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation reset_bridge
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clk clk 1 STD_LOGIC Input
	add_instantiation_interface in_reset reset INPUT
	set_instantiation_interface_parameter_value in_reset associatedClock {clk}
	set_instantiation_interface_parameter_value in_reset synchronousEdges {BOTH}
	add_instantiation_interface_port in_reset in_reset_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface out_reset reset OUTPUT
	set_instantiation_interface_parameter_value out_reset associatedClock {clk}
	set_instantiation_interface_parameter_value out_reset associatedDirectReset {in_reset}
	set_instantiation_interface_parameter_value out_reset associatedResetSinks {in_reset}
	set_instantiation_interface_parameter_value out_reset synchronousEdges {BOTH}
	add_instantiation_interface_port out_reset out_reset_n reset_n 1 STD_LOGIC Output
	save_instantiation
	add_component reset_in ip/nios_system/reset_in.ip altera_reset_bridge reset_in
	load_component reset_in
	set_component_parameter_value ACTIVE_LOW_RESET {1}
	set_component_parameter_value NUM_RESET_OUTPUTS {1}
	set_component_parameter_value SYNCHRONOUS_EDGES {none}
	set_component_parameter_value SYNC_RESET {0}
	set_component_parameter_value USE_RESET_REQUEST {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation reset_in
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface in_reset reset INPUT
	set_instantiation_interface_parameter_value in_reset associatedClock {}
	set_instantiation_interface_parameter_value in_reset synchronousEdges {NONE}
	add_instantiation_interface_port in_reset in_reset_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface out_reset reset OUTPUT
	set_instantiation_interface_parameter_value out_reset associatedClock {}
	set_instantiation_interface_parameter_value out_reset associatedDirectReset {in_reset}
	set_instantiation_interface_parameter_value out_reset associatedResetSinks {in_reset}
	set_instantiation_interface_parameter_value out_reset synchronousEdges {NONE}
	add_instantiation_interface_port out_reset out_reset_n reset_n 1 STD_LOGIC Output
	save_instantiation
	add_component reset_release ip/nios_system/reset_release.ip intel_user_rst_clkgate reset_release
	load_component reset_release
	set_component_parameter_value outputType {Reset Interface}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation reset_release
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface ninit_done reset OUTPUT
	set_instantiation_interface_parameter_value ninit_done associatedClock {}
	set_instantiation_interface_parameter_value ninit_done associatedDirectReset {}
	set_instantiation_interface_parameter_value ninit_done associatedResetSinks {none}
	set_instantiation_interface_parameter_value ninit_done synchronousEdges {NONE}
	add_instantiation_interface_port ninit_done ninit_done reset 1 STD_LOGIC Output
	save_instantiation
	add_component sdram ip/nios_system/core_sdram_axi4.ip core_sdram_axi4 sdram
	load_component sdram
	set_component_parameter_value SDRAM_ADDR_W {24}
	set_component_parameter_value SDRAM_COL_W {9}
	set_component_parameter_value SDRAM_MHZ {80}
	set_component_parameter_value SDRAM_READ_LATENCY {2}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation sdram
	remove_instantiation_interfaces_and_ports
	add_instantiation_interface sdram conduit INPUT
	set_instantiation_interface_parameter_value sdram associatedClock {}
	set_instantiation_interface_parameter_value sdram associatedReset {}
	set_instantiation_interface_parameter_value sdram prSafe {false}
	add_instantiation_interface_port sdram sdram_cke_o cke 1 STD_LOGIC Output
	add_instantiation_interface_port sdram sdram_cs_o cs_n 1 STD_LOGIC Output
	add_instantiation_interface_port sdram sdram_ras_o ras_n 1 STD_LOGIC Output
	add_instantiation_interface_port sdram sdram_cas_o cas_n 1 STD_LOGIC Output
	add_instantiation_interface_port sdram sdram_we_o we_n 1 STD_LOGIC Output
	add_instantiation_interface_port sdram sdram_dqm_o dqm 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port sdram sdram_addr_o addr 13 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port sdram sdram_ba_o ba 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port sdram sdram_data_output_o data_out 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port sdram sdram_data_out_en_o data_oe 1 STD_LOGIC Output
	add_instantiation_interface_port sdram sdram_data_input_i data_in 32 STD_LOGIC_VECTOR Input
	add_instantiation_interface clock_sink clock INPUT
	set_instantiation_interface_parameter_value clock_sink clockRate {0}
	set_instantiation_interface_parameter_value clock_sink externallyDriven {false}
	set_instantiation_interface_parameter_value clock_sink ptfSchematicName {}
	add_instantiation_interface_port clock_sink clk_i clk 1 STD_LOGIC Input
	add_instantiation_interface clock_sample_sink clock INPUT
	set_instantiation_interface_parameter_value clock_sample_sink clockRate {0}
	set_instantiation_interface_parameter_value clock_sample_sink externallyDriven {false}
	set_instantiation_interface_parameter_value clock_sample_sink ptfSchematicName {}
	add_instantiation_interface_port clock_sample_sink clk_sample_i clk 1 STD_LOGIC Input
	add_instantiation_interface reset_sink reset INPUT
	set_instantiation_interface_parameter_value reset_sink associatedClock {clock_sink}
	set_instantiation_interface_parameter_value reset_sink synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset_sink rst_i reset 1 STD_LOGIC Input
	add_instantiation_interface axi4_slave axi4 INPUT
	set_instantiation_interface_parameter_value axi4_slave addressCheck {false}
	set_instantiation_interface_parameter_value axi4_slave associatedClock {clock_sink}
	set_instantiation_interface_parameter_value axi4_slave associatedReset {reset_sink}
	set_instantiation_interface_parameter_value axi4_slave bridgesToMaster {}
	set_instantiation_interface_parameter_value axi4_slave combinedAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi4_slave dataCheck {false}
	set_instantiation_interface_parameter_value axi4_slave dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value axi4_slave dfhFeatureId {35}
	set_instantiation_interface_parameter_value axi4_slave dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value axi4_slave dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value axi4_slave dfhFeatureType {3}
	set_instantiation_interface_parameter_value axi4_slave dfhGroupId {0}
	set_instantiation_interface_parameter_value axi4_slave dfhParameterData {}
	set_instantiation_interface_parameter_value axi4_slave dfhParameterDataLength {}
	set_instantiation_interface_parameter_value axi4_slave dfhParameterId {}
	set_instantiation_interface_parameter_value axi4_slave dfhParameterName {}
	set_instantiation_interface_parameter_value axi4_slave dfhParameterVersion {}
	set_instantiation_interface_parameter_value axi4_slave isTranslator {false}
	set_instantiation_interface_parameter_value axi4_slave maximumOutstandingReads {1}
	set_instantiation_interface_parameter_value axi4_slave maximumOutstandingTransactions {1}
	set_instantiation_interface_parameter_value axi4_slave maximumOutstandingWrites {1}
	set_instantiation_interface_parameter_value axi4_slave noNarrowTransfer {false}
	set_instantiation_interface_parameter_value axi4_slave optionalAssociatedReset {false}
	set_instantiation_interface_parameter_value axi4_slave poison {false}
	set_instantiation_interface_parameter_value axi4_slave readAcceptanceCapability {1}
	set_instantiation_interface_parameter_value axi4_slave readDataReorderingDepth {1}
	set_instantiation_interface_parameter_value axi4_slave securityAttribute {false}
	set_instantiation_interface_parameter_value axi4_slave traceSignals {false}
	set_instantiation_interface_parameter_value axi4_slave trustzoneAware {true}
	set_instantiation_interface_parameter_value axi4_slave uniqueIdSupport {false}
	set_instantiation_interface_parameter_value axi4_slave userData {false}
	set_instantiation_interface_parameter_value axi4_slave wakeupSignals {false}
	set_instantiation_interface_parameter_value axi4_slave writeAcceptanceCapability {1}
	set_instantiation_interface_sysinfo_parameter_value axi4_slave address_map {<address-map><slave name='axi4_slave' start='0x0' end='0x4000000' datawidth='64' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value axi4_slave address_width {26}
	set_instantiation_interface_sysinfo_parameter_value axi4_slave max_slave_data_width {64}
	add_instantiation_interface_port axi4_slave inport_awvalid_i awvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_slave inport_awaddr_i awaddr 26 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_slave inport_awid_i awid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_slave inport_awlen_i awlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_slave inport_awburst_i awburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_slave inport_wvalid_i wvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_slave inport_wdata_i wdata 64 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_slave inport_wstrb_i wstrb 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_slave inport_wlast_i wlast 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_slave inport_bready_i bready 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_slave inport_arvalid_i arvalid 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_slave inport_araddr_i araddr 26 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_slave inport_arid_i arid 4 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_slave inport_arlen_i arlen 8 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_slave inport_arburst_i arburst 2 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_slave inport_rready_i rready 1 STD_LOGIC Input
	add_instantiation_interface_port axi4_slave inport_awready_o awready 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_slave inport_wready_o wready 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_slave inport_bvalid_o bvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_slave inport_bresp_o bresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_slave inport_bid_o bid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_slave inport_arready_o arready 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_slave inport_rvalid_o rvalid 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_slave inport_rdata_o rdata 64 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_slave inport_rresp_o rresp 2 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_slave inport_rid_o rid 4 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port axi4_slave inport_rlast_o rlast 1 STD_LOGIC Output
	add_instantiation_interface_port axi4_slave inport_awsize_i awsize 3 STD_LOGIC_VECTOR Input
	add_instantiation_interface_port axi4_slave inport_arsize_i arsize 3 STD_LOGIC_VECTOR Input
	save_instantiation
	add_component sysid_qsys ip/nios_system/sysid_qsys.ip altera_avalon_sysid_qsys sysid_qsys
	load_component sysid_qsys
	set_component_parameter_value USE_LIVE_TIMESTAMP {0}
	set_component_parameter_value USE_MANUAL_ID {1}
	set_component_parameter_value id {0}
	set_component_project_property HIDE_FROM_IP_CATALOG {false}
	save_component
	load_instantiation sysid_qsys
	remove_instantiation_interfaces_and_ports
	set_instantiation_assignment_value embeddedsw.CMacro.ID {0}
	set_instantiation_assignment_value embeddedsw.CMacro.TIMESTAMP {0}
	set_instantiation_assignment_value embeddedsw.dts.compatible {altr,sysid-1.0}
	set_instantiation_assignment_value embeddedsw.dts.group {sysid}
	set_instantiation_assignment_value embeddedsw.dts.name {sysid}
	set_instantiation_assignment_value embeddedsw.dts.params.id {0}
	set_instantiation_assignment_value embeddedsw.dts.params.timestamp {0}
	set_instantiation_assignment_value embeddedsw.dts.vendor {altr}
	add_instantiation_interface clk clock INPUT
	set_instantiation_interface_parameter_value clk clockRate {0}
	set_instantiation_interface_parameter_value clk externallyDriven {false}
	set_instantiation_interface_parameter_value clk ptfSchematicName {}
	add_instantiation_interface_port clk clock clk 1 STD_LOGIC Input
	add_instantiation_interface reset reset INPUT
	set_instantiation_interface_parameter_value reset associatedClock {clk}
	set_instantiation_interface_parameter_value reset synchronousEdges {DEASSERT}
	add_instantiation_interface_port reset reset_n reset_n 1 STD_LOGIC Input
	add_instantiation_interface control_slave avalon INPUT
	set_instantiation_interface_parameter_value control_slave addressAlignment {DYNAMIC}
	set_instantiation_interface_parameter_value control_slave addressGroup {0}
	set_instantiation_interface_parameter_value control_slave addressSpan {8}
	set_instantiation_interface_parameter_value control_slave addressUnits {WORDS}
	set_instantiation_interface_parameter_value control_slave alwaysBurstMaxBurst {false}
	set_instantiation_interface_parameter_value control_slave associatedClock {clk}
	set_instantiation_interface_parameter_value control_slave associatedReset {reset}
	set_instantiation_interface_parameter_value control_slave bitsPerSymbol {8}
	set_instantiation_interface_parameter_value control_slave bridgedAddressOffset {0}
	set_instantiation_interface_parameter_value control_slave bridgesToMaster {}
	set_instantiation_interface_parameter_value control_slave burstOnBurstBoundariesOnly {false}
	set_instantiation_interface_parameter_value control_slave burstcountUnits {WORDS}
	set_instantiation_interface_parameter_value control_slave constantBurstBehavior {false}
	set_instantiation_interface_parameter_value control_slave dfhFeatureGuid {0}
	set_instantiation_interface_parameter_value control_slave dfhFeatureId {35}
	set_instantiation_interface_parameter_value control_slave dfhFeatureMajorVersion {0}
	set_instantiation_interface_parameter_value control_slave dfhFeatureMinorVersion {0}
	set_instantiation_interface_parameter_value control_slave dfhFeatureType {3}
	set_instantiation_interface_parameter_value control_slave dfhGroupId {0}
	set_instantiation_interface_parameter_value control_slave dfhParameterData {}
	set_instantiation_interface_parameter_value control_slave dfhParameterDataLength {}
	set_instantiation_interface_parameter_value control_slave dfhParameterId {}
	set_instantiation_interface_parameter_value control_slave dfhParameterName {}
	set_instantiation_interface_parameter_value control_slave dfhParameterVersion {}
	set_instantiation_interface_parameter_value control_slave explicitAddressSpan {0}
	set_instantiation_interface_parameter_value control_slave holdTime {0}
	set_instantiation_interface_parameter_value control_slave interleaveBursts {false}
	set_instantiation_interface_parameter_value control_slave isBigEndian {false}
	set_instantiation_interface_parameter_value control_slave isFlash {false}
	set_instantiation_interface_parameter_value control_slave isMemoryDevice {false}
	set_instantiation_interface_parameter_value control_slave isNonVolatileStorage {false}
	set_instantiation_interface_parameter_value control_slave linewrapBursts {false}
	set_instantiation_interface_parameter_value control_slave maximumPendingReadTransactions {0}
	set_instantiation_interface_parameter_value control_slave maximumPendingWriteTransactions {0}
	set_instantiation_interface_parameter_value control_slave minimumReadLatency {1}
	set_instantiation_interface_parameter_value control_slave minimumResponseLatency {1}
	set_instantiation_interface_parameter_value control_slave minimumUninterruptedRunLength {1}
	set_instantiation_interface_parameter_value control_slave prSafe {false}
	set_instantiation_interface_parameter_value control_slave printableDevice {false}
	set_instantiation_interface_parameter_value control_slave readLatency {0}
	set_instantiation_interface_parameter_value control_slave readWaitStates {1}
	set_instantiation_interface_parameter_value control_slave readWaitTime {1}
	set_instantiation_interface_parameter_value control_slave registerIncomingSignals {false}
	set_instantiation_interface_parameter_value control_slave registerOutgoingSignals {false}
	set_instantiation_interface_parameter_value control_slave setupTime {0}
	set_instantiation_interface_parameter_value control_slave timingUnits {Cycles}
	set_instantiation_interface_parameter_value control_slave transparentBridge {false}
	set_instantiation_interface_parameter_value control_slave waitrequestAllowance {0}
	set_instantiation_interface_parameter_value control_slave waitrequestTimeout {1024}
	set_instantiation_interface_parameter_value control_slave wellBehavedWaitrequest {false}
	set_instantiation_interface_parameter_value control_slave writeLatency {0}
	set_instantiation_interface_parameter_value control_slave writeWaitStates {0}
	set_instantiation_interface_parameter_value control_slave writeWaitTime {0}
	set_instantiation_interface_assignment_value control_slave embeddedsw.configuration.isFlash {0}
	set_instantiation_interface_assignment_value control_slave embeddedsw.configuration.isMemoryDevice {0}
	set_instantiation_interface_assignment_value control_slave embeddedsw.configuration.isNonVolatileStorage {0}
	set_instantiation_interface_assignment_value control_slave embeddedsw.configuration.isPrintableDevice {0}
	set_instantiation_interface_sysinfo_parameter_value control_slave address_map {<address-map><slave name='control_slave' start='0x0' end='0x8' datawidth='32' /></address-map>}
	set_instantiation_interface_sysinfo_parameter_value control_slave address_width {3}
	set_instantiation_interface_sysinfo_parameter_value control_slave max_slave_data_width {32}
	add_instantiation_interface_port control_slave readdata readdata 32 STD_LOGIC_VECTOR Output
	add_instantiation_interface_port control_slave address address 1 STD_LOGIC Input
	save_instantiation

	# add wirelevel expressions

	# preserve ports for debug

	# add the connections
	add_connection clock_in.out_clk/iopll.refclk
	set_connection_parameter_value clock_in.out_clk/iopll.refclk clockDomainSysInfo {1}
	set_connection_parameter_value clock_in.out_clk/iopll.refclk clockRateSysInfo {50000000.0}
	set_connection_parameter_value clock_in.out_clk/iopll.refclk clockResetSysInfo {}
	set_connection_parameter_value clock_in.out_clk/iopll.refclk resetDomainSysInfo {1}
	add_connection iopll.outclk0/jtag_uart.clk
	set_connection_parameter_value iopll.outclk0/jtag_uart.clk clockDomainSysInfo {2}
	set_connection_parameter_value iopll.outclk0/jtag_uart.clk clockRateSysInfo {80000000.0}
	set_connection_parameter_value iopll.outclk0/jtag_uart.clk clockResetSysInfo {}
	set_connection_parameter_value iopll.outclk0/jtag_uart.clk resetDomainSysInfo {2}
	add_connection iopll.outclk0/mm_bridge_peripheral.clk
	set_connection_parameter_value iopll.outclk0/mm_bridge_peripheral.clk clockDomainSysInfo {2}
	set_connection_parameter_value iopll.outclk0/mm_bridge_peripheral.clk clockRateSysInfo {80000000.0}
	set_connection_parameter_value iopll.outclk0/mm_bridge_peripheral.clk clockResetSysInfo {}
	set_connection_parameter_value iopll.outclk0/mm_bridge_peripheral.clk resetDomainSysInfo {2}
	add_connection iopll.outclk0/niosv_g.clk
	set_connection_parameter_value iopll.outclk0/niosv_g.clk clockDomainSysInfo {2}
	set_connection_parameter_value iopll.outclk0/niosv_g.clk clockRateSysInfo {80000000.0}
	set_connection_parameter_value iopll.outclk0/niosv_g.clk clockResetSysInfo {}
	set_connection_parameter_value iopll.outclk0/niosv_g.clk resetDomainSysInfo {2}
	add_connection iopll.outclk0/onchip_memory.clk1
	set_connection_parameter_value iopll.outclk0/onchip_memory.clk1 clockDomainSysInfo {2}
	set_connection_parameter_value iopll.outclk0/onchip_memory.clk1 clockRateSysInfo {80000000.0}
	set_connection_parameter_value iopll.outclk0/onchip_memory.clk1 clockResetSysInfo {}
	set_connection_parameter_value iopll.outclk0/onchip_memory.clk1 resetDomainSysInfo {2}
	add_connection iopll.outclk0/pio_key.clk
	set_connection_parameter_value iopll.outclk0/pio_key.clk clockDomainSysInfo {2}
	set_connection_parameter_value iopll.outclk0/pio_key.clk clockRateSysInfo {80000000.0}
	set_connection_parameter_value iopll.outclk0/pio_key.clk clockResetSysInfo {}
	set_connection_parameter_value iopll.outclk0/pio_key.clk resetDomainSysInfo {2}
	add_connection iopll.outclk0/pio_led.clk
	set_connection_parameter_value iopll.outclk0/pio_led.clk clockDomainSysInfo {2}
	set_connection_parameter_value iopll.outclk0/pio_led.clk clockRateSysInfo {80000000.0}
	set_connection_parameter_value iopll.outclk0/pio_led.clk clockResetSysInfo {}
	set_connection_parameter_value iopll.outclk0/pio_led.clk resetDomainSysInfo {2}
	add_connection iopll.outclk0/pio_sw.clk
	set_connection_parameter_value iopll.outclk0/pio_sw.clk clockDomainSysInfo {2}
	set_connection_parameter_value iopll.outclk0/pio_sw.clk clockRateSysInfo {80000000.0}
	set_connection_parameter_value iopll.outclk0/pio_sw.clk clockResetSysInfo {}
	set_connection_parameter_value iopll.outclk0/pio_sw.clk resetDomainSysInfo {2}
	add_connection iopll.outclk0/reset_bridge.clk
	set_connection_parameter_value iopll.outclk0/reset_bridge.clk clockDomainSysInfo {2}
	set_connection_parameter_value iopll.outclk0/reset_bridge.clk clockRateSysInfo {80000000.0}
	set_connection_parameter_value iopll.outclk0/reset_bridge.clk clockResetSysInfo {}
	set_connection_parameter_value iopll.outclk0/reset_bridge.clk resetDomainSysInfo {2}
	add_connection iopll.outclk0/sdram.clock_sink
	set_connection_parameter_value iopll.outclk0/sdram.clock_sink clockDomainSysInfo {2}
	set_connection_parameter_value iopll.outclk0/sdram.clock_sink clockRateSysInfo {80000000.0}
	set_connection_parameter_value iopll.outclk0/sdram.clock_sink clockResetSysInfo {}
	set_connection_parameter_value iopll.outclk0/sdram.clock_sink resetDomainSysInfo {2}
	add_connection iopll.outclk0/sysid_qsys.clk
	set_connection_parameter_value iopll.outclk0/sysid_qsys.clk clockDomainSysInfo {2}
	set_connection_parameter_value iopll.outclk0/sysid_qsys.clk clockRateSysInfo {80000000.0}
	set_connection_parameter_value iopll.outclk0/sysid_qsys.clk clockResetSysInfo {}
	set_connection_parameter_value iopll.outclk0/sysid_qsys.clk resetDomainSysInfo {2}
	add_connection iopll.outclk2/sdram.clock_sample_sink
	set_connection_parameter_value iopll.outclk2/sdram.clock_sample_sink clockDomainSysInfo {3}
	set_connection_parameter_value iopll.outclk2/sdram.clock_sample_sink clockRateSysInfo {80000000.0}
	set_connection_parameter_value iopll.outclk2/sdram.clock_sample_sink clockResetSysInfo {}
	set_connection_parameter_value iopll.outclk2/sdram.clock_sample_sink resetDomainSysInfo {3}
	add_connection mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave addressMapSysInfo {<address-map><slave name='pio_key.s1' start='0x410' end='0x420' datawidth='32' /><slave name='pio_led.s1' start='0x420' end='0x430' datawidth='32' /><slave name='pio_sw.s1' start='0x430' end='0x440' datawidth='32' /><slave name='sysid_qsys.control_slave' start='0x440' end='0x448' datawidth='32' /><slave name='jtag_uart.avalon_jtag_slave' start='0x448' end='0x450' datawidth='32' /></address-map>}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave addressWidthSysInfo {11}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave arbitrationPriority {1}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave baseAddress {0x0448}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave cpuInfoIdSysInfo {}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave defaultConnection {0}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave domainAlias {}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.fifoDepth {8}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.syncResets {TRUE}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value mm_bridge_peripheral.m0/jtag_uart.avalon_jtag_slave slaveDataWidthSysInfo {-1}
	add_connection mm_bridge_peripheral.m0/pio_key.s1
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 addressMapSysInfo {<address-map><slave name='pio_key.s1' start='0x410' end='0x420' datawidth='32' /><slave name='pio_led.s1' start='0x420' end='0x430' datawidth='32' /><slave name='pio_sw.s1' start='0x430' end='0x440' datawidth='32' /><slave name='sysid_qsys.control_slave' start='0x440' end='0x448' datawidth='32' /><slave name='jtag_uart.avalon_jtag_slave' start='0x448' end='0x450' datawidth='32' /></address-map>}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 addressWidthSysInfo {11}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 arbitrationPriority {1}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 baseAddress {0x0410}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 defaultConnection {0}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 domainAlias {}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.fifoDepth {8}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_key.s1 slaveDataWidthSysInfo {-1}
	add_connection mm_bridge_peripheral.m0/pio_led.s1
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 addressMapSysInfo {<address-map><slave name='pio_key.s1' start='0x410' end='0x420' datawidth='32' /><slave name='pio_led.s1' start='0x420' end='0x430' datawidth='32' /><slave name='pio_sw.s1' start='0x430' end='0x440' datawidth='32' /><slave name='sysid_qsys.control_slave' start='0x440' end='0x448' datawidth='32' /><slave name='jtag_uart.avalon_jtag_slave' start='0x448' end='0x450' datawidth='32' /></address-map>}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 addressWidthSysInfo {11}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 arbitrationPriority {1}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 baseAddress {0x0420}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 defaultConnection {0}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 domainAlias {}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.fifoDepth {8}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_led.s1 slaveDataWidthSysInfo {-1}
	add_connection mm_bridge_peripheral.m0/pio_sw.s1
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 addressMapSysInfo {<address-map><slave name='pio_key.s1' start='0x410' end='0x420' datawidth='32' /><slave name='pio_led.s1' start='0x420' end='0x430' datawidth='32' /><slave name='pio_sw.s1' start='0x430' end='0x440' datawidth='32' /><slave name='sysid_qsys.control_slave' start='0x440' end='0x448' datawidth='32' /><slave name='jtag_uart.avalon_jtag_slave' start='0x448' end='0x450' datawidth='32' /></address-map>}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 addressWidthSysInfo {11}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 arbitrationPriority {1}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 baseAddress {0x0430}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 defaultConnection {0}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 domainAlias {}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.fifoDepth {8}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value mm_bridge_peripheral.m0/pio_sw.s1 slaveDataWidthSysInfo {-1}
	add_connection mm_bridge_peripheral.m0/sysid_qsys.control_slave
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave addressMapSysInfo {<address-map><slave name='pio_key.s1' start='0x410' end='0x420' datawidth='32' /><slave name='pio_led.s1' start='0x420' end='0x430' datawidth='32' /><slave name='pio_sw.s1' start='0x430' end='0x440' datawidth='32' /><slave name='sysid_qsys.control_slave' start='0x440' end='0x448' datawidth='32' /><slave name='jtag_uart.avalon_jtag_slave' start='0x448' end='0x450' datawidth='32' /></address-map>}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave addressWidthSysInfo {11}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave arbitrationPriority {1}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave baseAddress {0x0440}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave cpuInfoIdSysInfo {}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave defaultConnection {0}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave domainAlias {}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.fifoDepth {8}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.syncResets {TRUE}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value mm_bridge_peripheral.m0/sysid_qsys.control_slave slaveDataWidthSysInfo {-1}
	add_connection niosv_g.data_manager/mm_bridge_peripheral.s0
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 addressMapSysInfo {<address-map><slave name='niosv_g.dm_agent' start='0x0' end='0x10000' datawidth='32' /><slave name='niosv_g.timer_sw_agent' start='0x11000' end='0x11040' datawidth='32' /><slave name='pio_key.s1' start='0x80410' end='0x80420' datawidth='32' /><slave name='pio_led.s1' start='0x80420' end='0x80430' datawidth='32' /><slave name='pio_sw.s1' start='0x80430' end='0x80440' datawidth='32' /><slave name='sysid_qsys.control_slave' start='0x80440' end='0x80448' datawidth='32' /><slave name='jtag_uart.avalon_jtag_slave' start='0x80448' end='0x80450' datawidth='32' /><slave name='onchip_memory.s1' start='0x100000' end='0x17FFF8' datawidth='32' /><slave name='sdram.axi4_slave' start='0x4000000' end='0x8000000' datawidth='64' /></address-map>}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 addressWidthSysInfo {27}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 arbitrationPriority {1}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 baseAddress {0x00080000}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 cpuInfoIdSysInfo {}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 defaultConnection {0}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 domainAlias {}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.fifoDepth {8}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.data_manager/mm_bridge_peripheral.s0 slaveDataWidthSysInfo {-1}
	add_connection niosv_g.data_manager/niosv_g.dm_agent
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent addressMapSysInfo {<address-map><slave name='niosv_g.dm_agent' start='0x0' end='0x10000' datawidth='32' /><slave name='niosv_g.timer_sw_agent' start='0x11000' end='0x11040' datawidth='32' /><slave name='pio_key.s1' start='0x80410' end='0x80420' datawidth='32' /><slave name='pio_led.s1' start='0x80420' end='0x80430' datawidth='32' /><slave name='pio_sw.s1' start='0x80430' end='0x80440' datawidth='32' /><slave name='sysid_qsys.control_slave' start='0x80440' end='0x80448' datawidth='32' /><slave name='jtag_uart.avalon_jtag_slave' start='0x80448' end='0x80450' datawidth='32' /><slave name='onchip_memory.s1' start='0x100000' end='0x17FFF8' datawidth='32' /><slave name='sdram.axi4_slave' start='0x4000000' end='0x8000000' datawidth='64' /></address-map>}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent addressWidthSysInfo {27}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent arbitrationPriority {1}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent baseAddress {0x0000}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent cpuInfoIdSysInfo {}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent defaultConnection {0}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent domainAlias {}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.fifoDepth {8}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.syncResets {TRUE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.dm_agent slaveDataWidthSysInfo {-1}
	add_connection niosv_g.data_manager/niosv_g.timer_sw_agent
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent addressMapSysInfo {<address-map><slave name='niosv_g.dm_agent' start='0x0' end='0x10000' datawidth='32' /><slave name='niosv_g.timer_sw_agent' start='0x11000' end='0x11040' datawidth='32' /><slave name='pio_key.s1' start='0x80410' end='0x80420' datawidth='32' /><slave name='pio_led.s1' start='0x80420' end='0x80430' datawidth='32' /><slave name='pio_sw.s1' start='0x80430' end='0x80440' datawidth='32' /><slave name='sysid_qsys.control_slave' start='0x80440' end='0x80448' datawidth='32' /><slave name='jtag_uart.avalon_jtag_slave' start='0x80448' end='0x80450' datawidth='32' /><slave name='onchip_memory.s1' start='0x100000' end='0x17FFF8' datawidth='32' /><slave name='sdram.axi4_slave' start='0x4000000' end='0x8000000' datawidth='64' /></address-map>}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent addressWidthSysInfo {27}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent arbitrationPriority {1}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent baseAddress {0x00011000}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent cpuInfoIdSysInfo {}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent defaultConnection {0}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent domainAlias {}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.fifoDepth {8}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.syncResets {TRUE}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.data_manager/niosv_g.timer_sw_agent slaveDataWidthSysInfo {-1}
	add_connection niosv_g.data_manager/onchip_memory.s1
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 addressMapSysInfo {<address-map><slave name='niosv_g.dm_agent' start='0x0' end='0x10000' datawidth='32' /><slave name='niosv_g.timer_sw_agent' start='0x11000' end='0x11040' datawidth='32' /><slave name='pio_key.s1' start='0x80410' end='0x80420' datawidth='32' /><slave name='pio_led.s1' start='0x80420' end='0x80430' datawidth='32' /><slave name='pio_sw.s1' start='0x80430' end='0x80440' datawidth='32' /><slave name='sysid_qsys.control_slave' start='0x80440' end='0x80448' datawidth='32' /><slave name='jtag_uart.avalon_jtag_slave' start='0x80448' end='0x80450' datawidth='32' /><slave name='onchip_memory.s1' start='0x100000' end='0x17FFF8' datawidth='32' /><slave name='sdram.axi4_slave' start='0x4000000' end='0x8000000' datawidth='64' /></address-map>}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 addressWidthSysInfo {27}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 arbitrationPriority {1}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 baseAddress {0x00100000}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 defaultConnection {0}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 domainAlias {}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.fifoDepth {8}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.data_manager/onchip_memory.s1 slaveDataWidthSysInfo {-1}
	add_connection niosv_g.data_manager/sdram.axi4_slave
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave addressMapSysInfo {<address-map><slave name='niosv_g.dm_agent' start='0x0' end='0x10000' datawidth='32' /><slave name='niosv_g.timer_sw_agent' start='0x11000' end='0x11040' datawidth='32' /><slave name='pio_key.s1' start='0x80410' end='0x80420' datawidth='32' /><slave name='pio_led.s1' start='0x80420' end='0x80430' datawidth='32' /><slave name='pio_sw.s1' start='0x80430' end='0x80440' datawidth='32' /><slave name='sysid_qsys.control_slave' start='0x80440' end='0x80448' datawidth='32' /><slave name='jtag_uart.avalon_jtag_slave' start='0x80448' end='0x80450' datawidth='32' /><slave name='onchip_memory.s1' start='0x100000' end='0x17FFF8' datawidth='32' /><slave name='sdram.axi4_slave' start='0x4000000' end='0x8000000' datawidth='64' /></address-map>}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave addressWidthSysInfo {27}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave arbitrationPriority {1}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave baseAddress {0x04000000}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave cpuInfoIdSysInfo {}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave defaultConnection {0}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave domainAlias {}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.fifoDepth {8}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.syncResets {TRUE}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.data_manager/sdram.axi4_slave slaveDataWidthSysInfo {-1}
	add_connection niosv_g.instruction_manager/niosv_g.dm_agent
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent addressMapSysInfo {<address-map><slave name='niosv_g.dm_agent' start='0x0' end='0x10000' datawidth='32' /><slave name='onchip_memory.s1' start='0x100000' end='0x17FFF8' datawidth='32' /><slave name='sdram.axi4_slave' start='0x4000000' end='0x8000000' datawidth='64' /></address-map>}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent addressWidthSysInfo {27}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent arbitrationPriority {1}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent baseAddress {0x0000}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent cpuInfoIdSysInfo {}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent defaultConnection {0}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent domainAlias {}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.fifoDepth {8}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.syncResets {TRUE}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.instruction_manager/niosv_g.dm_agent slaveDataWidthSysInfo {-1}
	add_connection niosv_g.instruction_manager/onchip_memory.s1
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 addressMapSysInfo {<address-map><slave name='niosv_g.dm_agent' start='0x0' end='0x10000' datawidth='32' /><slave name='onchip_memory.s1' start='0x100000' end='0x17FFF8' datawidth='32' /><slave name='sdram.axi4_slave' start='0x4000000' end='0x8000000' datawidth='64' /></address-map>}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 addressWidthSysInfo {27}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 arbitrationPriority {1}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 baseAddress {0x00100000}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 cpuInfoIdSysInfo {}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 defaultConnection {0}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 domainAlias {}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.fifoDepth {8}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.syncResets {TRUE}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.instruction_manager/onchip_memory.s1 slaveDataWidthSysInfo {-1}
	add_connection niosv_g.instruction_manager/sdram.axi4_slave
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave addressMapSysInfo {<address-map><slave name='niosv_g.dm_agent' start='0x0' end='0x10000' datawidth='32' /><slave name='onchip_memory.s1' start='0x100000' end='0x17FFF8' datawidth='32' /><slave name='sdram.axi4_slave' start='0x4000000' end='0x8000000' datawidth='64' /></address-map>}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave addressWidthSysInfo {27}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave arbitrationPriority {1}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave baseAddress {0x04000000}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave cpuInfoIdSysInfo {}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave defaultConnection {0}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave domainAlias {}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.burstAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.clockCrossingAdapter {HANDSHAKE}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.enableAllPipelines {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.enableEccProtection {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.enableInstrumentation {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.enableOutOfOrderSupport {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.fifoDepth {8}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.insertDefaultSlave {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.interconnectResetSource {DEFAULT}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.interconnectType {STANDARD}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.maxAdditionalLatency {1}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.optimizeRdFifoSize {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.piplineType {PIPELINE_STAGE}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.responseFifoType {REGISTER_BASED}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.splitCommandsFor4KBoundary {FALSE}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.syncResets {TRUE}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave qsys_mm.widthAdapterImplementation {GENERIC_CONVERTER}
	set_connection_parameter_value niosv_g.instruction_manager/sdram.axi4_slave slaveDataWidthSysInfo {-1}
	add_connection niosv_g.platform_irq_rx/jtag_uart.irq
	set_connection_parameter_value niosv_g.platform_irq_rx/jtag_uart.irq interruptsUsedSysInfo {-1}
	set_connection_parameter_value niosv_g.platform_irq_rx/jtag_uart.irq irqNumber {0}
	add_connection niosv_g.platform_irq_rx/pio_key.irq
	set_connection_parameter_value niosv_g.platform_irq_rx/pio_key.irq interruptsUsedSysInfo {-1}
	set_connection_parameter_value niosv_g.platform_irq_rx/pio_key.irq irqNumber {1}
	add_connection niosv_g.platform_irq_rx/pio_sw.irq
	set_connection_parameter_value niosv_g.platform_irq_rx/pio_sw.irq interruptsUsedSysInfo {-1}
	set_connection_parameter_value niosv_g.platform_irq_rx/pio_sw.irq irqNumber {2}
	add_connection reset_bridge.out_reset/iopll.reset
	set_connection_parameter_value reset_bridge.out_reset/iopll.reset clockDomainSysInfo {6}
	set_connection_parameter_value reset_bridge.out_reset/iopll.reset clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/iopll.reset resetDomainSysInfo {6}
	add_connection reset_bridge.out_reset/jtag_uart.reset
	set_connection_parameter_value reset_bridge.out_reset/jtag_uart.reset clockDomainSysInfo {6}
	set_connection_parameter_value reset_bridge.out_reset/jtag_uart.reset clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/jtag_uart.reset resetDomainSysInfo {6}
	add_connection reset_bridge.out_reset/mm_bridge_peripheral.reset
	set_connection_parameter_value reset_bridge.out_reset/mm_bridge_peripheral.reset clockDomainSysInfo {6}
	set_connection_parameter_value reset_bridge.out_reset/mm_bridge_peripheral.reset clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/mm_bridge_peripheral.reset resetDomainSysInfo {6}
	add_connection reset_bridge.out_reset/niosv_g.reset
	set_connection_parameter_value reset_bridge.out_reset/niosv_g.reset clockDomainSysInfo {6}
	set_connection_parameter_value reset_bridge.out_reset/niosv_g.reset clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/niosv_g.reset resetDomainSysInfo {6}
	add_connection reset_bridge.out_reset/onchip_memory.reset1
	set_connection_parameter_value reset_bridge.out_reset/onchip_memory.reset1 clockDomainSysInfo {6}
	set_connection_parameter_value reset_bridge.out_reset/onchip_memory.reset1 clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/onchip_memory.reset1 resetDomainSysInfo {6}
	add_connection reset_bridge.out_reset/pio_key.reset
	set_connection_parameter_value reset_bridge.out_reset/pio_key.reset clockDomainSysInfo {6}
	set_connection_parameter_value reset_bridge.out_reset/pio_key.reset clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/pio_key.reset resetDomainSysInfo {6}
	add_connection reset_bridge.out_reset/pio_led.reset
	set_connection_parameter_value reset_bridge.out_reset/pio_led.reset clockDomainSysInfo {6}
	set_connection_parameter_value reset_bridge.out_reset/pio_led.reset clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/pio_led.reset resetDomainSysInfo {6}
	add_connection reset_bridge.out_reset/pio_sw.reset
	set_connection_parameter_value reset_bridge.out_reset/pio_sw.reset clockDomainSysInfo {6}
	set_connection_parameter_value reset_bridge.out_reset/pio_sw.reset clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/pio_sw.reset resetDomainSysInfo {6}
	add_connection reset_bridge.out_reset/sdram.reset_sink
	set_connection_parameter_value reset_bridge.out_reset/sdram.reset_sink clockDomainSysInfo {6}
	set_connection_parameter_value reset_bridge.out_reset/sdram.reset_sink clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/sdram.reset_sink resetDomainSysInfo {6}
	add_connection reset_bridge.out_reset/sysid_qsys.reset
	set_connection_parameter_value reset_bridge.out_reset/sysid_qsys.reset clockDomainSysInfo {6}
	set_connection_parameter_value reset_bridge.out_reset/sysid_qsys.reset clockResetSysInfo {}
	set_connection_parameter_value reset_bridge.out_reset/sysid_qsys.reset resetDomainSysInfo {6}
	add_connection reset_in.out_reset/reset_bridge.in_reset
	set_connection_parameter_value reset_in.out_reset/reset_bridge.in_reset clockDomainSysInfo {4}
	set_connection_parameter_value reset_in.out_reset/reset_bridge.in_reset clockResetSysInfo {}
	set_connection_parameter_value reset_in.out_reset/reset_bridge.in_reset resetDomainSysInfo {4}
	add_connection reset_release.ninit_done/reset_bridge.in_reset
	set_connection_parameter_value reset_release.ninit_done/reset_bridge.in_reset clockDomainSysInfo {7}
	set_connection_parameter_value reset_release.ninit_done/reset_bridge.in_reset clockResetSysInfo {}
	set_connection_parameter_value reset_release.ninit_done/reset_bridge.in_reset resetDomainSysInfo {7}

	# add the exports
	set_interface_property clk EXPORT_OF clock_in.in_clk
	set_interface_property sdram_clk EXPORT_OF iopll.outclk1
	set_interface_property key_external_connection EXPORT_OF pio_key.external_connection
	set_interface_property led_external_connection EXPORT_OF pio_led.external_connection
	set_interface_property sw_external_connection EXPORT_OF pio_sw.external_connection
	set_interface_property reset EXPORT_OF reset_in.in_reset
	set_interface_property sdram EXPORT_OF sdram.sdram

	# set values for exposed HDL parameters
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.enableAllPipelines FALSE
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.enableEccProtection FALSE
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.enableInstrumentation FALSE
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.fifoDepth 8
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.interconnectType STANDARD
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.maxAdditionalLatency 1
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.splitCommandsFor4KBoundary FALSE
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.syncResets TRUE
	set_domain_assignment mm_bridge_peripheral.m0 qsys_mm.widthAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment niosv_g.data_manager qsys_mm.burstAdapterImplementation GENERIC_CONVERTER
	set_domain_assignment niosv_g.data_manager qsys_mm.clockCrossingAdapter HANDSHAKE
	set_domain_assignment niosv_g.data_manager qsys_mm.enableAllPipelines FALSE
	set_domain_assignment niosv_g.data_manager qsys_mm.enableEccProtection FALSE
	set_domain_assignment niosv_g.data_manager qsys_mm.enableInstrumentation FALSE
	set_domain_assignment niosv_g.data_manager qsys_mm.enableOutOfOrderSupport FALSE
	set_domain_assignment niosv_g.data_manager qsys_mm.fifoDepth 8
	set_domain_assignment niosv_g.data_manager qsys_mm.insertDefaultSlave FALSE
	set_domain_assignment niosv_g.data_manager qsys_mm.interconnectResetSource DEFAULT
	set_domain_assignment niosv_g.data_manager qsys_mm.interconnectType STANDARD
	set_domain_assignment niosv_g.data_manager qsys_mm.maxAdditionalLatency 1
	set_domain_assignment niosv_g.data_manager qsys_mm.optimizeRdFifoSize FALSE
	set_domain_assignment niosv_g.data_manager qsys_mm.piplineType PIPELINE_STAGE
	set_domain_assignment niosv_g.data_manager qsys_mm.responseFifoType REGISTER_BASED
	set_domain_assignment niosv_g.data_manager qsys_mm.splitCommandsFor4KBoundary FALSE
	set_domain_assignment niosv_g.data_manager qsys_mm.syncResets TRUE
	set_domain_assignment niosv_g.data_manager qsys_mm.widthAdapterImplementation GENERIC_CONVERTER

	# set the the module properties
	set_module_property BONUS_DATA {<?xml version="1.0" encoding="UTF-8"?>
<bonusData>
 <element __value="clock_in">
  <datum __value="_sortIndex" value="0" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="iopll">
  <datum __value="_sortIndex" value="4" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="jtag_uart">
  <datum __value="_sortIndex" value="9" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="jtag_uart.avalon_jtag_slave">
  <datum __value="baseAddress" value="1096" type="String" />
 </element>
 <element __value="mm_bridge_peripheral">
  <datum __value="_sortIndex" value="7" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="mm_bridge_peripheral.s0">
  <datum __value="_lockedAddress" value="1" type="boolean" />
  <datum __value="baseAddress" value="524288" type="String" />
 </element>
 <element __value="niosv_g">
  <datum __value="_sortIndex" value="5" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="niosv_g.dm_agent">
  <datum __value="baseAddress" value="0" type="String" />
 </element>
 <element __value="niosv_g.timer_sw_agent">
  <datum __value="baseAddress" value="69632" type="String" />
 </element>
 <element __value="onchip_memory">
  <datum __value="_sortIndex" value="6" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="onchip_memory.axi_s1">
  <datum __value="baseAddress" value="262144" type="String" />
 </element>
 <element __value="onchip_memory.s1">
  <datum __value="_lockedAddress" value="1" type="boolean" />
  <datum __value="baseAddress" value="1048576" type="String" />
 </element>
 <element __value="pio_key">
  <datum __value="_sortIndex" value="10" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="pio_key.s1">
  <datum __value="baseAddress" value="1040" type="String" />
 </element>
 <element __value="pio_led">
  <datum __value="_sortIndex" value="11" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="pio_led.s1">
  <datum __value="baseAddress" value="1056" type="String" />
 </element>
 <element __value="pio_sw">
  <datum __value="_sortIndex" value="12" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="pio_sw.s1">
  <datum __value="baseAddress" value="1072" type="String" />
 </element>
 <element __value="reset_bridge">
  <datum __value="_sortIndex" value="3" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="reset_in">
  <datum __value="_sortIndex" value="1" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="reset_release">
  <datum __value="_sortIndex" value="2" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="sdram">
  <datum __value="_sortIndex" value="13" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="sdram.axi4_slave">
  <datum __value="baseAddress" value="67108864" type="String" />
 </element>
 <element __value="sysid_qsys">
  <datum __value="_sortIndex" value="8" type="int" />
  <datum __value="sopceditor_expanded" value="1" type="boolean" />
 </element>
 <element __value="sysid_qsys.control_slave">
  <datum __value="baseAddress" value="1088" type="String" />
 </element>
</bonusData>
}
	set_module_property FILE {nios_system.qsys}
	set_module_property GENERATION_ID {0x00000000}
	set_module_property NAME {nios_system}

	# save the system
	sync_sysinfo_parameters
	save_system nios_system
}

proc do_set_exported_interface_sysinfo_parameters {} {
}

# create all the systems, from bottom up
do_create_nios_system

# set system info parameters on exported interface, from bottom up
do_set_exported_interface_sysinfo_parameters
