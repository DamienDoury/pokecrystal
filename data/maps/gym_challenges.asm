ChallengeNames:
; entries correspond to MapGroupPointers in data/maps/maps.asm
	table_width 2, ChallengeNames
	dw Challenge_Olivine		;  1
	dw Challenge_Mahogany		;  2
	dw Challenge_Dungeons		;  3
	dw Challenge_Ecruteak		;  4
	dw Challenge_Blackthorn		;  5
	dw Challenge_Cinnabar		;  6
	dw Challenge_Cerulean		;  7
	dw Challenge_Azalea			;  8
	dw Challenge_LakeOfRage		;  9
	dw Challenge_Violet			; 10
	dw Challenge_Goldenrod		; 11
	dw Challenge_Vermilion		; 12
	dw Challenge_Pallet			; 13
	dw Challenge_Pewter			; 14
	dw Challenge_FastShip		; 15
	dw Challenge_Indigo			; 16
	dw Challenge_Fuchsia		; 17
	dw Challenge_Lavender		; 18
	dw Challenge_Silver			; 19
	dw Challenge_CableClub		; 20
	dw Challenge_Celadon		; 21
	dw Challenge_Cianwood		; 22
	dw Challenge_Viridian		; 23
	dw Challenge_NewBark		; 24
	dw Challenge_Saffron		; 25
	dw Challenge_Cherrygrove	; 26
	assert_table_length NUM_MAP_GROUPS

; Johto
Challenge_Violet:      db "AERIAL BATTLE@"						
Challenge_Azalea:      db "STUCK IN A WEB@"												
Challenge_Goldenrod:   db "CUTE BATTLE@"		
Challenge_Ecruteak:    db "FACE FEAR@"						
Challenge_Cianwood:    db "ONE ON ONE@"						
Challenge_Olivine:     db "OUTNUMBERED@"			
Challenge_Mahogany:    db "HAIL@"											
Challenge_Blackthorn:  db "BRUT FORCE@"						

; Kanto
Challenge_Pewter:      db "SANDSTORM@"									
Challenge_Cerulean:    db "OCEAN STORM@"						
Challenge_Vermilion:   db "SUPERCHARGED@"		
Challenge_Celadon:     db "SPRING@"						
Challenge_Fuchsia:     db "LETHAL POISON@"								
Challenge_Saffron:     db "MIND BATTLE@"						
Challenge_Cinnabar:    db "HEATWAVE@"						
Challenge_Viridian:    db "ADAPTABILITY@"											

; Unused (no gym)
Challenge_Dungeons:	   
Challenge_LakeOfRage:
Challenge_Pallet:
Challenge_FastShip:
Challenge_Indigo:
Challenge_Lavender:
Challenge_Silver:
Challenge_CableClub:
Challenge_NewBark:
Challenge_Cherrygrove: db "???@"
