# optimize_add_a_to_16_bits_register.py
#
# Optimizes specific 16-bit register increment patterns using A, saving 1 byte per replacement.
# Supports HL, DE, and BC register pairs.
#
# Usage:
#   python optimize_add_a_to_16_bits_register.py          -> shows only the summary
#   python optimize_add_a_to_16_bits_register.py --full-output  -> also prints each file being optimized

import os
import re
import sys
import time
from pathlib import Path

# Optimizes a single .asm file by replacing specific add + ld + adc + ld sequences.
# Input: Path to a .asm file
# Output: Number of bytes saved (int)
def optimize_add16bit(filepath):
    with open(filepath, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    optimized_lines = []
    i = 0
    modified = False
    optimization_count = 0

    while i < len(lines) - 4:
        line1 = lines[i]
        line2 = lines[i + 1]
        line3 = lines[i + 2]
        line4 = lines[i + 3]
        line5 = lines[i + 4]

        match1 = re.match(r'(\s*)add\s+l(\s*;.*)?$', line1, re.IGNORECASE)
        match2 = re.match(r'\s*ld\s+l,\s*a(\s*;.*)?$', line2, re.IGNORECASE)

        # Match either ld a, 0 / adc h / ld h, a
        match_pattern1 = (
            re.match(r'\s*ld\s+a,\s*0(\s*;.*)?$', line3, re.IGNORECASE) and
            re.match(r'\s*adc\s+h(\s*;.*)?$', line4, re.IGNORECASE) and
            re.match(r'\s*ld\s+h,\s*a(\s*;.*)?$', line5, re.IGNORECASE)
        )

        # Match alternative: ld a, h / adc 0 / ld h, a
        match_pattern2 = (
            re.match(r'\s*ld\s+a,\s*h(\s*;.*)?$', line3, re.IGNORECASE) and
            re.match(r'\s*adc\s+0(\s*;.*)?$', line4, re.IGNORECASE) and
            re.match(r'\s*ld\s+h,\s*a(\s*;.*)?$', line5, re.IGNORECASE)
        )

        if match1 and match2 and (match_pattern1 or match_pattern2):
            indent = match1.group(1)

            # Determine register base (hl, de, bc)
            reg_base = 'hl'
            if re.search(r'\bde\b', ''.join(lines[i:i+5]), re.IGNORECASE):
                reg_base = 'de'
            elif re.search(r'\bbc\b', ''.join(lines[i:i+5]), re.IGNORECASE):
                reg_base = 'bc'

            reg_low = reg_base[1]
            reg_high = reg_base[0]

            # Rewrite optimized lines
            new_block = [
                line1,  # add l
                line2,  # ld l, a
                f"{indent}adc {reg_high}\n",
                f"{indent}sub {reg_low}\n",
                f"{indent}ld {reg_high}, a\n"
            ]

            optimized_lines.extend(new_block)
            i += 5
            modified = True
            optimization_count += 1
        else:
            optimized_lines.append(line1)
            i += 1

    # Append any remaining lines
    while i < len(lines):
        optimized_lines.append(lines[i])
        i += 1

    if modified:
        with open(filepath, 'w', encoding='utf-8') as file:
            file.writelines(optimized_lines)

    return optimization_count

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
        optimizations = optimize_add16bit(asm_file)
        if optimizations > 0:
            if full_output:
                print(f"Optimizing {asm_file}")
            total_optimizations += optimizations
            files_modified += 1

    print(f"{total_files} asm files scanned.")
    print(f"{total_optimizations} optimizations in {files_modified} files.")
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
