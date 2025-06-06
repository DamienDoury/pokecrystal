# optimize_fallthrough_jmp.py
#
# Replaces unconditional jumps to the next label with a "; fallthrough." comment.
# Each 'jr' replacement saves 2 ROM bytes; each 'jp' or 'jmp' replacement saves 3 ROM bytes.
#
# Usage:
#   python optimize_fallthrough_jmp.py             -> shows only the summary
#   python optimize_fallthrough_jmp.py --full-output  -> also prints each file being optimized
#
# The script scans all .asm files under the given folder (or "." by default), looking for:
#   jmp|jp|jr Label    ; optional comment
#   [blank lines or comments only]
#   Label[:]
# where the Label is identical (it may start with a dot and may or may not end with a colon).
# When found, the jump line is replaced with:
#   [same indentation] ; fallthrough.[ optional original comment ]
#
# Conditional jumps (e.g. "jr z,Label", "jp c,Label") are ignored by checking for "z,", "nz,", "c,", or "nc," right after the mnemonic.

import re
import sys
import time
from pathlib import Path

# Optimize a single .asm file by replacing an unconditional jump to the next label with "; fallthrough."
# Input: filepath (Path)
# Output: Number of ROM bytes saved (int)
def optimize_fallthrough_jmp_in_file(filepath):
    lines = filepath.read_text(encoding='utf-8').splitlines()
    optimized_lines = []
    modified = False
    bytes_saved = 0

    # Pattern to match an unconditional jump: jmp, jp, or jr, not followed by z, nz, c, or nc plus a comma
    jump_re = re.compile(
        r'^(\s*)(?i:(jmp|jp|jr))\s+'      # indentation + jump mnemonic
        r'(?!z,|nz,|c,|nc,)([.\w]+)\s*'   # target label (no conditional suffix)
        r'(;.*)?$',                       # optional comment
        re.IGNORECASE
    )
    # Pattern to match a blank line or a line with only a comment
    empty_or_comment_re = re.compile(r'^\s*(;.*)?$')
    # Pattern to match a label line (with optional trailing colon and comment)
    label_re = re.compile(r'^\s*([.\w]+):?\s*(;.*)?$')

    i = 0
    while i < len(lines):
        line = lines[i]
        jm = jump_re.match(line)
        if jm:
            indent, mnemonic, target_label, comment = jm.groups()
            # Look ahead for the matching label, skipping blank/comment lines
            j = i + 1
            found_label = False
            while j < len(lines):
                next_line = lines[j]
                if empty_or_comment_re.match(next_line):
                    j += 1
                    continue
                lm = label_re.match(next_line)
                if lm and lm.group(1) == target_label:
                    found_label = True
                break

            if found_label:
                # Determine bytes saved: 2 for jr, 3 for jp/jmp
                saved = 2 if mnemonic.lower() == 'jr' else 3
                bytes_saved += saved

                # Replace the jump line with "; fallthrough."
                new_comment = "; fallthrough."
                if comment:
                    orig = comment.lstrip()
                    new_comment += " " + orig
                optimized_lines.append(f"{indent}{new_comment}")
                modified = True
                i += 1
                continue  # skip copying the original jump line

        # Otherwise, copy the line as-is
        optimized_lines.append(line)
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
        saved = optimize_fallthrough_jmp_in_file(asm_file)
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
