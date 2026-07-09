set CABLE_INDEX 0
set DEVICE_INDEX 0
set ISSP_INDEX_0 0

set hw_name [lindex [get_hardware_names] $CABLE_INDEX]
set dev_name [lindex [get_device_names -hardware_name $hw_name] $DEVICE_INDEX]

start_insystem_source_probe -hardware_name $hw_name -device_name $dev_name

set raw_hex [read_probe_data -instance_index $ISSP_INDEX_0 -value_in_hex]
set raw [expr 0x$raw_hex]

set ena_10 [expr {$raw & 0x1}]
set eth_mode [expr {($raw >> 1) & 0x1}]
set rxclk_count [expr {($raw >> 2) & 0xffff}]

puts [format "raw=0x%s" $raw_hex]
puts [format "ena_10=%d eth_mode=%d" $ena_10 $eth_mode]
puts [format "rxclk_count=0x%04X" $rxclk_count]

end_insystem_source_probe
