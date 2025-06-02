# optimize_address_to_sp.py
#
# Optimizes known patterns that load an address into HL and move it to SP.
# Replaces the sequence with a direct SP load followed by "pop hl" and "ld sp, hl".
# Gains:
#   - Pattern 1: 4 bytes saved
#   - Patterns 2 & 3: 2 bytes saved
#
# Usage:
#   python optimize_address_to_sp.py          -> shows only the summary
#   python optimize_address_to_sp.py --full-output  -> also prints each file being optimized

import os
import re
import sys
import time
from pathlib import Path

# Optimizes a single .asm file for address-to-SP patterns.
# Input: Path to a .asm file
# Output: Number of bytes saved (int)
def optimize_address_to_sp(filepath):
    with open(filepath, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    optimized_lines = []
    i = 0
    modified = False
    patterns_optimized = 0
    bytes_saved = 0

    while i < len(lines) - 4:
        l1 = lines[i]
        l2 = lines[i + 1]
        l3 = lines[i + 2]
        l4 = lines[i + 3]
        l5 = lines[i + 4]

        # Pattern 1: ld a, [wX] + ld l, a + ld a, [wX+1] + ld h, a + ld sp, hl
        m1 = re.match(r'(\s*)ld\s+a,\s*\[(\w+)\](\s*;.*)?$', l1, re.IGNORECASE)
        if m1:
            indent = m1.group(1)
            label = m1.group(2)
            if (re.match(r'\s*ld\s+l,\s*a', l2, re.IGNORECASE) and
                re.match(rf'\s*ld\s+a,\s*\[{label}\+1\]', l3, re.IGNORECASE) and
                re.match(r'\s*ld\s+h,\s*a', l4, re.IGNORECASE) and
                re.match(r'\s*ld\s+sp,\s+hl', l5, re.IGNORECASE)):

                optimized_lines.append(f"{indent}ld sp, {label}\n")
                optimized_lines.append(f"{indent}pop hl\n")
                optimized_lines.append(f"{indent}ld sp, hl\n")
                i += 5
                modified = True
                patterns_optimized += 1
                bytes_saved += 4
                continue

        # Pattern 2: ldh a, [hX] + ld l, a + ldh a, [hX+1] + ld h, a + ld sp, hl
        m2 = re.match(r'(\s*)ldh\s+a,\s*\[(\w+)\](\s*;.*)?$', l1, re.IGNORECASE)
        if m2:
            indent = m2.group(1)
            label = m2.group(2)
            if (re.match(r'\s*ld\s+l,\s*a', l2, re.IGNORECASE) and
                re.match(rf'\s*ldh\s+a,\s*\[{label}\+1\]', l3, re.IGNORECASE) and
                re.match(r'\s*ld\s+h,\s+a', l4, re.IGNORECASE) and
                re.match(r'\s*ld\s+sp,\s+hl', l5, re.IGNORECASE)):

                optimized_lines.append(f"{indent}ld sp, {label}\n")
                optimized_lines.append(f"{indent}pop hl\n")
                optimized_lines.append(f"{indent}ld sp, hl\n")
                i += 5
                modified = True
                patterns_optimized += 1
                bytes_saved += 2
                continue

        # Pattern 3: ld hl, label + ld a, [hli] + ld h, [hl] + ld l, a + ld sp, hl
        if re.match(r'(\s*)ld\s+hl,\s+(\w+)', l1, re.IGNORECASE):
            indent = re.match(r'(\s*)', l1).group(1)
            label = re.findall(r'ld\s+hl,\s+(\w+)', l1, re.IGNORECASE)[0]
            if (re.match(r'\s*ld\s+a,\s*\[hli\]', l2, re.IGNORECASE) and
                re.match(r'\s*ld\s+h,\s*\[hl\]', l3, re.IGNORECASE) and
                re.match(r'\s*ld\s+l,\s*a', l4, re.IGNORECASE) and
                re.match(r'\s*ld\s+sp,\s+hl', l5, re.IGNORECASE)):

                optimized_lines.append(f"{indent}ld sp, {label}\n")
                optimized_lines.append(f"{indent}pop hl\n")
                optimized_lines.append(f"{indent}ld sp, hl\n")
                i += 5
                modified = True
                patterns_optimized += 1
                bytes_saved += 2
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

    total_bytes_saved = 0
    total_patterns = 0
    files_modified = 0
    total_files = len(asm_files)

    for asm_file in asm_files:
        bytes_saved, patterns = optimize_address_to_sp(asm_file)
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
