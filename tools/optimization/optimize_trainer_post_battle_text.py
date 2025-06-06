# optimize_trainers_post_battle_text.py
#
# Replaces a six-line post-battle text sequence with a single jump instruction.
# Each replacement saves 4 ROM bytes.
#
# Usage:
#   python optimize_trainers_post_battle_text.py             -> shows only the summary
#   python optimize_trainers_post_battle_text.py --full-output  -> also prints each file being optimized
#
# The script scans all .asm files under the given folder (or "." by default), looking for the exact sequence:
#     endifjustbattled
#     opentext
#     writetext Label
#     waitbutton
#     closetext
#     end
# (Each line may have indentation and an optional comment. 
#  The Label may start with a dot and does not end with a colon.)
# When found, these six lines are replaced by:
#     endifjustbattled    [; original comment if present]
#     jumptextfaceplayer Label   [; original comment from writetext if present]
#
import re
import sys
import time
from pathlib import Path

# Optimize a single .asm file by replacing the six-line post-battle text pattern.
# Input: filepath (Path)
# Output: Number of ROM bytes saved (int)
def optimize_trainers_post_battle_text_in_file(filepath):
    lines = filepath.read_text(encoding='utf-8').splitlines()
    optimized_lines = []
    modified = False
    bytes_saved = 0

    # Patterns for each of the six lines, capturing indentation and optional comments
    line1_re = re.compile(r'^(\s*)(endifjustbattled)\s*(;.*)?$', re.IGNORECASE)
    line2_re = re.compile(r'^\s*(opentext)\s*(;.*)?$', re.IGNORECASE)
    line3_re = re.compile(r'^(\s*)(writetext)\s+([.\w]+)\s*(;.*)?$', re.IGNORECASE)
    line4_re = re.compile(r'^\s*(waitbutton)\s*(;.*)?$', re.IGNORECASE)
    line5_re = re.compile(r'^\s*(closetext)\s*(;.*)?$', re.IGNORECASE)
    line6_re = re.compile(r'^\s*(end)\s*(;.*)?$', re.IGNORECASE)

    i = 0
    while i < len(lines):
        m1 = line1_re.match(lines[i])
        if m1 and i + 5 < len(lines):
            # Tentatively match the next five lines
            m2 = line2_re.match(lines[i + 1])
            m3 = line3_re.match(lines[i + 2])
            m4 = line4_re.match(lines[i + 3])
            m5 = line5_re.match(lines[i + 4])
            m6 = line6_re.match(lines[i + 5])

            if m2 and m3 and m4 and m5 and m6:
                # Extract components
                indent1, _, comment1 = m1.groups()
                indent3, _, label, comment3 = m3.groups()

                # Build the two replacement lines
                # 1st line: keep "endifjustbattled" with its comment
                line_a = f"{indent1}endifjustbattled"
                if comment1:
                    line_a += f" {comment1.lstrip()}"
                # 2nd line: "jumptextfaceplayer Label" with writetext comment if any
                # Use indent of the writetext line (indent3); if none, match indent1
                chosen_indent = indent3 or indent1
                line_b = f"{chosen_indent}jumptextfaceplayer {label}"
                if comment3:
                    line_b += f" {comment3.lstrip()}"

                # Append replaced lines
                optimized_lines.append(line_a)
                optimized_lines.append(line_b)

                bytes_saved += 4
                modified = True
                i += 6
                continue

        # Otherwise, copy the line as-is
        optimized_lines.append(lines[i])
        i += 1

    if modified:
        filepath.write_text("\n".join(optimized_lines) + "\n", encoding='utf-8')

    return bytes_saved

# Optimize all .asm files under the given folder
# Input: folder_path (Path), full_output (bool)
# Output: total bytes saved (int)
def optimize_folder(folder_path, full_output=False):
    start_time = time.time()
    asm_files = list(Path(folder_path).rglob('*.asm'))
    if not asm_files and folder_path == Path('.'):
        asm_files = list(Path('..').rglob('*.asm'))
        folder_path = Path('..')

    total_bytes_saved = 0
    files_modified = 0
    total_files = len(asm_files)

    for asm_file in asm_files:
        saved = optimize_trainers_post_battle_text_in_file(asm_file)
        if saved > 0:
            if full_output:
                print(f"Optimizing {asm_file}")
                print(f"  Bytes saved in this file: {saved}")
            total_bytes_saved += saved
            files_modified += 1

    print(f"{total_files} asm files scanned.")
    print(f"{files_modified} files modified.")
    print(f"{total_bytes_saved} ROM bytes saved.")
    elapsed_time_ms = int((time.time() - start_time) * 1000)
    print(f"Execution time: {elapsed_time_ms} ms.")

    return total_bytes_saved

# Entry point for running the optimization from another script.
# Input: full_output (bool), base_path (str or None)
# Output: total bytes saved (int)
def run_optimization(full_output=False, base_path=None):
    folder = Path(base_path) if base_path else Path('.')
    return optimize_folder(folder, full_output=full_output)

if __name__ == '__main__':
    full_output = '--full-output' in sys.argv
    base_path = next((arg for arg in sys.argv[1:] if not arg.startswith('--')), None)
    sys.exit(run_optimization(full_output=full_output, base_path=base_path))
