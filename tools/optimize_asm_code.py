# optimize_asm_code.py
#
# Master script to invoke each child optimization script’s run_optimization function directly,
# by importing them from tools/optimization. It sums up total ROM bytes saved and execution time.
#
# Usage:
#   python optimize_asm_code.py              -> runs silently
#   python optimize_asm_code.py --verbose    -> prints each script’s output, separated by blank lines
#   python optimize_asm_code.py --full-output -> shows every child’s detailed output (as if each child had --full-output)

import sys
import time
import importlib.util
import io
from contextlib import redirect_stdout
from pathlib import Path

# Demande de confirmation
print(
    "Before executing this, commit your changes.\n"
    "So you can easily check what has been done, "
    "and discard if needed.\nAre you ready? (Y/n)"
)
response = input().strip().lower()
if response not in ('', 'y', 'yes'):
    print("Aborted.")
    sys.exit(0)

start_time = time.time()
verbose = '--verbose' in sys.argv
full_output_flag = '--full-output' in sys.argv

# Répertoire du script master (tools/)
script_dir = Path(__file__).resolve().parent
# Le dossier où se trouvent les scripts enfants
optimization_dir = script_dir / 'optimization'
# Base_path à passer aux enfants : parent de tools/ (racine du projet)
project_root = script_dir.parent

# Recherche de tous les scripts .py (hors dossier IGNORE et hors lui-même)
scripts = [
    p for p in optimization_dir.rglob('*.py')
    if 'IGNORE' not in p.parts and p.name != 'optimize_asm_code.py'
]

total_bytes_saved = 0

for script_path in scripts:
    script_name = script_path.stem  # ex: "optimize_call_ret"

    # Import dynamique du module depuis son chemin
    spec = importlib.util.spec_from_file_location(script_name, str(script_path))
    module = importlib.util.module_from_spec(spec)
    try:
        spec.loader.exec_module(module)
    except Exception as e:
        print(f"Error importing {script_name}: {e}")
        continue

    # Vérifie que le module dispose de run_optimization
    if not hasattr(module, 'run_optimization'):
        print(f"Skipping {script_name}: no run_optimization() found.")
        continue

    # Arguments à passer : full_output et base_path (= racine du projet pour scanner tous les .asm)
    kwargs = {
        'full_output': full_output_flag,
        'base_path': str(project_root)
    }

    # Déterminer si on doit afficher la sortie de l’enfant :
    # Afficher si on est en --verbose, OU si on est en --full-output
    show_child_output = verbose or full_output_flag

    if show_child_output:
        # Affiche un en-tête pour chaque script
        print(f"\n====== {script_name} ======")
        try:
            bytes_saved = module.run_optimization(**kwargs)
        except Exception as e:
            print(f"Error executing {script_name}: {e}")
            continue
    else:
        # On supprime toute sortie STDOUT du script enfant
        buf = io.StringIO()
        try:
            with redirect_stdout(buf):
                bytes_saved = module.run_optimization(**kwargs)
        except Exception as e:
            print(f"Error executing {script_name}: {e}")
            continue
        # On jette buf.getvalue()

    # Accumule la valeur renvoyée (bytes_saved) si c'est un entier
    try:
        total_bytes_saved += int(bytes_saved)
    except Exception:
        pass

elapsed_time_ms = int((time.time() - start_time) * 1000)

# Bilan final
print("\n")
print("#####################")
print("###### SUMMARY ######")
print("#####################")
print(f"~{total_bytes_saved} ROM bytes saved in {elapsed_time_ms} ms.")
print("(actual gain may vary due to edits being made in unincluded files, conditional compilation, etc.)")
