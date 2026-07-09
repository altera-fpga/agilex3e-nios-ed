#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
SOURCES_DIR=$(cd "$SCRIPT_DIR/.." && pwd)

cd "$SOURCES_DIR"

rm -rf sw/bsp_freertos sw/app_freertos/build

niosv-bsp --create --no-default \
    --system=./hw/src/vds/qsys_top/qsys_top.vds \
    --quartus_project=./hw/top.qpf \
    --type=freertos \
    -cmd="enable_sw_package altera_freertos_tcpip" \
    ./sw/bsp_freertos/settings.bsp \
    --script=./sw/bsp_settings.tcl

rm -rf sw/bsp_freertos/FreeRTOS_TCP_IP/source/portable/NetworkInterface/AlteraTSE
mkdir -p sw/bsp_freertos/FreeRTOS_TCP_IP/source/portable/NetworkInterface/AlteraTSE
cp -a sw/AlteraTSE/. sw/bsp_freertos/FreeRTOS_TCP_IP/source/portable/NetworkInterface/AlteraTSE/
cp sw/FreeRTOSIPConfig.h sw/bsp_freertos/FreeRTOS_TCP_IP/source/include/FreeRTOSIPConfig.h

niosv-app --bsp-dir=sw/bsp_freertos \
    --app-dir=sw/app_freertos \
    --srcs=sw/app_freertos/main.c

cmake -S ./sw/app_freertos -B sw/app_freertos/build
make -C sw/app_freertos/build -j"$(nproc)"

sha256sum sw/app_freertos/build/app_freertos.elf
riscv32-unknown-elf-size -A sw/app_freertos/build/app_freertos.elf | sed -n '1,35p'
