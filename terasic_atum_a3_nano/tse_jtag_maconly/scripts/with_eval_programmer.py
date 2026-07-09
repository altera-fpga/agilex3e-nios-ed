#!/usr/bin/env python3
"""Run a hardware test while quartus_pgm holds a time-limited IP eval prompt."""

from __future__ import annotations

import argparse
import datetime as dt
import os
import subprocess
import sys
import threading
import time
from pathlib import Path


DEFAULT_PROMPT = "Please enter i for info and q to quit:"
QUARTUS_PATH = (
    "/opt/altera/riscfree/debugger/gdbserver-riscv:"
    "/opt/altera/riscfree/toolchain/riscv32-unknown-elf/bin:"
    "/opt/altera/questa_fse/bin:"
    "/opt/altera/quartus/bin:"
    "/opt/altera/quartus/sopc_builder/bin:"
    "/opt/altera/niosv/bin"
)


class TeeLog:
    def __init__(self, path: Path | None):
        self.path = path
        self.file = None
        if path is not None:
            path.parent.mkdir(parents=True, exist_ok=True)
            self.file = path.open("w", encoding="utf-8", errors="replace")

    def write(self, text: str) -> None:
        sys.stdout.write(text)
        sys.stdout.flush()
        if self.file is not None:
            self.file.write(text)
            self.file.flush()

    def close(self) -> None:
        if self.file is not None:
            self.file.close()


def env_with_tools() -> dict[str, str]:
    env = os.environ.copy()
    env["PATH"] = f"{QUARTUS_PATH}:{env.get('PATH', '')}"
    env.setdefault("LM_LICENSE_FILE", "/home/dev/License.dat")
    env.setdefault("SALT_LICENSE_SERVER", "/home/dev/License.dat")
    return env


def run_streamed(command: list[str], cwd: Path, log: TeeLog) -> int:
    log.write(f"\n[with_eval_programmer] RUN cwd={cwd} cmd={' '.join(command)}\n")
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
    return proc.wait()


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--sof", required=True, type=Path, help="time-limited SOF to program")
    parser.add_argument("--workdir", default=".", type=Path, help="working directory for the test command")
    parser.add_argument("--cable", default="1", help="Quartus programmer cable name or index")
    parser.add_argument("--jtag-clock", default="6M", help="JTAG clock to set after programming")
    parser.add_argument("--prompt", default=DEFAULT_PROMPT, help="eval prompt text to wait for")
    parser.add_argument("--program-timeout", type=float, default=180.0)
    parser.add_argument("--log", type=Path, help="combined log path")
    parser.add_argument("command", nargs=argparse.REMAINDER, help="test command after --")
    args = parser.parse_args()

    command = args.command
    if command and command[0] == "--":
        command = command[1:]
    if not command:
        parser.error("missing test command after --")
    if not args.sof.exists():
        raise SystemExit(f"SOF not found: {args.sof}")

    log = TeeLog(args.log)
    pgm: subprocess.Popen[str] | None = None
    buffer: list[str] = []
    prompt_seen = threading.Event()

    def reader() -> None:
        assert pgm is not None and pgm.stdout is not None
        while True:
            char = pgm.stdout.read(1)
            if char == "":
                break
            buffer.append(char)
            if len(buffer) > 8192:
                del buffer[:4096]
            log.write(char)
            if args.prompt in "".join(buffer):
                prompt_seen.set()

    try:
        started = dt.datetime.now(dt.UTC).isoformat()
        log.write(f"[with_eval_programmer] START {started}\n")
        log.write(f"[with_eval_programmer] SOF {args.sof}\n")
        log.write("[with_eval_programmer] quartus_pgm will stay open during the test command\n")

        pgm = subprocess.Popen(
            ["quartus_pgm", f"--cable={args.cable}", "-m", "jtag", "-o", f"p;{args.sof}"],
            cwd=str(args.workdir),
            env=env_with_tools(),
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=0,
        )
        thread = threading.Thread(target=reader, daemon=True)
        thread.start()

        deadline = time.monotonic() + args.program_timeout
        while time.monotonic() < deadline:
            if prompt_seen.is_set():
                break
            if pgm.poll() is not None:
                raise RuntimeError(f"quartus_pgm exited before eval prompt, rc={pgm.returncode}")
            time.sleep(0.1)
        if not prompt_seen.is_set():
            raise RuntimeError(f"timed out waiting for eval prompt: {args.prompt!r}")

        log.write("\n[with_eval_programmer] Eval prompt detected; programmer remains open\n")
        if args.jtag_clock:
            rc = run_streamed(["jtagconfig", "--setparam", args.cable, "JtagClock", args.jtag_clock], args.workdir, log)
            if rc != 0:
                return rc
        rc = run_streamed(command, args.workdir, log)
        return rc
    except KeyboardInterrupt:
        log.write("\n[with_eval_programmer] interrupted\n")
        return 130
    except Exception as exc:
        log.write(f"\n[with_eval_programmer] ERROR {exc}\n")
        return 1
    finally:
        if pgm is not None and pgm.poll() is None:
            log.write("\n[with_eval_programmer] Closing eval prompt with q after test completion\n")
            try:
                assert pgm.stdin is not None
                pgm.stdin.write("q\n")
                pgm.stdin.flush()
                pgm.wait(timeout=15)
            except Exception as exc:
                log.write(f"[with_eval_programmer] quartus_pgm cleanup warning: {exc}\n")
                pgm.terminate()
        log.close()


if __name__ == "__main__":
    raise SystemExit(main())
