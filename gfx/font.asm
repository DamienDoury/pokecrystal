Font:
if DEF(_FR_FR)
INCBIN "gfx/font/french_german.2bpp"
else
INCBIN "gfx/font/font.2bpp"
endc
    
FontExtra:
INCBIN "gfx/font/font_extra.2bpp"

FontBattleExtra:
if DEF(_FR_FR)
INCBIN "gfx/font/font_battle_extra_fr.2bpp"
else
INCBIN "gfx/font/font_battle_extra.2bpp"
endc

Frames:
INCBIN "gfx/frames/1.1bpp"
INCBIN "gfx/frames/2.1bpp"
INCBIN "gfx/frames/3.1bpp"
INCBIN "gfx/frames/4.1bpp"
INCBIN "gfx/frames/5.1bpp"
INCBIN "gfx/frames/6.1bpp"
INCBIN "gfx/frames/7.1bpp"
INCBIN "gfx/frames/8.1bpp"
INCBIN "gfx/frames/9.1bpp"

StatsScreenPageTilesGFX:
INCBIN "gfx/stats/stats_tiles.2bpp"

EnemyHPBarBorderGFX:
if DEF(_FR_FR)
INCBIN "gfx/battle/enemy_hp_bar_border_fr.1bpp"
else
INCBIN "gfx/battle/enemy_hp_bar_border.1bpp"
endc

HPExpBarBorderGFX:
INCBIN "gfx/battle/hp_exp_bar_border.1bpp"

ExpBarGFX:
INCBIN "gfx/battle/expbar.2bpp"

TownMapGFX:
INCBIN "gfx/pokegear/town_map.2bpp.lz"

UnusedWeekdayKanjiGFX: ; unreferenced
INCBIN "gfx/font/unused_weekday_kanji.2bpp"

PokegearPhoneIconGFX:
INCBIN "gfx/font/phone_icon.2bpp"

UnusedBoldFontGFX: ; unreferenced
INCBIN "gfx/font/unused_bold_font.1bpp"

TextboxSpaceGFX:
; StatsScreen_LoadTextboxSpaceGFX reads 2bpp; LoadFrame reads first half as 1bpp
INCBIN "gfx/font/space.2bpp"

FontsExtra_SolidBlackGFX:
INCBIN "gfx/font/black.1bpp"

UnusedUpArrowGFX: ; unreferenced
INCBIN "gfx/font/unused_up_arrow.1bpp"

MobilePhoneTilesGFX:
INCBIN "gfx/mobile/phone_tiles.2bpp"

MapEntryFrameGFX:
INCBIN "gfx/frames/map_entry_sign.2bpp"

FontsExtra2_UpArrowGFX:
INCBIN "gfx/font/up_arrow.2bpp"

INCLUDE "gfx/footprints.asm"
