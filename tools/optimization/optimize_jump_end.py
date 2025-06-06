# optimize_jump_end.py
#
# Removes an "end" line following any instruction whose name starts with "jump" or "sjump".
# Each removal saves 1 ROM byte.
#
# Usage:
#   python optimize_jump_end.py             -> shows only the summary
#   python optimize_jump_end.py --full-output  -> also prints each file being optimized
#
# The script scans all .asm files under the given folder (or "." by default), looking for the pattern:
#     <indent> (jump<...> | sjump<...>) Label    ; optional comment
#     end                                        ; optional comment
# where:
#   • The mnemonic begins with "jump" or "sjump" (case-insensitive), e.g. "jump", "jumpstd", "jumptext", "sjumpfar", etc.
#   • This mnemonic must appear as the first token on its line (aside from indentation).
#   • Label may start with a dot and may optionally end with a colon.
#   • The "end" line must contain only "end" (case-insensitive) plus an optional comment.
# When found, the "end" line is removed; the jump line is left intact.

import re
import sys
import time
from pathlib import Path

# Optimize a single .asm file by removing an "end" line immediately following a "jump..." or "sjump..." line.
# Input: filepath (Path)
# Output: Number of ROM bytes saved (int)
def optimize_jump_end_in_file(filepath):
    lines = filepath.read_text(encoding='utf-8').splitlines()
    optimized_lines = []
    modified = False
    bytes_saved = 0

    # Pattern to match an instruction whose name starts with "jump" or "sjump":
    #   ^(\s*)                       → capture indentation
    #   (?i:(?:sjump\w*|jump\w*))    → mnemonic starting with "sjump" or "jump" (case-insensitive)
    #   \s+([.\w]+:?)                → whitespace + Label (Label may start with . and may end with :)
    #   \s*(;.*)?$                   → optional comment
    jump_re = re.compile(
        r'^(\s*)(?i:(?:sjump\w*|jump\w*))\s+([.\w]+:?)\s*(;.*)?$',
        re.IGNORECASE
    )
    # Pattern to match a line that is exactly "end" (case-insensitive), possibly followed by a comment
    end_re = re.compile(r'^\s*end\s*(;.*)?$', re.IGNORECASE)

    i = 0
    while i < len(lines):
        line = lines[i]
        jm = jump_re.match(line)
        if jm and i + 1 < len(lines):
            # Peek at the next line
            next_line = lines[i + 1]
            if end_re.match(next_line):
                # Found pattern: remove the "end" line
                optimized_lines.append(line)  # keep the jump line intact
                modified = True
                bytes_saved += 1  # one byte saved per "end" removal
                i += 2  # skip both the jump line and the "end" line
                continue

        # Otherwise, copy current line as-is
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
        saved = optimize_jump_end_in_file(asm_file)
        if saved > 0:
            if full_output:
                print(f"Optimizing {asm_file}")
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
