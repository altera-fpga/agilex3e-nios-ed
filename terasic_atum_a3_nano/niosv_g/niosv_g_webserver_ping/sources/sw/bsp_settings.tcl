# Remove existing memory regions and section mappings
foreach region_info [get_current_memory_regions] {
    delete_memory_region [lindex $region_info 0]
}

foreach mapping_info [get_current_section_mappings] {
    delete_section_mapping [lindex $mapping_info 0]
}

# Settings
set_setting altera_avalon_jtag_uart_driver.enable_jtag_uart_ignore_fifo_full_error {false}
set_setting altera_avalon_jtag_uart_driver.enable_small_driver {false}
set_setting freertos.coroutine.max_co_routine_priorities {1}
set_setting freertos.coroutine.os_use_co_routines {1}
set_setting freertos.heap_method {4}
set_setting freertos.memory.os_application_allocated_heap {0}
set_setting freertos.memory.os_enable_heap_protector {1}
set_setting freertos.memory.os_heap_clear_memory_on_free {1}
set_setting freertos.memory.os_malloc_failed_hook_en {0}
set_setting freertos.memory.os_memory_dynamic_allocation_en {1}
set_setting freertos.memory.os_memory_static_allocation_en {0}
set_setting freertos.memory.os_stack_allocation_from_separate_heap {0}
set_setting freertos.memory.os_total_heap_size {80000}
set_setting freertos.miscellaneous.os_check_stack_overflow {1}
set_setting freertos.miscellaneous.os_event_group_set_bit_from_isr {1}
set_setting freertos.miscellaneous.os_generate_run_time_stats {0}
set_setting freertos.miscellaneous.os_idle_should_yield {0}
set_setting freertos.miscellaneous.os_port_optimised_task_selection {0}
set_setting freertos.miscellaneous.os_stats_buffer_max_length {4095}
set_setting freertos.miscellaneous.os_use_mini_list_item {1}
set_setting freertos.miscellaneous.os_use_stats_formating_functions {0}
set_setting freertos.miscellaneous.os_use_stream_buffer_completed_callback {0}
set_setting freertos.miscellaneous.os_use_tickless_idle {0}
set_setting freertos.miscellaneous.os_use_time_slicing {1}
set_setting freertos.miscellaneous.os_use_trace_facility {1}
set_setting freertos.mutex.os_mutex_en {1}
set_setting freertos.mutex.os_recursive_mutex_en {1}
set_setting freertos.os_max_priorities {7}
set_setting freertos.os_min_stack_size {300}
set_setting freertos.os_port_has_mtime {1}
set_setting freertos.os_thread_safe_c_library {1}
set_setting freertos.os_use_16_bit_ticks {0}
set_setting freertos.os_use_newlib_reentrant {0}
set_setting freertos.os_use_posix_errno {0}
set_setting freertos.os_use_preemption {1}
set_setting freertos.queue.os_q_reg_size {8}
set_setting freertos.queue.os_use_q_sets {1}
set_setting freertos.semaphore.os_counting_sem_en {1}
set_setting freertos.semaphore.os_semaphore_get_mutex_holder_en {1}
set_setting freertos.task.os_max_task_name_len {16}
set_setting freertos.task.os_num_thread_local_storage_pointers {0}
set_setting freertos.task.os_task_abort_delay_en {1}
set_setting freertos.task.os_task_clean_up_resources_en {1}
set_setting freertos.task.os_task_delay_en {1}
set_setting freertos.task.os_task_delay_until_en {1}
set_setting freertos.task.os_task_delete_en {1}
set_setting freertos.task.os_task_get_current_task_handle_en {1}
set_setting freertos.task.os_task_get_handle_en {1}
set_setting freertos.task.os_task_get_idle_task_handle_en {1}
set_setting freertos.task.os_task_get_scheduler_state_en {1}
set_setting freertos.task.os_task_get_stack_high_watermark2_en {1}
set_setting freertos.task.os_task_get_stack_high_watermark_en {1}
set_setting freertos.task.os_task_get_state_en {1}
set_setting freertos.task.os_task_notification_array_entries {1}
set_setting freertos.task.os_task_priority_get_en {1}
set_setting freertos.task.os_task_priority_set_en {1}
set_setting freertos.task.os_task_suspend_en {1}
set_setting freertos.task.os_tls_bytes {256}
set_setting freertos.task.os_use_application_task_tag {0}
set_setting freertos.task.os_use_daemon_task_startup_hook {0}
set_setting freertos.task.os_use_idle_hook {0}
set_setting freertos.task.os_use_task_notifications {1}
set_setting freertos.timer.os_timer_pend_function_call_en {1}
set_setting freertos.timer.os_timer_queue_len {8}
set_setting freertos.timer.os_timer_task_depth {160}
set_setting freertos.timer.os_use_tick_hook {1}
set_setting freertos.timer.os_use_timers {1}
set_setting hal.dfl_start_address {-1}
set_setting hal.enable_c_plus_plus {true}
set_setting hal.enable_clean_exit {true}
set_setting hal.enable_exit {true}
set_setting hal.enable_instruction_related_exceptions_api {false}
set_setting hal.enable_lightweight_device_driver_api {false}
set_setting hal.enable_reduced_device_drivers {false}
set_setting hal.enable_runtime_stack_checking {false}
set_setting hal.enable_sim_optimize {false}
set_setting hal.linker.allow_code_at_reset {true}
set_setting hal.linker.enable_alt_load {true}
set_setting hal.linker.enable_alt_load_copy_exceptions {false}
set_setting hal.linker.enable_alt_load_copy_rodata {false}
set_setting hal.linker.enable_alt_load_copy_rwdata {true}
set_setting hal.linker.enable_exception_stack {false}
set_setting hal.linker.exception_stack_memory_region_name {sys_cpu_ram}
set_setting hal.linker.exception_stack_size {1024}
set_setting hal.linker.use_picolibc {false}
set_setting hal.log_flags {0}
set_setting hal.log_port {none}
set_setting hal.make.asflags {-Wa,-gdwarf2}
set_setting hal.make.cflags_debug {-g}
set_setting hal.make.cflags_defined_symbols {none}
set_setting hal.make.cflags_optimization {-O2}
set_setting hal.make.cflags_undefined_symbols {none}
set_setting hal.make.cflags_user_flags {none}
set_setting hal.make.cflags_warnings {-Wall -Wformat-security}
set_setting hal.make.cxx_flags {none}
set_setting hal.make.enable_cflag_fstack_protector_strong {true}
set_setting hal.make.enable_cflag_wformat_security {true}
set_setting hal.make.link_flags {none}
set_setting hal.make.objdump_flags {-Sdtx}
set_setting hal.max_file_descriptors {32}
set_setting hal.stderr {sys_jtag_uart}
set_setting hal.stdin {sys_jtag_uart}
set_setting hal.stdout {sys_jtag_uart}
set_setting hal.sys_clk_timer {intel_niosv_g_4}
set_setting hal.timestamp_timer {intel_niosv_g_4}
set_setting hal.toolchain.ar {riscv32-unknown-elf-ar}
set_setting hal.toolchain.as {riscv32-unknown-elf-gcc}
set_setting hal.toolchain.cc {riscv32-unknown-elf-gcc}
set_setting hal.toolchain.cxx {riscv32-unknown-elf-g++}
set_setting hal.toolchain.enable_executable_overrides {false}
set_setting hal.toolchain.objdump {riscv32-unknown-elf-objdump}
set_setting hal.toolchain.prefix {riscv32-unknown-elf-}
set_setting hal.use_dfl_walker {false}
set_setting intel_eth_tse_driver_hal.autoneg_timeout {2500}
set_setting intel_eth_tse_driver_hal.checklink_timeout {10000}
set_setting intel_eth_tse_driver_hal.nomdio_timeout {1000000}
set_setting intel_niosv_g_freertos_driver.internal_timer_ticks_per_sec {1000}

# Software packages
enable_sw_package altera_freertos_tcpip:19.1

# Drivers
set_driver intel_niosv_g_freertos_driver intel_niosv_g_4
set_driver altera_msgdma_driver sys_tse_msgdma_tx
set_driver altera_avalon_jtag_uart_driver sys_jtag_uart
set_driver altera_msgdma_driver sys_tse_msgdma_rx
set_driver intel_eth_tse_driver_hal sys_tse

# User devices
add_memory_device core_sdram_axi4_0 134217728 67108864

# Linker memory regions
add_memory_region sys_cpu_ram sys_cpu_ram 0 524288
add_memory_region sys_desc_mem sys_desc_mem 0 512
add_memory_region reset core_sdram_axi4_0 0 32
add_memory_region core_sdram_axi4_0 core_sdram_axi4_0 32 67108832

# Linker section mappings
add_section_mapping .text core_sdram_axi4_0
add_section_mapping .exceptions core_sdram_axi4_0
add_section_mapping .rodata core_sdram_axi4_0
add_section_mapping .rwdata core_sdram_axi4_0
add_section_mapping .bss core_sdram_axi4_0
add_section_mapping .heap core_sdram_axi4_0
add_section_mapping .stack core_sdram_axi4_0
