#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HELPER="$ROOT/../../tse_jtag_maconly/scripts/with_eval_programmer.py"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
SOF="${SOF:-$ROOT/sources/hw/output_files/top_time_limited.sof}"
ELF="${ELF:-$ROOT/sources/sw/app_freertos/build/app_freertos.elf}"
CABLE="${CABLE:-1}"
JTAG_CLOCK="${JTAG_CLOCK:-6M}"
INTERFACE="${INTERFACE:-enp5s0}"
FPGA_IP="${FPGA_IP:-10.0.0.2}"
LOG_DIR="$ROOT/logs"
LOG="$LOG_DIR/tse_eval_network_smoke_${STAMP}.log"
UART_LOG="$LOG_DIR/tse_eval_network_smoke_${STAMP}_juart.log"
HOST_LOG="$LOG_DIR/tse_eval_network_smoke_${STAMP}_host.log"

mkdir -p "$LOG_DIR"

{
  echo "RUN_ID=$STAMP"
  echo "SOF=$SOF"
  echo "ELF=$ELF"
  sha256sum "$SOF" "$ELF"
} | tee "$LOG_DIR/tse_eval_network_smoke_${STAMP}_manifest.txt"

exec "$HELPER" \
  --sof "$SOF" \
  --workdir "$ROOT" \
  --cable "$CABLE" \
  --jtag-clock "$JTAG_CLOCK" \
  --log "$LOG" \
  -- \
  bash -lc "set -euo pipefail
    jtagconfig --debug
    cd sources/sw/app_freertos
    niosv-download --use_openocd -g -r '$ELF' -c '$CABLE'
    timeout 25s juart-terminal -c '$CABLE' | tee '$UART_LOG' || true
    ip neigh flush '$FPGA_IP' dev '$INTERFACE' 2>/dev/null || true
    ping -c 8 -W 2 -I '$INTERFACE' '$FPGA_IP' | tee '$HOST_LOG' || true
    ip neigh show '$FPGA_IP' dev '$INTERFACE' | tee -a '$HOST_LOG' || true
    timeout 20s juart-terminal -c '$CABLE' | tee -a '$UART_LOG' || true
  "
