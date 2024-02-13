JohtoBadgePalettes::
    ld hl, .palettes
	ld bc, 8 palettes
	ld a, BANK(wOBPals1)
	call FarCopyWRAM
    ret

.palettes
    INCLUDE "gfx/trainer_card/johto_badges.pal"
    
KantoBadgePalettes::
    ld hl, .palettes
	ld bc, 8 palettes
	ld a, BANK(wOBPals1)
	call FarCopyWRAM
    ret

.palettes
    INCLUDE "gfx/trainer_card/kanto_badges.pal"