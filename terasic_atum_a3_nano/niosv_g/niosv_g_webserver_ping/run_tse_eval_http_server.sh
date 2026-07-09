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
HTTP_PORT="${HTTP_PORT:-80}"
HTTP_RETRIES="${HTTP_RETRIES:-3}"
HTTP_HOLD_SECONDS="${HTTP_HOLD_SECONDS:-5}"
HTTP_FETCH_IMAGE="${HTTP_FETCH_IMAGE:-0}"
LOG_DIR="$ROOT/logs"
LOG="$LOG_DIR/tse_eval_http_server_${STAMP}.log"
UART_LOG="$LOG_DIR/tse_eval_http_server_${STAMP}_juart.log"
HOST_LOG="$LOG_DIR/tse_eval_http_server_${STAMP}_host.log"
HTTP_LOG="$LOG_DIR/tse_eval_http_server_${STAMP}_http.log"
HTTP_BODY="$LOG_DIR/tse_eval_http_server_${STAMP}.html"
IMAGE_LOG="$LOG_DIR/tse_eval_http_server_${STAMP}_image.log"
IMAGE_BODY="$LOG_DIR/tse_eval_http_server_${STAMP}_bg.jpg"
MANIFEST="$LOG_DIR/tse_eval_http_server_${STAMP}_manifest.txt"

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

  set +e
  python3 - "$HOST_IP" "$FPGA_IP" "$HTTP_PORT" "$HTTP_BODY" "$HTTP_RETRIES" <<'PY' | tee "$HTTP_LOG"
import socket
import sys
import time

host_ip = sys.argv[1]
fpga_ip = sys.argv[2]
http_port = int(sys.argv[3])
body_path = sys.argv[4]
retries = int(sys.argv[5])

request = (
    f"GET / HTTP/1.1\r\n"
    f"Host: {fpga_ip}\r\n"
    "Connection: close\r\n"
    "\r\n"
).encode("ascii")

print(f"HTTP_FETCH_TARGET fpga={fpga_ip}:{http_port}")
print(f"HTTP_FETCH_RETRIES count={retries}")

last_error = None
for attempt in range(1, retries + 1):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(5.0)
    sock.bind((host_ip, 0))
    print(f"HTTP_FETCH_BIND attempt={attempt} host={host_ip}:{sock.getsockname()[1]}")

    try:
        sock.connect((fpga_ip, http_port))
        sock.sendall(request)
        chunks = []
        content_length = None
        while True:
            data = sock.recv(1024)
            if not data:
                break
            chunks.append(data)
            response_so_far = b"".join(chunks)
            header, sep, body_so_far = response_so_far.partition(b"\r\n\r\n")
            if sep and content_length is None:
                for line in header.split(b"\r\n")[1:]:
                    name, colon, value = line.partition(b":")
                    if colon and name.strip().lower() == b"content-length":
                        content_length = int(value.strip())
                        break
            if content_length is not None and len(body_so_far) >= content_length:
                break
    except OSError as exc:
        last_error = exc
        print(f"HTTP_FETCH_ATTEMPT attempt={attempt} error={exc!r}")
        chunks = []
    finally:
        sock.close()

    response = b"".join(chunks)
    header, sep, body = response.partition(b"\r\n\r\n")
    status = header.split(b"\r\n", 1)[0] if header else b""
    body_text = body.decode("utf-8", errors="replace") if sep else response.decode("utf-8", errors="replace")
    ok = status.startswith(b"HTTP/1.1 200") and "Atum A3 Nano" in body_text

    print(f"HTTP_FETCH_STATUS attempt={attempt} {status.decode('ascii', errors='replace')}")
    print(f"HTTP_FETCH_BYTES attempt={attempt} response={len(response)} body={len(body if sep else response)}")
    if ok:
        with open(body_path, "wb") as f:
            f.write(body if sep else response)
        print("HTTP_FETCH_RESULT PASS")
        sys.exit(0)
    time.sleep(1.0)

print(f"HTTP_FETCH_RESULT FAIL last_error={last_error!r}")
sys.exit(1)
PY
  HTTP_STATUS=${PIPESTATUS[0]}
  set -e

  if [[ "$HTTP_STATUS" -eq 0 && "$HTTP_FETCH_IMAGE" == "1" ]]; then
    set +e
    python3 - "$HOST_IP" "$FPGA_IP" "$HTTP_PORT" "$IMAGE_BODY" <<'PY' | tee "$IMAGE_LOG"
import socket
import sys

host_ip = sys.argv[1]
fpga_ip = sys.argv[2]
http_port = int(sys.argv[3])
body_path = sys.argv[4]

request = (
    "GET /bg.jpg HTTP/1.1\r\n"
    f"Host: {fpga_ip}\r\n"
    "Connection: close\r\n"
    "\r\n"
).encode("ascii")

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.settimeout(5.0)
sock.bind((host_ip, 0))
print(f"IMAGE_FETCH_TARGET fpga={fpga_ip}:{http_port}/bg.jpg")
print(f"IMAGE_FETCH_BIND host={host_ip}:{sock.getsockname()[1]}")

try:
    sock.connect((fpga_ip, http_port))
    sock.sendall(request)
    chunks = []
    content_length = None
    while True:
        data = sock.recv(1024)
        if not data:
            break
        chunks.append(data)
        response_so_far = b"".join(chunks)
        header, sep, body_so_far = response_so_far.partition(b"\r\n\r\n")
        if sep and content_length is None:
            for line in header.split(b"\r\n")[1:]:
                name, colon, value = line.partition(b":")
                if colon and name.strip().lower() == b"content-length":
                    content_length = int(value.strip())
                    break
        if content_length is not None and len(body_so_far) >= content_length:
            break
finally:
    sock.close()

response = b"".join(chunks)
header, sep, body = response.partition(b"\r\n\r\n")
status = header.split(b"\r\n", 1)[0] if header else b""
content_type = b""
for line in header.split(b"\r\n")[1:]:
    name, colon, value = line.partition(b":")
    if colon and name.strip().lower() == b"content-type":
        content_type = value.strip().lower()
        break
ok = status.startswith(b"HTTP/1.1 200") and content_type.startswith(b"image/jpeg") and body.startswith(b"\xff\xd8") and len(body) > 1000
print(f"IMAGE_FETCH_STATUS {status.decode('ascii', errors='replace')}")
print(f"IMAGE_FETCH_TYPE {content_type.decode('ascii', errors='replace')}")
print(f"IMAGE_FETCH_BYTES response={len(response)} body={len(body)}")
if ok:
    with open(body_path, "wb") as f:
        f.write(body)
    print("IMAGE_FETCH_RESULT PASS")
    sys.exit(0)
print("IMAGE_FETCH_RESULT FAIL")
sys.exit(1)
PY
    IMAGE_STATUS=${PIPESTATUS[0]}
    set -e
    if [[ "$IMAGE_STATUS" -ne 0 ]]; then
      HTTP_STATUS="$IMAGE_STATUS"
    fi
  fi

  sleep "$HTTP_HOLD_SECONDS"
  exit "$HTTP_STATUS"
fi

mkdir -p "$LOG_DIR"

{
  echo "RUN_ID=$STAMP"
  echo "SOF=$SOF"
  echo "ELF=$ELF"
  echo "INTERFACE=$INTERFACE"
  echo "HOST_IP=$HOST_IP"
  echo "FPGA_IP=$FPGA_IP"
  echo "HTTP_PORT=$HTTP_PORT"
  echo "HTTP_RETRIES=$HTTP_RETRIES"
  echo "HTTP_HOLD_SECONDS=$HTTP_HOLD_SECONDS"
  echo "HTTP_FETCH_IMAGE=$HTTP_FETCH_IMAGE"
  sha256sum "$SOF" "$ELF"
} | tee "$MANIFEST"

exec "$HELPER" \
  --sof "$SOF" \
  --workdir "$ROOT" \
  --cable "$CABLE" \
  --jtag-clock "$JTAG_CLOCK" \
  --log "$LOG" \
  -- \
  "$ROOT/run_tse_eval_http_server.sh" --inner "$STAMP"
