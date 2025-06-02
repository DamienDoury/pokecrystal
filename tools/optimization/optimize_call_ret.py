# optimize_call_ret.py
#
# Replaces non-conditional 'call label' + 'ret' pairs with 'jp label' in .asm files.
# Each replacement saves 1 ROM byte.
#
# Usage:
#   python optimize_call_ret.py          -> shows only the summary
#   python optimize_call_ret.py --full-output  -> also prints each file being optimized

import os
import re
import sys
import time
from pathlib import Path

# Optimizes a single .asm file by replacing eligible call+ret pairs.
# Input: Path to a .asm file
# Output: Number of bytes saved (int)
def optimize_call_ret(filepath):
    with open(filepath, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    optimized_lines = []
    i = 0
    modified = False
    optimization_count = 0

    while i < len(lines):
        line = lines[i]
        call_match = re.match(r'(\s*)(call)\s+(?!z|nz|c|nc)(\w+)\s*(;.*)?$', line, re.IGNORECASE)
        if call_match and i + 1 < len(lines):
            next_line = lines[i + 1]
            ret_match = re.match(r'(\s*)(ret)\s*(;.*)?$', next_line, re.IGNORECASE)

            if ret_match:
                indent, _, func, comment1 = call_match.groups()
                _, _, comment2 = ret_match.groups()

                # Assemble the jp line with all comments
                new_comment = ''
                if comment1:
                    new_comment += comment1.strip()
                if comment2:
                    new_comment += ' ' + comment2.strip() if new_comment else comment2.strip()
                jp_line = f"{indent}jp {func}"
                if new_comment:
                    jp_line += f" ; {new_comment}"
                jp_line += "\n"

                optimized_lines.append(jp_line)
                i += 2
                modified = True
                optimization_count += 1
                continue

        optimized_lines.append(line)
        i += 1

    if modified:
        with open(filepath, 'w', encoding='utf-8') as file:
            file.writelines(optimized_lines)

    return optimization_count if modified else 0

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
        optimizations = optimize_call_ret(asm_file)
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
