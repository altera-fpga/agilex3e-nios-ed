#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HELPER="$ROOT/../../tse_jtag_maconly/scripts/with_eval_programmer.py"
STAMP="${2:-$(date -u +%Y%m%dT%H%M%SZ)}"
SOF="${SOF:-$ROOT/sources/hw/output_files/top_time_limited.sof}"
ELF="${ELF:-$ROOT/sources/sw/app_freertos/build/app_freertos.elf}"
CABLE="${CABLE:-1}"
JTAG_CLOCK="${JTAG_CLOCK:-6M}"
INTERFACE="${INTERFACE:-enp5s0}"
HOST_IP="${HOST_IP:-10.0.0.1}"
FPGA_IP="${FPGA_IP:-10.0.0.2}"
UDP_PORT="${UDP_PORT:-5002}"
HOST_UDP_PORT="${HOST_UDP_PORT:-5002}"
UDP_COUNT="${UDP_COUNT:-5}"
UDP_RETRIES="${UDP_RETRIES:-3}"
LOG_DIR="$ROOT/logs"
LOG="$LOG_DIR/tse_eval_udp_loopback_${STAMP}.log"
UART_LOG="$LOG_DIR/tse_eval_udp_loopback_${STAMP}_juart.log"
HOST_LOG="$LOG_DIR/tse_eval_udp_loopback_${STAMP}_host.log"
UDP_LOG="$LOG_DIR/tse_eval_udp_loopback_${STAMP}_udp.log"
MANIFEST="$LOG_DIR/tse_eval_udp_loopback_${STAMP}_manifest.txt"

if [[ "${1:-}" == "--inner" ]]; then
  shift 2
  cd "$ROOT"

  jtagconfig --debug
  quartus_stp -t ready_to_test/toggle_issp.tcl
  quartus_stp -t ready_to_test/read_rgmii_issp.tcl

  niosv-download --use_openocd -g -r "$ELF" -c "$CABLE"

  ( timeout 75s juart-terminal -d 1 -c "$CABLE" -i 0 || true ) | tee "$UART_LOG" &
  UART_PID=$!
  cleanup_uart() {
    kill "$UART_PID" 2>/dev/null || true
    wait "$UART_PID" 2>/dev/null || true
  }
  trap cleanup_uart EXIT

  sleep 15
  ip addr show dev "$INTERFACE" | tee "$HOST_LOG"
  ip neigh flush "$FPGA_IP" dev "$INTERFACE" 2>/dev/null || true

  ping -c 4 -W 2 -I "$INTERFACE" "$FPGA_IP" | tee -a "$HOST_LOG" || true
  ip neigh show "$FPGA_IP" dev "$INTERFACE" | tee -a "$HOST_LOG" || true

  python3 - "$HOST_IP" "$FPGA_IP" "$UDP_PORT" "$HOST_UDP_PORT" "$UDP_COUNT" "$UDP_RETRIES" <<'PY' | tee "$UDP_LOG"
import socket
import sys
import time

host_ip = sys.argv[1]
fpga_ip = sys.argv[2]
udp_port = int(sys.argv[3])
host_udp_port = int(sys.argv[4])
count = int(sys.argv[5])
retries = int(sys.argv[6])

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.settimeout(2.0)
sock.bind((host_ip, host_udp_port))

ok = 0
print(f"UDP_LOOPBACK_BIND host={host_ip}:{sock.getsockname()[1]}")
print(f"UDP_LOOPBACK_TARGET fpga={fpga_ip}:{udp_port}")
print(f"UDP_LOOPBACK_RETRIES per_datagram={retries}")

for index in range(count):
    payload = f"ATUM-UDP-LOOPBACK-{index:02d}".encode("ascii")
    matched = False
    for attempt in range(1, retries + 1):
        sock.sendto(payload, (fpga_ip, udp_port))
        try:
            data, address = sock.recvfrom(2048)
        except socket.timeout:
            print(f"UDP_LOOPBACK datagram={index + 1} attempt={attempt} FAIL timeout")
            continue

        match = data == payload and address[0] == fpga_ip and address[1] == udp_port
        print(
            f"UDP_LOOPBACK datagram={index + 1} attempt={attempt} "
            f"from={address[0]}:{address[1]} len={len(data)} "
            f"match={int(match)} data={data!r}"
        )
        if match:
            matched = True
            break
    if matched:
        ok += 1
    time.sleep(0.5)

print(f"UDP_LOOPBACK_RESULT ok={ok} count={count}")
sys.exit(0 if ok == count else 1)
PY

  sleep 5
  exit 0
fi

mkdir -p "$LOG_DIR"

{
  echo "RUN_ID=$STAMP"
  echo "SOF=$SOF"
  echo "ELF=$ELF"
  echo "INTERFACE=$INTERFACE"
  echo "HOST_IP=$HOST_IP"
  echo "FPGA_IP=$FPGA_IP"
  echo "UDP_PORT=$UDP_PORT"
  echo "HOST_UDP_PORT=$HOST_UDP_PORT"
  echo "UDP_COUNT=$UDP_COUNT"
  echo "UDP_RETRIES=$UDP_RETRIES"
  sha256sum "$SOF" "$ELF"
} | tee "$MANIFEST"

exec "$HELPER" \
  --sof "$SOF" \
  --workdir "$ROOT" \
  --cable "$CABLE" \
  --jtag-clock "$JTAG_CLOCK" \
  --log "$LOG" \
  -- \
  "$ROOT/run_tse_eval_udp_loopback.sh" --inner "$STAMP"
