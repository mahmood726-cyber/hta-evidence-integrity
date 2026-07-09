"""Pytest contract for the manuscript numerical verification script."""

import subprocess
import sys
from pathlib import Path


def test_manuscript_numbers_verify_against_pipeline_outputs():
    repo_root = Path(__file__).resolve().parents[1]
    verifier = repo_root / "tests" / "verify_manuscript_numbers.py"

    proc = subprocess.run(
        [sys.executable, str(verifier)],
        cwd=repo_root,
        capture_output=True,
        text=True,
        timeout=60,
    )

    assert proc.returncode == 0, proc.stdout + proc.stderr
    assert "40/40 PASS" in proc.stdout
    assert "ALL MANUSCRIPT NUMBERS VERIFIED SUCCESSFULLY" in proc.stdout
