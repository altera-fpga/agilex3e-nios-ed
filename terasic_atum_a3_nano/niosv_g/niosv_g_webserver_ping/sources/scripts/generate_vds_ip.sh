#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCES="$(cd "$SCRIPT_DIR/.." && pwd)"
HW="$SOURCES/hw"
QSYS_DIR="$HW/src/vds/qsys_top"
CUSTOM_IP="$SOURCES/custom_logic/core_sdram_axi"

EXPECTED_IP=(
  qsys_top_core_sdram_axi4_0.ip
  qsys_top_intel_niosv_g_4.ip
  qsys_top_proc_clk.ip
  qsys_top_proc_rst.ip
  qsys_top_sdram_clock.ip
  qsys_top_sdram_reset.ip
  qsys_top_sys_cpu_ram.ip
  qsys_top_sys_desc_mem.ip
  qsys_top_sys_jtag_uart.ip
  qsys_top_sys_tse.ip
  qsys_top_sys_tse_msgdma_rx.ip
  qsys_top_sys_tse_msgdma_tx.ip
)

if [[ ! -f "$QSYS_DIR/qsys_top.tcl" ]]; then
  echo "ERROR: missing $QSYS_DIR/qsys_top.tcl" >&2
  exit 1
fi

if [[ ! -f "$HW/top.qpf" ]]; then
  echo "ERROR: missing $HW/top.qpf; run quartus_sh -t ../scripts/top.tcl first" >&2
  exit 1
fi

if [[ ! -d "$CUSTOM_IP" ]]; then
  echo "ERROR: missing custom IP directory $CUSTOM_IP" >&2
  exit 1
fi

cp "$CUSTOM_IP/core_sdram_axi4_hw.tcl" "$HW/"
cp "$CUSTOM_IP/sdram_axi.v" "$HW/"
cp "$CUSTOM_IP/sdram_axi_core.v" "$HW/"
cp "$CUSTOM_IP/sdram_axi_pmem.v" "$HW/"

rm -rf "$QSYS_DIR/ip"
rm -f "$QSYS_DIR/qsys_top.qsys"
rm -rf "$QSYS_DIR/qsys_top"
mkdir -p "$QSYS_DIR/ip"

(
  cd "$QSYS_DIR"
  qsys-script \
    --script=qsys_top.tcl \
    --quartus-project=../../../top.qpf \
    --search-path='../../../../custom_logic/core_sdram_axi/**/*,$'
)

qsf_tmp="$(mktemp)"
awk '
  /^set_global_assignment -name IP_FILE src\/vds\/qsys_top\/ip\// { next }
  /^set_global_assignment -name QSYS_FILE src\/vds\/qsys_top\/qsys_top\.qsys$/ { next }
  { print }
' "$HW/top.qsf" > "$qsf_tmp"
mv "$qsf_tmp" "$HW/top.qsf"

missing=0
for ip_file in "${EXPECTED_IP[@]}"; do
  if [[ ! -f "$QSYS_DIR/ip/$ip_file" ]]; then
    echo "ERROR: generator did not create ip/$ip_file" >&2
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

echo "Generated ${#EXPECTED_IP[@]} VDS child IP files in $QSYS_DIR/ip"
echo "Generated transient Platform Designer system $QSYS_DIR/qsys_top.qsys"
