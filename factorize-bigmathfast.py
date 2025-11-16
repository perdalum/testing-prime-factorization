#!/usr/bin/env python3
import sys
import subprocess
import re

JAR_PATH = "bigmathfast-1.0-jar-with-dependencies.jar"
JAVA_CLASS = "dk.teg.bigmathfast.BigMathFast"

time_pattern = re.compile(r"Factorization time in millis:(\d+)")

def run_factorization(n_str: str) -> int:
    """Run the Java factorization and return the time in millis as int."""
    cmd = [
        "java",
        "-cp",
        JAR_PATH,
        JAVA_CLASS,
        n_str.strip()
    ]
    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        check=True
    )

    # Look for the time line in stdout
    match = time_pattern.search(result.stdout)
    if not match:
        # If you want to see what went wrong, uncomment the next line:
        # print(result.stdout, file=sys.stderr)
        raise RuntimeError("Could not find factorization time in output")

    return int(match.group(1))

def process_file(filename: str) -> None:
    with open(filename, "r") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue  # skip empty lines
            # Expect format: "<digits>, <integer>"
            try:
                digits_str, n_str = [part.strip() for part in line.split(",", 1)]
            except ValueError:
                print(f"Skipping malformed line: {line}", file=sys.stderr)
                continue

            try:
                time_ms = run_factorization(n_str)
            except Exception as e:
                print(f"Error processing {digits_str}, {n_str}: {e}", file=sys.stderr)
                continue

            print(f"{digits_str}\t{time_ms}")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        infile = sys.argv[1]
    else:
        infile = "primes.dat"
    process_file(infile)