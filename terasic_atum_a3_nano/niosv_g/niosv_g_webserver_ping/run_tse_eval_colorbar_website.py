#!/usr/bin/env python3
"""Program the eval SOF, keep quartus_pgm open, and test the color-bar page."""

from __future__ import annotations

import argparse
import datetime as dt
import os
import subprocess
import sys
import threading
import time
from pathlib import Path


PROMPT = "Please enter i for info and q to quit:"
TOOL_PATH = (
    "/opt/altera/riscfree/debugger/gdbserver-riscv:"
    "/opt/altera/riscfree/toolchain/riscv32-unknown-elf/bin:"
    "/opt/altera/questa_fse/bin:"
    "/opt/altera/quartus/bin:"
    "/opt/altera/quartus/sopc_builder/bin:"
    "/opt/altera/niosv/bin"
)


def env_with_tools() -> dict[str, str]:
    env = os.environ.copy()
    env["PATH"] = f"{TOOL_PATH}:{env.get('PATH', '')}"
    env.setdefault("LM_LICENSE_FILE", "/home/dev/License.dat")
    env.setdefault("SALT_LICENSE_SERVER", "/home/dev/License.dat")
    return env


class Log:
    def __init__(self, path: Path):
        path.parent.mkdir(parents=True, exist_ok=True)
        self.file = path.open("w", encoding="utf-8", errors="replace")

    def write(self, text: str) -> None:
        sys.stdout.write(text)
        sys.stdout.flush()
        self.file.write(text)
        self.file.flush()

    def close(self) -> None:
        self.file.close()


def run(command: list[str], cwd: Path, log: Log, check: bool = True) -> int:
    log.write(f"\n[run] cwd={cwd} cmd={' '.join(command)}\n")
    proc = subprocess.Popen(
        command,
        cwd=str(cwd),
        env=env_with_tools(),
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        bufsize=1,
    )
    assert proc.stdout is not None
    for line in proc.stdout:
        log.write(line)
    rc = proc.wait()
    if check and rc != 0:
        raise RuntimeError(f"command failed rc={rc}: {' '.join(command)}")
    return rc


def start_uart_capture(cable: str, cwd: Path, log: Log, seconds: float) -> subprocess.Popen[str]:
    command = ["juart-terminal", "--quiet", "--flush", "-c", cable, "-o", f"{seconds:.0f}"]
    log.write(f"\n[uart] starting capture cmd={' '.join(command)}\n")
    proc = subprocess.Popen(
        command,
        cwd=str(cwd),
        env=env_with_tools(),
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        bufsize=1,
    )

    def reader() -> None:
        assert proc.stdout is not None
        for line in proc.stdout:
            log.write(f"[uart] {line}")

    thread = threading.Thread(target=reader, daemon=True)
    thread.start()
    return proc


def wait_for_ping(args: argparse.Namespace, root: Path, log: Log) -> None:
    deadline = time.monotonic() + args.ping_deadline
    attempt = 1
    while True:
        rc = run(
            ["ping", "-c", "1", "-W", "2", "-I", args.interface, args.fpga_ip],
            root,
            log,
            check=False,
        )
        if rc == 0:
            run(["ping", "-c", "4", "-W", "2", "-I", args.interface, args.fpga_ip], root, log)
            return
        if time.monotonic() >= deadline:
            raise RuntimeError(
                f"ping failed after {attempt} attempt(s) and {args.ping_deadline:.0f}s deadline"
            )
        attempt += 1
        time.sleep(2.0)


def main() -> int:
    root = Path(__file__).resolve().parent
    stamp = dt.datetime.now(dt.UTC).strftime("%Y%m%dT%H%M%SZ")

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--sof", type=Path, default=root / "ready_to_test" / "top.sof")
    parser.add_argument("--elf", type=Path, default=root / "ready_to_test" / "app_freertos.elf")
    parser.add_argument("--cable", default="1")
    parser.add_argument("--jtag-clock", default="6M")
    parser.add_argument("--interface", default="enp5s0")
    parser.add_argument("--fpga-ip", default="10.0.0.2")
    parser.add_argument("--network-wait", type=float, default=25.0)
    parser.add_argument("--ping-deadline", type=float, default=45.0)
    parser.add_argument("--uart-seconds", type=float, default=90.0)
    parser.add_argument("--hold-seconds", type=float, default=0.0)
    parser.add_argument("--stamp", default=stamp)
    args = parser.parse_args()

    if not args.sof.exists():
        raise SystemExit(f"SOF not found: {args.sof}")
    if not args.elf.exists():
        raise SystemExit(f"ELF not found: {args.elf}")

    log_dir = root / "logs"
    log = Log(log_dir / f"tse_eval_colorbar_website_{args.stamp}.log")
    html_path = log_dir / f"tse_eval_colorbar_website_{args.stamp}.html"
    header_path = log_dir / f"tse_eval_colorbar_website_{args.stamp}_headers.txt"

    pgm: subprocess.Popen[str] | None = None
    uart: subprocess.Popen[str] | None = None
    prompt_seen = threading.Event()
    recent: list[str] = []

    def reader() -> None:
        assert pgm is not None and pgm.stdout is not None
        while True:
            char = pgm.stdout.read(1)
            if char == "":
                break
            recent.append(char)
            if len(recent) > 8192:
                del recent[:4096]
            log.write(char)
            if PROMPT in "".join(recent):
                prompt_seen.set()

    try:
        log.write(f"RUN_ID={args.stamp}\n")
        log.write(f"SOF={args.sof}\n")
        log.write(f"ELF={args.elf}\n")
        log.write(f"INTERFACE={args.interface}\n")
        log.write(f"FPGA_IP={args.fpga_ip}\n")
        log.write("[eval] starting quartus_pgm and holding Eval prompt open\n")

        pgm = subprocess.Popen(
            ["quartus_pgm", f"--cable={args.cable}", "-m", "jtag", "-o", f"p;{args.sof}"],
            cwd=str(root),
            env=env_with_tools(),
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=0,
        )
        thread = threading.Thread(target=reader, daemon=True)
        thread.start()

        deadline = time.monotonic() + 180.0
        while time.monotonic() < deadline:
            if prompt_seen.is_set():
                break
            if pgm.poll() is not None:
                raise RuntimeError(f"quartus_pgm exited before Eval prompt rc={pgm.returncode}")
            time.sleep(0.1)
        if not prompt_seen.is_set():
            raise RuntimeError("timed out waiting for Eval prompt")
        log.write("\n[eval] prompt detected; programmer remains open during test\n")

        run(["jtagconfig", "--setparam", args.cable, "JtagClock", args.jtag_clock], root, log)
        run(["jtagconfig", "--debug"], root, log)
        run(["niosv-download", "--use_openocd", "-g", "-r", str(args.elf), "-c", args.cable], root, log)
        uart = start_uart_capture(args.cable, root, log, args.uart_seconds)

        log.write("\n[test] waiting for FreeRTOS network bring-up\n")
        time.sleep(args.network_wait)

        run(["ip", "neigh", "flush", args.fpga_ip, "dev", args.interface], root, log, check=False)
        wait_for_ping(args, root, log)
        run(
            [
                "curl",
                "--interface",
                args.interface,
                "--connect-timeout",
                "5",
                "--max-time",
                "20",
                "-sS",
                "-D",
                str(header_path),
                "-o",
                str(html_path),
                f"http://{args.fpga_ip}/",
            ],
            root,
            log,
        )

        html = html_path.read_text(encoding="utf-8", errors="replace")
        headers = header_path.read_text(encoding="utf-8", errors="replace")
        ok = (
            "HTTP/1.1 200 OK" in headers
            and "FreeRTOS + TSE small MAC is serving color bars." in html
            and "background:#f00" in html
            and "background:#00f" in html
        )
        log.write(f"\n[test] COLORBAR_HTTP_RESULT {'PASS' if ok else 'FAIL'}\n")
        log.write(f"[test] HTML={html_path}\n")
        log.write(f"[test] HEADERS={header_path}\n")
        if not ok:
            return 1

        if args.hold_seconds > 0:
            log.write(f"[eval] holding programmer open for {args.hold_seconds:.1f} seconds\n")
            time.sleep(args.hold_seconds)
        return 0
    except KeyboardInterrupt:
        log.write("\n[eval] interrupted\n")
        return 130
    except Exception as exc:
        log.write(f"\n[eval] ERROR {exc}\n")
        return 1
    finally:
        if uart is not None and uart.poll() is None:
            log.write("\n[uart] stopping capture\n")
            uart.terminate()
            try:
                uart.wait(timeout=5)
            except subprocess.TimeoutExpired:
                uart.kill()
        if pgm is not None and pgm.poll() is None:
            log.write("\n[eval] closing Eval prompt with q\n")
            try:
                assert pgm.stdin is not None
                pgm.stdin.write("q\n")
                pgm.stdin.flush()
                pgm.wait(timeout=15)
            except Exception as exc:
                log.write(f"[eval] quartus_pgm cleanup warning: {exc}\n")
                pgm.terminate()
        log.close()


if __name__ == "__main__":
    raise SystemExit(main())
