#!/usr/bin/env python3
"""
tools/jmp_to_jr.py

This script iterates over the project and, for each file/line specified in the hardcoded list,
replaces the "jmp" macro with "jr" on that line. If the specified line does not contain "jmp",
it issues a warning and skips that line.

Usage (executed from project root):
    python tools/jmp_to_jr.py

The script determines the project root by assuming this file lives in the "tools" subfolder of the root.
All paths in the ENTRIES list are relative to the project root.
"""

import os
import sys

# ------------------------------------------------------------------------
# Hardcoded combined list of (relative_path, line_number) tuples
# ------------------------------------------------------------------------
ENTRIES = [
    ("engine/overworld/events.asm", 1169),
    ("engine/overworld/scripting.asm", 1308),
    ("engine/overworld/scripting.asm", 1455),
    ("engine/overworld/scripting.asm", 1491),
    ("engine/overworld/scripting.asm", 2270),
    ("engine/overworld/scripting.asm", 2278),
    ("engine/overworld/map_objects.asm", 2010),
    ("engine/overworld/map_objects.asm", 2377),
    ("engine/overworld/map_objects.asm", 2631),
    ("engine/menus/intro_menu.asm", 694),
    ("engine/pokemon/learn.asm", 132),
    ("engine/gfx/color.asm", 610),
    ("engine/battle/anim_hp_bar.asm", 206),
    ("engine/battle/anim_hp_bar.asm", 227),
    ("engine/pokemon/bills_pc_top.asm", 6),
    ("engine/items/item_effects.asm", 2111),
    ("engine/items/item_effects.asm", 2156),
    ("engine/items/item_effects.asm", 2735),
    ("engine/items/item_effects.asm", 2858),
    ("engine/items/item_effects.asm", 2872),
    ("engine/events/haircut.asm", 8),
    ("engine/overworld/time.asm", 40),
    ("engine/pokemon/mon_menu.asm", 204),
    ("engine/pokemon/mon_menu.asm", 231),
    ("engine/pokemon/mon_menu.asm", 425),
    ("engine/pokemon/mon_menu.asm", 1133),
    ("engine/events/elevator.asm", 187),
    ("engine/events/bug_contest/judging.asm", 155),
    ("engine/menus/save.asm", 123),
    ("engine/events/daycare.asm", 341),
    ("engine/pokemon/hospital.asm", 245),
    ("engine/overworld/decorations.asm", 657),
    ("engine/overworld/decorations.asm", 665),
    ("engine/overworld/decorations.asm", 673),
    ("engine/overworld/decorations.asm", 677),
    ("engine/overworld/decorations.asm", 681),
    ("engine/overworld/decorations.asm", 685),
    ("engine/overworld/decorations.asm", 689),
    ("engine/overworld/decorations.asm", 693),
    ("engine/overworld/decorations.asm", 697),
    ("engine/overworld/decorations.asm", 701),
    ("engine/overworld/decorations.asm", 1211),
    ("engine/link/link.asm", 826),
    ("engine/link/link.asm", 831),
    ("engine/movie/trade_animation.asm", 571),
    ("engine/movie/trade_animation.asm", 605),
    ("engine/movie/trade_animation.asm", 926),
    ("engine/movie/trade_animation.asm", 966),
    ("engine/link/link.asm", 1901),
    ("engine/link/link.asm", 1907),
    ("engine/overworld/wildmons.asm", 61),
    ("engine/overworld/wildmons.asm", 150),
    ("engine/overworld/wildmons.asm", 827),
    ("engine/battle/trainer_huds.asm", 9),
    ("engine/battle/trainer_huds.asm", 15),
    ("engine/events/gym.asm", 509),
    ("engine/battle/effect_commands.asm", 526),
    ("engine/battle/effect_commands.asm", 549),
    ("engine/battle/effect_commands.asm", 566),
    ("engine/battle/effect_commands.asm", 927),
    ("engine/battle/effect_commands.asm", 2775),
    ("engine/battle/move_effects/mirror_move.asm", 51),
    ("engine/battle/move_effects/metronome.asm", 40),
    ("engine/battle/effect_commands.asm", 7406),
    ("engine/battle/effect_commands.asm", 7527),
    ("engine/battle/ai/items.asm", 472),
    ("engine/battle/ai/items.asm", 478),
    ("engine/battle/ai/items.asm", 484),
    ("engine/battle/ai/items.asm", 490),
    ("engine/battle/ai/items.asm", 496),
    ("engine/battle/ai/items.asm", 502),
    ("engine/battle/ai/items.asm", 520),
    ("engine/battle/ai/items.asm", 528),
    ("engine/battle/ai/items.asm", 768),
    ("engine/battle/ai/items.asm", 775),
    ("engine/battle/ai/items.asm", 782),
    ("engine/battle/core.asm", 607),
    ("engine/battle/core.asm", 616),
    ("engine/battle/core.asm", 646),
    ("engine/battle/core.asm", 655),
    ("engine/battle/core.asm", 1139),
    ("engine/battle/core.asm", 1343),
    ("engine/battle/core.asm", 1411),
    ("engine/battle/core.asm", 1485),
    ("engine/battle/core.asm", 1541),
    ("engine/battle/core.asm", 1679),
    ("engine/battle/core.asm", 2710),
    ("engine/battle/core.asm", 3349),
    ("engine/battle/core.asm", 3354),
    ("engine/battle/core.asm", 4876),
    ("engine/battle/core.asm", 4885),
    ("engine/battle/core.asm", 5197),
    ("engine/battle/core.asm", 5258),
    ("engine/battle/core.asm", 6219),
    ("engine/battle/core.asm", 6226),
    ("engine/battle/core.asm", 7057),
    ("engine/pokedex/pokedex.asm", 803),
    ("mobile/mobile_12.asm", 1396),
    ("mobile/mobile_12.asm", 1723),
    ("mobile/mobile_12.asm", 1729),
    ("mobile/mobile_menu.asm", 88),
    ("mobile/mobile_menu.asm", 734),
    ("mobile/mobile_12_2.asm", 768),
    ("engine/pokemon/search2.asm", 3),
    ("engine/pokemon/search2.asm", 7),
    ("engine/pokemon/stats_screen.asm", 941),
    ("engine/events/poke_seer.asm", 35),
    ("engine/events/poke_seer.asm", 191),
    ("engine/pokemon/mon_stats.asm", 31),
    ("engine/pokemon/mon_stats.asm", 117),
    ("engine/pokemon/move_mon_wo_mail.asm", 63),
    ("engine/debug/color_picker.asm", 755),
    ("engine/printer/printer_serial.asm", 542),
    ("engine/printer/printer.asm", 660),
    ("engine/printer/printer.asm", 683),
    ("engine/printer/printer.asm", 699),
    ("engine/printer/printer.asm", 719),
    ("mobile/mobile_22.asm", 924),
    ("mobile/mobile_22.asm", 3070),
    ("engine/gfx/mon_icons.asm", 212),
    ("engine/gfx/mon_icons.asm", 353),
    ("engine/gfx/mon_icons.asm", 366),
    ("engine/phone/phone.asm", 26),
    ("engine/phone/phone.asm", 518),
    ("engine/phone/phone.asm", 573),
    ("engine/phone/phone.asm", 586),
    ("engine/pokegear/pokegear.asm", 1931),
    ("engine/games/slot_machine.asm", 680),
    ("engine/events/map_name_sign.asm", 150),
    ("engine/pokegear/radio.asm", 595),
    ("engine/pokegear/radio.asm", 607),
    ("engine/pokegear/radio.asm", 623),
    ("engine/pokemon/mail_2.asm", 682),
    ("engine/battle_anims/bg_effects.asm", 173),
    ("engine/battle_anims/bg_effects.asm", 181),
    ("engine/battle_anims/bg_effects.asm", 645),
    ("engine/battle_anims/bg_effects.asm", 671),
    ("engine/battle_anims/bg_effects.asm", 2439),
    ("engine/battle_anims/bg_effects.asm", 2468),
    ("engine/battle_anims/core.asm", 20),
    ("engine/battle_anims/functions.asm", 1839),
    ("engine/battle_anims/functions.asm", 4107),
    ("engine/battle_anims/functions.asm", 4121),
    ("engine/gfx/pic_animation.asm", 10),
    ("engine/gfx/pic_animation.asm", 15),
    ("engine/gfx/pic_animation.asm", 20),
    ("engine/gfx/pic_animation.asm", 25),
    ("engine/gfx/pic_animation.asm", 30),
    ("engine/gfx/pic_animation.asm", 35),
    ("engine/gfx/pic_animation.asm", 40),
    ("engine/gfx/pic_animation.asm", 381),
    ("engine/games/card_flip.asm", 965),
    ("engine/games/card_flip.asm", 972),
    ("engine/games/card_flip.asm", 977),
    ("engine/games/card_flip.asm", 1230),
    ("engine/games/card_flip.asm", 1237),
    ("engine/movie/intro.asm", 319),
    ("mobile/mobile_40.asm", 275),
    ("mobile/mobile_40.asm", 282),
    ("mobile/mobile_40.asm", 286),
    ("mobile/mobile_40.asm", 295),
    ("mobile/mobile_40.asm", 983),
    ("mobile/mobile_40.asm", 1415),
    ("mobile/mobile_40.asm", 1425),
    ("mobile/mobile_40.asm", 2175),
    ("mobile/mobile_40.asm", 6161),
    ("mobile/mobile_40.asm", 6167),
    ("mobile/mobile_40.asm", 6173),
    ("mobile/mobile_40.asm", 6179),
    ("mobile/mobile_40.asm", 6185),
    ("mobile/mobile_40.asm", 6624),
    ("mobile/mobile_40.asm", 6816),
    ("mobile/mobile_40.asm", 6860),
    ("mobile/mobile_40.asm", 6980),
    ("mobile/mobile_40.asm", 7016),
    ("engine/gfx/dma_transfer.asm", 132),
    ("engine/gfx/dma_transfer.asm", 145),
    ("engine/gfx/dma_transfer.asm", 177),
    ("engine/gfx/dma_transfer.asm", 198),
    ("engine/overworld/warp_connection.asm", 98),
    ("engine/overworld/warp_connection.asm", 123),
    ("mobile/mobile_41.asm", 318),
    ("mobile/mobile_41.asm", 323),
    ("mobile/mobile_41.asm", 1045),
    ("mobile/mobile_42.asm", 14),
    ("mobile/mobile_42.asm", 34),
    ("mobile/mobile_42.asm", 53),
    ("mobile/mobile_42.asm", 69),
    ("mobile/mobile_42.asm", 82),
    ("mobile/mobile_42.asm", 1236),
    ("mobile/mobile_42.asm", 1256),
    ("mobile/mobile_45.asm", 3700),
    ("mobile/mobile_45_sprite_engine.asm", 352),
    ("mobile/mobile_45_2.asm", 270),
    ("mobile/mobile_45_2.asm", 291),
    ("mobile/mobile_45_stadium.asm", 509),
    ("mobile/mobile_46.asm", 1302),
    ("mobile/mobile_46.asm", 1329),
    ("mobile/mobile_46.asm", 2169),
    ("mobile/mobile_46.asm", 2718),
    ("mobile/mobile_46.asm", 3366),
    ("mobile/mobile_46.asm", 5947),
    ("mobile/mobile_46.asm", 6050),
    ("mobile/mobile_46.asm", 6465),
    ("mobile/mobile_46.asm", 6586),
    ("mobile/mobile_46.asm", 6785),
    ("mobile/fixed_words.asm", 31),
    ("mobile/fixed_words.asm", 39),
    ("mobile/mobile_5b.asm", 94),
    ("mobile/mobile_5b.asm", 103),
    ("mobile/mobile_5b.asm", 536),
    ("mobile/mobile_5b.asm", 613),
    ("mobile/mobile_5b.asm", 693),
    ("engine/events/battle_tower/battle_tower.asm", 183),
    ("mobile/mobile_5e.asm", 219),
    ("mobile/mobile_5e.asm", 531),
    ("mobile/mobile_5e.asm", 543),
    ("mobile/mobile_5e.asm", 566),
    ("mobile/mobile_5e.asm", 591),
    ("mobile/mobile_5e.asm", 788),
    ("mobile/mobile_5f.asm", 2842),
    ("mobile/mobile_5f.asm", 3189),
    ("mobile/mobile_5f.asm", 3196),
    ("engine/overworld/viridian_warp.asm", 273),
    ("home/time.asm", 188),
    ("home/serial.asm", 163),
    ("home/text.asm::print_name", 311),
    ("home/text.asm::print_name", 311),
    ("home/text.asm::print_name", 311),
    ("home/menu.asm", 27),
    ("home/map.asm", 408),
    ("home/map.asm", 415),
    ("home/map.asm", 453),
    ("home/map.asm", 2129),
    ("home/window.asm", 59),
    ("home/pokemon.asm", 121),
    ("home/pokemon.asm", 134),
    ("home/mobile.asm", 137),
    ("home/mobile.asm", 161),
    ("audio/engine.asm", 1913),
    ("audio/engine.asm", 1992),
    ("home/serial.asm", 305),
    ("home/text.asm", 206),
    ("home/movement.asm", 105),
    ("home/menu.asm", 333),
    ("home/menu.asm", 348),
    ("engine/events/specials.asm", 291),
    ("engine/items/item_effects.asm", 1814),
    ("engine/items/item_effects.asm", 1822),
    ("engine/overworld/time.asm", 97),
    ("engine/pokemon/mon_menu.asm", 766),
    ("engine/pokemon/mon_menu.asm", 841),
    ("engine/pokemon/mon_menu.asm", 854),
    ("engine/pokemon/mon_menu.asm", 869),
    ("engine/battle/everstone_effect.asm", 35),
    ("engine/rtc/rtc.asm", 101),
    ("engine/overworld/decorations.asm", 218),
    ("engine/overworld/decorations.asm", 236),
    ("engine/overworld/decorations.asm", 254),
    ("engine/overworld/decorations.asm", 271),
    ("engine/overworld/decorations.asm", 289),
    ("engine/items/tmhm.asm", 237),
    ("engine/battle/core.asm", 5487),
    ("engine/events/lockdown_wanted.asm", 226),
    ("mobile/mobile_menu.asm", 99),
    ("mobile/mobile_menu.asm", 324),
    ("mobile/mobile_menu.asm", 745),
    ("engine/pokemon/stats_screen.asm", 162),
    ("engine/pokemon/stats_screen.asm", 166),
    ("engine/pokemon/stats_screen.asm", 179),
    ("engine/pokemon/stats_screen.asm", 193),
    ("engine/pokemon/stats_screen.asm", 243),
    ("engine/events/poke_seer.asm", 236),
    ("engine/overworld/variables.asm", 74),
    ("engine/overworld/variables.asm", 81),
    ("engine/overworld/variables.asm", 88),
    ("engine/printer/printer_serial.asm", 63),
    ("engine/printer/printer_serial.asm", 495),
    ("engine/printer/printer_serial.asm", 500),
    ("engine/printer/printer_serial.asm", 505),
    ("engine/printer/printer_serial.asm", 510),
    ("engine/printer/printer_serial.asm", 515),
    ("engine/printer/printer_serial.asm", 549),
    ("engine/printer/printer_serial.asm", 554),
    ("engine/printer/printer_serial.asm", 560),
    ("mobile/mobile_22.asm", 131),
    ("mobile/mobile_22.asm", 466),
    ("mobile/mobile_22.asm", 1673),
    ("mobile/mobile_22.asm", 2232),
    ("engine/battle/battle_transition.asm", 269),
    ("engine/phone/phone.asm", 436),
    ("engine/phone/phone.asm", 440),
    ("engine/pokegear/pokegear.asm", 1291),
    ("engine/games/slot_machine.asm", 939),
    ("engine/games/slot_machine.asm", 980),
    ("engine/battle_anims/bg_effects.asm", 2628),
    ("engine/battle_anims/functions.asm", 1933),
    ("engine/movie/splash.asm", 164),
    ("mobile/mobile_40.asm", 1767),
    ("mobile/mobile_40.asm", 1779),
    ("mobile/mobile_40.asm", 3255),
    ("mobile/mobile_40.asm", 3260),
    ("mobile/mobile_40.asm", 3268),
    ("mobile/mobile_40.asm", 3273),
    ("mobile/mobile_40.asm", 7065),
    ("engine/link/mystery_gift.asm", 898),
    ("mobile/mobile_45.asm", 197),
    ("mobile/mobile_5b.asm", 662),
    ("engine/movie/credits.asm", 192),
    ("engine/movie/credits.asm", 211),
    ("engine/movie/credits.asm", 225),
    ("engine/overworld/scripting.asm", 955),
    ("engine/overworld/scripting.asm", 1413),
    ("engine/overworld/scripting.asm", 1449),
    ("engine/overworld/scripting.asm", 1802),
]

def main():
    # Determine project root by assuming this script resides in "tools/"
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.abspath(os.path.join(script_dir, os.pardir))

    # Group entries by file path to minimize file opens
    file_to_lines = {}
    for rel_path, line_no in ENTRIES:
        file_to_lines.setdefault(rel_path, []).append(line_no)

    total_replacements = 0
    warnings = []
    errors = []

    for rel_path, line_numbers in file_to_lines.items():
        full_path = os.path.join(project_root, rel_path)

        if not os.path.isfile(full_path):
            errors.append(f"File not found: {rel_path}")
            continue

        try:
            with open(full_path, "r", encoding="utf-8") as f:
                lines = f.readlines()
        except Exception as e:
            errors.append(f"Could not read {rel_path}: {e}")
            continue

        file_modified = False
        for lineno in line_numbers:
            idx = lineno - 1
            if 0 <= idx < len(lines):
                if "jmp" in lines[idx]:
                    lines[idx] = lines[idx].replace("jmp", "jr")
                    file_modified = True
                    total_replacements += 1
                else:
                    warnings.append(
                        f"Warning: 'jmp' not found on line {lineno} of {rel_path}; skipping."
                    )
            else:
                errors.append(f"Line {lineno} out of range in {rel_path}")

        if file_modified:
            try:
                with open(full_path, "w", encoding="utf-8") as f:
                    f.writelines(lines)
            except Exception as e:
                errors.append(f"Could not write {rel_path}: {e}")

    # Output summary
    print(f"Completed: {total_replacements} replacements made.")
    if warnings:
        print("\nWarnings:")
        for msg in warnings:
            print("  -", msg)
    if errors:
        print("\nErrors:")
        for msg in errors:
            print("  -", msg)


if __name__ == "__main__":
    main()
