; Applies special effects to some gym battles.
GymSpecialRules::
	ld a, [wOtherTrainerClass]
	cp BUGSY
	jr nz, .check_pryce
	ld hl, wPlayerScreens
	set SCREENS_STICKY_WEB, [hl]
	jr .exit

.check_pryce
.check_clair
.check_brock
.check_misty
.check_jasmine
.check_blue
.exit
	ret

; Check if all pokemons in the party are considered cute (non-evolved except if prior evolution is a baby pokemon, less than 1m/3"3' except for pink pkmn that can be up to 1.2m/3"11')
CheckCuteParty::
	ld a, 1
	ld [wScriptVar], a ; Sets the return value as TRUE.

	ld hl, wPartyMon1Species
	ld de, PARTYMON_STRUCT_LENGTH
	xor a
	ld [wCurPartyMon], a ; Récupération du premier Pokémon de l'équipe (index 0)

.analyze_mon
	ld a, [hl] ; Retrieving the species.
	push de
	push hl
	ld hl, CuteMons ; Getting the array address.
	call IsInByteArray ; Searching for pkmn a in array hl. Returns its index in b, and carry if found.
	pop hl
	pop de
	jr nc, .invalid_party_member

.next_party_mon
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	ret z ; We exit when we reach the last pkmn.

	ld [wCurPartyMon], a
	add hl, de
	jr .analyze_mon

.invalid_party_member
	call GetCurNickname
	ld hl, MonNotCuteText
	call PrintText
	ld a, 0
	ld [wScriptVar], a ; Set the return value as FALSE.
	ret

MonNotCuteText:
	text_far _MonNotCuteText
	text_end

INCLUDE "data/pokemon/cute.asm" ; Array of cute pokemons. Note: using an array is as fast and uses as much memory as coding the logic for a conditional check with the pokedex data.
