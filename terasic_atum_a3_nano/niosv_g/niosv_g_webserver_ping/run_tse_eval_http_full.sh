#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCES="$ROOT/sources"
HW="$SOURCES/hw"

export LM_LICENSE_FILE="${LM_LICENSE_FILE:-/home/dev/License.dat}"
export SALT_LICENSE_SERVER="${SALT_LICENSE_SERVER:-/home/dev/License.dat}"

cd "$SOURCES"

cp custom_logic/core_sdram_axi/core_sdram_axi4_hw.tcl hw/
cp custom_logic/core_sdram_axi/sdram_axi.v hw/
cp custom_logic/core_sdram_axi/sdram_axi_core.v hw/
cp custom_logic/core_sdram_axi/sdram_axi_pmem.v hw/

cd "$HW"
rm -rf dni gen issp logs output_files qdb reset_release sys_pll tmp-clearbox
quartus_sh -t ../scripts/top.tcl
../scripts/generate_vds_ip.sh
quartus_ipgenerate top.qpf
quartus_sh --flow compile top

cd "$SOURCES"
./scripts/build_sw_http_server.sh

cd "$ROOT"
cp sources/hw/output_files/top_time_limited.sof ready_to_test/top.sof
cp sources/sw/app_freertos/build/app_freertos.elf ready_to_test/app_freertos.elf

./run_tse_eval_http_server.sh
