# optimize_sla_l_rl_h.py
#
# Replaces 'sla l' followed by 'rl h' with 'add hl, hl' in .asm files.
# Each replacement saves 3 ROM bytes.
#
# Usage:
#   python optimize_sla_l_rl_h.py          -> shows only the summary
#   python optimize_sla_l_rl_h.py --full-output  -> also prints each file being optimized

import os
import re
import sys
import time
from pathlib import Path

# Optimizes a single .asm file by replacing 'sla l' + 'rl h' with 'add hl, hl'.
# Input: Path to a .asm file
# Output: Number of bytes saved (int)
def optimize_sla_l_rl_h(filepath):
    with open(filepath, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    optimized_lines = []
    i = 0
    modified = False
    optimization_count = 0

    while i < len(lines) - 1:
        line1 = lines[i]
        line2 = lines[i + 1]

        match1 = re.match(r'(\s*)sla\s+l(\s*;.*)?$', line1, re.IGNORECASE)
        match2 = re.match(r'(\s*)rl\s+h(\s*;.*)?$', line2, re.IGNORECASE)

        if match1 and match2:
            indent = match1.group(1)
            comment1 = match1.group(2)
            comment2 = match2.group(2)

            # Combine comments
            new_comment = ''
            if comment1:
                new_comment += comment1.strip()
            if comment2:
                new_comment += ' ' + comment2.strip() if new_comment else comment2.strip()

            new_line = f"{indent}add hl, hl"
            if new_comment:
                new_line += f" ; {new_comment}"
            new_line += "\n"

            optimized_lines.append(new_line)
            i += 2
            modified = True
            optimization_count += 3
        else:
            optimized_lines.append(line1)
            i += 1

    # Append last line if it wasn't processed
    if i < len(lines):
        optimized_lines.append(lines[i])

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
        optimizations = optimize_sla_l_rl_h(asm_file)
        if optimizations > 0:
            if full_output:
                print(f"Optimizing {asm_file}")
            total_optimizations += optimizations
            files_modified += 1

    print(f"{total_files} asm files scanned.")
    print(f"{total_optimizations // 3} optimizations in {files_modified} files.")
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
