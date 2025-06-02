# optimize_load_from_address_to_hl_lsb.py
#
# Optimizes patterns where HL is loaded from two memory addresses into a compact sequence.
# Each replacement saves 2 ROM bytes.
#
# Usage:
#   python optimize_load_from_address_to_hl_lsb.py          -> shows only the summary
#   python optimize_load_from_address_to_hl_lsb.py --full-output  -> also prints each file being optimized

import os
import re
import sys
import time
from pathlib import Path

# Optimizes a single .asm file by compacting memory-to-HL loads.
# Input: Path to a .asm file
# Output: Number of bytes saved (int)
def optimize_load_addr_hl(filepath):
    with open(filepath, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    optimized_lines = []
    i = 0
    modified = False
    optimization_count = 0

    while i < len(lines) - 3:
        line1 = lines[i]
        line2 = lines[i + 1]
        line3 = lines[i + 2]
        line4 = lines[i + 3]

        match1 = re.match(r'(\s*)ld[h]?\s+a,\s*\[(\w+)\](\s*;.*)?$', line1, re.IGNORECASE)
        match2 = re.match(r'\s*ld\s+l,\s*a(\s*;.*)?$', line2, re.IGNORECASE)

        if match1 and match2:
            indent = match1.group(1)
            addr = match1.group(2)

            pattern3 = rf'\s*ld[h]?\s+a,\s*\[{addr}\+1\](\s*;.*)?$'
            match3 = re.match(pattern3, line3, re.IGNORECASE)
            match4 = re.match(r'\s*ld\s+h,\s*a(\s*;.*)?$', line4, re.IGNORECASE)

            if match3 and match4:
                new_block = [
                    f"{indent}ld hl, {addr}\n",
                    f"{indent}ld a, [hli]\n",
                    f"{indent}ld h, [hl]\n",
                    f"{indent}ld l, a\n"
                ]

                optimized_lines.extend(new_block)
                i += 4
                modified = True
                optimization_count += 1
                continue

        optimized_lines.append(line1)
        i += 1

    while i < len(lines):
        optimized_lines.append(lines[i])
        i += 1

    if modified:
        with open(filepath, 'w', encoding='utf-8') as file:
            file.writelines(optimized_lines)

    return optimization_count * 2

# Optimizes all .asm files in the given folder (recursively).
# Input: folder_path (Path), full_output (bool) to print each optimized file
# Output: total bytes saved (int)
def optimize_folder(folder_path, full_output=False):
    start_time = time.time()
    asm_files = list(Path(folder_path).rglob('*.asm'))
    if not asm_files and folder_path == Path("."):
        print("No .asm files found in current directory. Trying parent directory...")
        asm_files = list(Path("../").rglob('*.asm'))
        folder_path = Path("../")

    total_optimizations = 0
    files_modified = 0
    total_files = len(asm_files)

    for asm_file in asm_files:
        optimizations = optimize_load_addr_hl(asm_file)
        if optimizations > 0:
            if full_output:
                print(f"Optimizing {asm_file}")
            total_optimizations += optimizations
            files_modified += 1

    print(f"{total_files} asm files scanned.")
    print(f"{total_optimizations // 2} optimizations in {files_modified} files.")
    print(f"{total_optimizations} ROM bytes saved.")
    elapsed_time_ms = int((time.time() - start_time) * 1000)
    print(f"Execution time: {elapsed_time_ms} ms.")

    return total_optimizations

# Entry point for running the optimization from another script.
# Input: full_output (bool)
# Output: total bytes saved (int)
def run_optimization(full_output=False, base_path=None):
    folder = Path(base_path) if base_path else Path('.')
    return optimize_folder(folder, full_output=full_output)

if __name__ == '__main__':
    full_output = '--full-output' in sys.argv
    base_path = next((arg for arg in sys.argv[1:] if not arg.startswith('--')), None)
    sys.exit(run_optimization(full_output=full_output, base_path=base_path))