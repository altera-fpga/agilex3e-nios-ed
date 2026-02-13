niosv-bsp -c --quartus-project=hw_without_fifo/top.qpf --qsys=hw_without_fifo/qsys_top.qsys --type=freertos --cmd="enable_sw_package altera_freertos_tcpip" --script=sw_without_fifo/bsp_settings.tcl --no-default sw_without_fifo/bsp_freertos/settings.bsp
niosv-app --bsp-dir=sw_without_fifo/bsp_freertos --app-dir=sw_without_fifo/app_freertos --srcs=sw_without_fifo/app_freertos/main.c
cmake -S ./sw_without_fifo/app_freertos -B sw_without_fifo/app_freertos/build
make -C sw_without_fifo/app_freertos/build