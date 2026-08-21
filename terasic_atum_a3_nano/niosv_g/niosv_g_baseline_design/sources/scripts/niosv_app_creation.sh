niosv-bsp -c --quartus-project=hw/top.qpf --system=hw/src/vds/qsys_top/qsys_top.vds --type=hal sw/bsp_with_pb/settings.bsp
niosv-app --bsp-dir=sw/bsp_with_pb --app-dir=sw/app_with_pb --srcs=sw/app_with_pb/main.c
cmake -S ./sw/app_with_pb -B sw/app_with_pb/build
make -C sw/app_with_pb/build
#################################
niosv-bsp -c --quartus-project=hw/top.qpf --system=hw/src/vds/qsys_top/qsys_top.vds --type=hal sw/bsp_without_pb/settings.bsp
niosv-app --bsp-dir=sw/bsp_without_pb --app-dir=sw/app_without_pb --srcs=sw/app_without_pb/main.c
cmake -S ./sw/app_without_pb -B sw/app_without_pb/build
make -C sw/app_without_pb/build
elf2hex sw/app_without_pb/build/app_without_pb.elf -b 0x0 -w 32 -e 0x3ffff hw/onchip_mem.hex -r4