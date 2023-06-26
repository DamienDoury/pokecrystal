GetBreedMon1LevelGrowth:
	ld hl, wBreedMon1
	ld de, wTempMon
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	callfar CalcLevel
	ld a, [wBreedMon1Level]
	jr GetBreedMon2LevelGrowth.end

GetBreedMon2LevelGrowth:
	ld hl, wBreedMon2
	ld de, wTempMon
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	callfar CalcLevel
	ld a, [wBreedMon2Level]
.end
	ld b, a
	ld a, d
	ld e, a
	ld hl, wStringBuffer2 + 5
	ld [hl], a
	sub b
	ld d, a
	ret
