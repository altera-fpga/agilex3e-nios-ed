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


set CABLE_INDEX 1
set DEVICE_INDEX 0
set ISSP_INDEX_0 0
set RESET_MS 100
 
set hw_name [lindex [get_hardware_names] $CABLE_INDEX]
set dev_name [lindex [get_device_names -hardware_name $hw_name] $DEVICE_INDEX]
 
start_insystem_source_probe  -hardware_name $hw_name -device_name $dev_name
 
# Create a reset pulse
#write_source_data -instance_index $ISSP_INDEX_0 -value 0
write_source_data -instance_index $ISSP_INDEX_0 -value 0x0 -value_in_hex
after $RESET_MS
write_source_data -instance_index $ISSP_INDEX_0 -value 0x2 -value_in_hex

