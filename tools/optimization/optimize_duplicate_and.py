# optimize_duplicate_and.py
#
# Removes redundant "and a" when it directly follows another "and XXX".
# Each replacement saves 1 ROM byte.
#
# Usage:
#   python optimize_duplicate_and.py          -> shows only the summary
#   python optimize_duplicate_and.py --full-output  -> also prints each file being optimized

import os
import re
import sys
import time
from pathlib import Path

# Optimize a single .asm file by removing redundant "and a" after another "and ...".
# Input: Path to .asm file
# Output: Number of bytes saved (int), number of patterns replaced (int)
def optimize_duplicate_and(filepath):
    with open(filepath, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    optimized_lines = []
    i = 0
    modified = False
    patterns_optimized = 0
    bytes_saved = 0

    while i < len(lines):
        if i < len(lines) - 1:
            m1 = re.match(r'\s*and\s+.+', lines[i], re.IGNORECASE)
            m2 = re.match(r'(\s*)and\s+a(\s*;.*)?$', lines[i + 1], re.IGNORECASE)
            if m1 and m2:
                # Skip the second line
                i += 2
                optimized_lines.append(lines[i - 2])
                modified = True
                patterns_optimized += 1
                bytes_saved += 1
                continue
        optimized_lines.append(lines[i])
        i += 1

    if modified:
        with open(filepath, 'w', encoding='utf-8') as file:
            file.writelines(optimized_lines)

    return bytes_saved, patterns_optimized

# Optimize all .asm files in the given folder.
# Input: folder_path (Path), full_output (bool)
# Output: total bytes saved (int)
def optimize_folder(folder_path, full_output=False):
    start_time = time.time()
    asm_files = list(Path(folder_path).rglob("*.asm"))
    if not asm_files and folder_path == Path("."):
        print("No .asm files found in current directory. Trying parent directory...")
        asm_files = list(Path("../").rglob("*.asm"))
        folder_path = Path("../")

    total_bytes_saved = 0
    total_patterns = 0
    files_modified = 0
    total_files = len(asm_files)

    for asm_file in asm_files:
        bytes_saved, patterns = optimize_duplicate_and(asm_file)
        if bytes_saved > 0:
            if full_output:
                print(f"Optimizing {asm_file}")
            total_bytes_saved += bytes_saved
            total_patterns += patterns
            files_modified += 1

    print(f"{total_files} asm files scanned.")
    print(f"{total_patterns} optimizations in {files_modified} files.")
    print(f"{total_bytes_saved} ROM bytes saved.")
    elapsed_time_ms = int((time.time() - start_time) * 1000)
    print(f"Execution time: {elapsed_time_ms} ms.")

    return total_bytes_saved

# Entry point for running from another script
# Input: full_output (bool)
# Output: total bytes saved (int)
def run_optimization(full_output=False, base_path=None):
    folder = Path(base_path) if base_path else Path('.')
    return optimize_folder(folder, full_output=full_output)

if __name__ == "__main__":
    full_output = '--full-output' in sys.argv
    run_optimization(full_output=full_output)
