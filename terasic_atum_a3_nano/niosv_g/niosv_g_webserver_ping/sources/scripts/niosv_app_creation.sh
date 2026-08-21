# (C) 2001-2026 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files from any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera IP License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


niosv-bsp --create --no-default --system=./hw/src/vds/qsys_top/qsys_top.vds --quartus_project=./hw/top.qpf --type=freertos -cmd="enable_sw_package altera_freertos_tcpip" ./sw/bsp_freertos/settings.bsp --script=./sw/bsp_settings.tcl
niosv-app --bsp-dir=sw/bsp_freertos --app-dir=sw/app_freertos --srcs=sw/app_freertos/main.c
perl scripts/comment_hex.pl sw/app_freertos/CMakeLists.txt
cmake -S ./sw/app_freertos -B sw/app_freertos/build
make -C sw/app_freertos/build
