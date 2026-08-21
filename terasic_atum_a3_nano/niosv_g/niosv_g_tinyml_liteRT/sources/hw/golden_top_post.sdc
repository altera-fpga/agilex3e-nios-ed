#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Define Timing Constants
#**************************************************************
# SDRAM timing parameters
set tAC 8.0    ;# Access time from clock (CAS=2, ns)
set tOH 2.5    ;# Output hold time (ns)

# Board trace delays (ns)
set clk_trace_delay 0.129  ;# DRAM_CLK trace delay (128.616 ps)

# Individual DRAM_DQ trace delays (ns) - from DE23-Lite-B0 measurement
set dq0_trace  0.195   ;# DRAM_DQ0:  195.070 ps
set dq1_trace  0.194   ;# DRAM_DQ1:  194.289 ps  
set dq2_trace  0.195   ;# DRAM_DQ2:  195.176 ps
set dq3_trace  0.194   ;# DRAM_DQ3:  193.938 ps
set dq4_trace  0.195   ;# DRAM_DQ4:  194.787 ps
set dq5_trace  0.194   ;# DRAM_DQ5:  194.060 ps
set dq6_trace  0.194   ;# DRAM_DQ6:  194.472 ps
set dq7_trace  0.195   ;# DRAM_DQ7:  194.834 ps
set dq8_trace  0.195   ;# DRAM_DQ8:  195.232 ps
set dq9_trace  0.194   ;# DRAM_DQ9:  194.269 ps
set dq10_trace 0.194   ;# DRAM_DQ10: 194.379 ps
set dq11_trace 0.195   ;# DRAM_DQ11: 194.754 ps
set dq12_trace 0.194   ;# DRAM_DQ12: 194.480 ps
set dq13_trace 0.194   ;# DRAM_DQ13: 194.379 ps
set dq14_trace 0.194   ;# DRAM_DQ14: 194.367 ps
set dq15_trace 0.196   ;# DRAM_DQ15: 196.215 ps
set dq16_trace 0.166   ;# DRAM_DQ16: 165.913 ps
set dq17_trace 0.173   ;# DRAM_DQ17: 172.913 ps
set dq18_trace 0.165   ;# DRAM_DQ18: 164.584 ps
set dq19_trace 0.165   ;# DRAM_DQ19: 165.384 ps
set dq20_trace 0.166   ;# DRAM_DQ20: 165.738 ps
set dq21_trace 0.165   ;# DRAM_DQ21: 164.991 ps
set dq22_trace 0.165   ;# DRAM_DQ22: 165.381 ps
set dq23_trace 0.166   ;# DRAM_DQ23: 165.717 ps
set dq24_trace 0.194   ;# DRAM_DQ24: 193.820 ps
set dq25_trace 0.195   ;# DRAM_DQ25: 195.364 ps
set dq26_trace 0.195   ;# DRAM_DQ26: 194.756 ps
set dq27_trace 0.195   ;# DRAM_DQ27: 195.026 ps
set dq28_trace 0.195   ;# DRAM_DQ28: 195.164 ps
set dq29_trace 0.194   ;# DRAM_DQ29: 194.107 ps
set dq30_trace 0.194   ;# DRAM_DQ30: 194.301 ps
set dq31_trace 0.194   ;# DRAM_DQ31: 194.374 ps



#**************************************************************
# Create Generated Clock
#**************************************************************
# SDRAM CLK
create_generated_clock -source [get_pins {nios_system_Inst|iopll|iopll|tennm_ph2_iopll|out_clk[1]}] \
                      -name clk_dram_ext [get_ports {DRAM_CLK}]


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty


#**************************************************************
# Set Input Delay
#**************************************************************
# max: Board Delay (Data) + Board Delay (Clock) + tsu (External Device)
# min: Board Delay (Data) + Board Delay (Clock) + th (External Device)
# max(CAS = 2): 8(tAC2) + 0.13(clock board delay) + 0.20(data board delay) = 8.33
# max(CAS = 3): 5.5(tAC3) + 0.13(clock board delay) + 0.20(data board delay) = 5.83
# min: 2.5(tOH) + 0.13(clock trace delay) + 0.16(data trace delay) = 2.79
#
# Individual input delay using parametric calculation
# Formula: tAC/tOH + Clock_trace_delay + Signal_data_trace_delay  
# Max delay = $tAC + $clk_trace_delay + $dqN_trace
# Min delay = $tOH + $clk_trace_delay + $dqN_trace
# All trace delays based on actual DE23-Lite-B0 board measurements

# DRAM_DQ individual input delays
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq0_trace] [get_ports DRAM_DQ[0]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq0_trace] [get_ports DRAM_DQ[0]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq1_trace] [get_ports DRAM_DQ[1]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq1_trace] [get_ports DRAM_DQ[1]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq2_trace] [get_ports DRAM_DQ[2]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq2_trace] [get_ports DRAM_DQ[2]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq3_trace] [get_ports DRAM_DQ[3]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq3_trace] [get_ports DRAM_DQ[3]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq4_trace] [get_ports DRAM_DQ[4]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq4_trace] [get_ports DRAM_DQ[4]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq5_trace] [get_ports DRAM_DQ[5]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq5_trace] [get_ports DRAM_DQ[5]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq6_trace] [get_ports DRAM_DQ[6]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq6_trace] [get_ports DRAM_DQ[6]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq7_trace] [get_ports DRAM_DQ[7]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq7_trace] [get_ports DRAM_DQ[7]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq8_trace] [get_ports DRAM_DQ[8]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq8_trace] [get_ports DRAM_DQ[8]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq9_trace] [get_ports DRAM_DQ[9]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq9_trace] [get_ports DRAM_DQ[9]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq10_trace] [get_ports DRAM_DQ[10]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq10_trace] [get_ports DRAM_DQ[10]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq11_trace] [get_ports DRAM_DQ[11]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq11_trace] [get_ports DRAM_DQ[11]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq12_trace] [get_ports DRAM_DQ[12]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq12_trace] [get_ports DRAM_DQ[12]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq13_trace] [get_ports DRAM_DQ[13]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq13_trace] [get_ports DRAM_DQ[13]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq14_trace] [get_ports DRAM_DQ[14]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq14_trace] [get_ports DRAM_DQ[14]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq15_trace] [get_ports DRAM_DQ[15]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq15_trace] [get_ports DRAM_DQ[15]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq16_trace] [get_ports DRAM_DQ[16]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq16_trace] [get_ports DRAM_DQ[16]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq17_trace] [get_ports DRAM_DQ[17]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq17_trace] [get_ports DRAM_DQ[17]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq18_trace] [get_ports DRAM_DQ[18]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq18_trace] [get_ports DRAM_DQ[18]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq19_trace] [get_ports DRAM_DQ[19]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq19_trace] [get_ports DRAM_DQ[19]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq20_trace] [get_ports DRAM_DQ[20]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq20_trace] [get_ports DRAM_DQ[20]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq21_trace] [get_ports DRAM_DQ[21]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq21_trace] [get_ports DRAM_DQ[21]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq22_trace] [get_ports DRAM_DQ[22]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq22_trace] [get_ports DRAM_DQ[22]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq23_trace] [get_ports DRAM_DQ[23]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq23_trace] [get_ports DRAM_DQ[23]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq24_trace] [get_ports DRAM_DQ[24]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq24_trace] [get_ports DRAM_DQ[24]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq25_trace] [get_ports DRAM_DQ[25]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq25_trace] [get_ports DRAM_DQ[25]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq26_trace] [get_ports DRAM_DQ[26]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq26_trace] [get_ports DRAM_DQ[26]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq27_trace] [get_ports DRAM_DQ[27]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq27_trace] [get_ports DRAM_DQ[27]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq28_trace] [get_ports DRAM_DQ[28]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq28_trace] [get_ports DRAM_DQ[28]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq29_trace] [get_ports DRAM_DQ[29]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq29_trace] [get_ports DRAM_DQ[29]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq30_trace] [get_ports DRAM_DQ[30]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq30_trace] [get_ports DRAM_DQ[30]]
set_input_delay -max -clock clk_dram_ext [expr $tAC + $clk_trace_delay + $dq31_trace] [get_ports DRAM_DQ[31]]
set_input_delay -min -clock clk_dram_ext [expr $tOH + $clk_trace_delay + $dq31_trace] [get_ports DRAM_DQ[31]]


#shift-window
set_multicycle_path -from [get_clocks {clk_dram_ext}] \
                    -to [get_clocks {nios_system_Inst|iopll|iopll_outclk2}] \
                    -setup 2


#**************************************************************
# Set Output Delay
#**************************************************************
# max: Board Delay (Data/Cmd) - Board Delay (Clock) + tsu (External Device)
# min: Board Delay (Data/Cmd) - Board Delay (Clock) - th (External Device)
# max: 0.20(data board delay) - 0.13(clock board delay) + 1.5(tDS) = 1.57
# min: 0.16(data board delay) - 0.13(clock board delay) - 1.0(tDH) = -0.97
# max: 0.14(cmd board delay) - 0.13(clock board delay) + 1.5(tDS) = 1.51
# min: 0.09(cmd board delay) - 0.13(clock board delay) - 1.0(tDH) = -1.04
set_output_delay -max -clock clk_dram_ext 1.57  [get_ports {DRAM_DQ* DRAM_DQM*}]
set_output_delay -min -clock clk_dram_ext -0.97 [get_ports {DRAM_DQ* DRAM_DQM*}]
set_output_delay -max -clock clk_dram_ext 1.51  [get_ports {DRAM_ADDR* DRAM_BA* DRAM_RAS_n DRAM_CAS_n DRAM_WE_n DRAM_CKE DRAM_CS_n}]
set_output_delay -min -clock clk_dram_ext -1.04 [get_ports {DRAM_ADDR* DRAM_BA* DRAM_RAS_n DRAM_CAS_n DRAM_WE_n DRAM_CKE DRAM_CS_n}]



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************



