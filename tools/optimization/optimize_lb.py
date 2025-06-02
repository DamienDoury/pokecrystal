# optimize_lb.py
#
# Optimizes "ld reg, IMM" + "ld reg2, IMM" into "lb regpair, IMM, IMM" for bc, de, hl.
# Only applied when both values are constants (not registers).
# Each replacement saves 1 ROM byte.
#
# Usage:
#   python optimize_lb.py          -> shows only the summary
#   python optimize_lb.py --full-output  -> also prints each file being optimized

import os
import re
import sys
import time
from pathlib import Path

# Optimize a single .asm file by merging ld + ld into lb reg, x, y.
# Input: Path to .asm file
# Output: Number of bytes saved (int), number of patterns replaced (int)
def optimize_lb(filepath):
    with open(filepath, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    optimized_lines = []
    i = 0
    modified = False
    patterns_optimized = 0
    bytes_saved = 0

    valid_pairs = {
        frozenset(['b', 'c']): 'bc',
        frozenset(['d', 'e']): 'de',
        frozenset(['h', 'l']): 'hl'
    }

    while i < len(lines) - 1:
        l1 = lines[i]
        l2 = lines[i + 1]

        m1 = re.match(r'(\s*)ld\s+([bdhl]),\s*(#?\w+)(\s*;.*)?$', l1, re.IGNORECASE)
        m2 = re.match(r'\s*ld\s+([cehl]),\s*(#?\w+)(\s*;.*)?$', l2, re.IGNORECASE)

        if m1 and m2:
            indent1 = m1.group(1)
            r1 = m1.group(2).lower()
            v1 = m1.group(3)
            comment1 = m1.group(4).strip() if m1.group(4) else ""

            r2 = m2.group(1).lower()
            v2 = m2.group(2)
            comment2 = m2.group(3).strip() if m2.group(3) else ""

            regset = frozenset([r1, r2])
            if regset in valid_pairs and not re.match(r'^[a-z]$', v1, re.IGNORECASE) and not re.match(r'^[a-z]$', v2, re.IGNORECASE):
                regpair = valid_pairs[regset]
                # reorder to bc/de/hl order
                if regpair[0] == r1:
                    arg1, arg2 = v1, v2
                    cmt1, cmt2 = comment1, comment2
                else:
                    arg1, arg2 = v2, v1
                    cmt1, cmt2 = comment2, comment1
                combined_comment = " ; ".join(filter(None, [cmt1.lstrip(';').strip(), cmt2.lstrip(';').strip()]))
                comment_suffix = f" ; {combined_comment}" if combined_comment else ""
                optimized_lines.append(f"{indent1}lb {regpair}, {arg1}, {arg2}{comment_suffix}\n")
                i += 2
                modified = True
                patterns_optimized += 1
                bytes_saved += 1
                continue

        optimized_lines.append(l1)
        i += 1

    while i < len(lines):
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
        bytes_saved, patterns = optimize_lb(asm_file)
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
