Special::
; Run script special de.
	ld hl, SpecialsPointers
	add hl, de
	add hl, de
	add hl, de
	ld b, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, b
	rst FarCall
	ret

INCLUDE "data/events/special_pointers.asm"

UnusedDummySpecial:
	ret

SetPlayerPalette:
	ld a, [wScriptVar]
	ld d, a
	farcall _SetPlayerPalette
	ret

GameCornerPrizeMonCheckDex:
	ld a, [wScriptVar]
	dec a
	call CheckCaughtMon
	ret nz
	ld a, [wScriptVar]
	dec a
	call SetSeenAndCaughtMon
	call FadeToMenu
	ld a, [wScriptVar]
	ld [wNamedObjectIndex], a
	farcall NewPokedexEntry
	call ExitAllMenus
	ret

UnusedSetSeenMon:
	ld a, [wScriptVar]
	dec a
	call SetSeenMon
	ret

FindPartyMonAboveLevel:
	ld a, [wScriptVar]
	ld b, a
	farcall _FindPartyMonAboveLevel
	jr z, FoundNone
	jr FoundOne

FindPartyMonAtLeastThatHappy:
	ld a, [wScriptVar]
	ld b, a
	farcall _FindPartyMonAtLeastThatHappy
	jr z, FoundNone
	jr FoundOne

FindPartyMonThatSpecies:
	ld a, [wScriptVar]
	ld b, a
	farcall _FindPartyMonThatSpecies
	jr z, FoundNone
	jr FoundOne

FindPartyMonThatSpeciesYourTrainerID:
	ld a, [wScriptVar]
	ld b, a
	farcall _FindPartyMonThatSpeciesYourTrainerID
	jr z, FoundNone
	jr FoundOne

FoundOne:
	ld a, TRUE
	ld [wScriptVar], a
	ret

FoundNone:
	xor a
	ld [wScriptVar], a
	ret

NameRival:
	ld b, NAME_RIVAL
	ld de, wRivalName
	farcall _NamingScreen
	ld hl, wRivalName
	ld de, .DefaultName
	call InitName
	ret

.DefaultName:
	db "SILVER@"

NameRater:
	farcall _NameRater
	ret

OverworldTownMap:
	call FadeToMenu
	farcall _TownMap
	call ExitAllMenus
	ret

UnownPrinter:
	call FadeToMenu
	farcall _UnownPrinter
	call ExitAllMenus
	ret

DisplayLinkRecord:
	call FadeToMenu
	farcall _DisplayLinkRecord
	call ExitAllMenus
	ret

PlayersHousePC:
	xor a
	ld [wScriptVar], a
	farcall _PlayersHousePC
	ld a, c
	ld [wScriptVar], a
	ret

CheckMysteryGift:
	ld a, BANK(sMysteryGiftItem)
	call OpenSRAM
	ld a, [sMysteryGiftItem]
	and a
	jr z, .no
	inc a

.no
	ld [wScriptVar], a
	call CloseSRAM
	ret

GetMysteryGiftItem:
	ld a, BANK(sMysteryGiftItem)
	call OpenSRAM
	ld a, [sMysteryGiftItem]
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChange], a
	ld hl, wNumItems
	call ReceiveItem
	jr nc, .no_room
	xor a
	ld [sMysteryGiftItem], a
	call CloseSRAM
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
	call GetItemName
	ld hl, .ReceiveItemText
	call PrintText
	ld a, TRUE
	ld [wScriptVar], a
	ret

.no_room
	call CloseSRAM
	xor a
	ld [wScriptVar], a
	ret

.ReceiveItemText:
	text_far _ReceiveItemText
	text_end

BugContestJudging:
	farcall _BugContestJudging
	ld a, b
	ld [wScriptVar], a
	ret

MapRadio:
	ld a, [wScriptVar]
	ld e, a
	farcall PlayRadio
	ret

UnownPuzzle:
	call FadeToMenu
	farcall _UnownPuzzle
	ld a, [wSolvedUnownPuzzle]
	ld [wScriptVar], a
	call ExitAllMenus
	ret

SlotMachine:
	call CheckCoinsAndCoinCase
	ret c
	ld a, BANK(_SlotMachine)
	ld hl, _SlotMachine
	call StartGameCornerGame
	ret

CardFlip:
	call CheckCoinsAndCoinCase
	ret c
	ld a, BANK(_CardFlip)
	ld hl, _CardFlip
	call StartGameCornerGame
	ret

UnusedMemoryGame:
	call CheckCoinsAndCoinCase
	ret c
	ld a, BANK(_MemoryGame)
	ld hl, _MemoryGame
	call StartGameCornerGame
	ret

StartGameCornerGame:
	call FarQueueScript
	call FadeToMenu
	ld hl, wQueuedScriptBank
	ld a, [hli]
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	rst FarCall
	call ExitAllMenus
	ret

CheckCoinsAndCoinCase:
	ld hl, wCoins
	ld a, [hli]
	or [hl]
	jr z, .no_coins
	ld a, COIN_CASE
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr nc, .no_coin_case
	and a
	ret

.no_coins
	ld hl, .NoCoinsText
	jr .print

.no_coin_case
	ld hl, .NoCoinCaseText

.print
	call PrintText
	scf
	ret

.NoCoinsText:
	text_far _NoCoinsText
	text_end

.NoCoinCaseText:
	text_far _NoCoinCaseText
	text_end

ClearBGPalettesBufferScreen:
	call ClearBGPalettes
	call BufferScreen
	ret

ScriptReturnCarry:
	jr c, .carry
	xor a
	ld [wScriptVar], a
	ret
.carry
	ld a, 1
	ld [wScriptVar], a
	ret

UnusedCheckUnusedTwoDayTimer:
	farcall CheckUnusedTwoDayTimer
	ld a, [wUnusedTwoDayTimer]
	ld [wScriptVar], a
	ret

ActivateFishingSwarm:
	ld a, [wScriptVar]
	ld [wFishingSwarmFlag], a
	ret

StoreSwarmMapIndices::
	ld a, c
	and a
	jr nz, .yanma
; swarm dark cave violet entrance
	ld a, d
	ld [wDunsparceMapGroup], a
	ld a, e
	ld [wDunsparceMapNumber], a
	ret

.yanma
	ld a, d
	ld [wYanmaMapGroup], a
	ld a, e
	ld [wYanmaMapNumber], a
	ret

SearchCriticallyIllMonInParty:
	farcall _SearchCriticallyIllMonInParty
	ret

CheckMildIllness: ; Only called by the nurse.
; Check if a monster in your party has Pokerus with a 1 bit strain.
	farcall _CheckMildIllness
	jp ScriptReturnCarry

CheckPokerus: ; Only called by the nurse.
	farcall _CheckPokerus
	jp ScriptReturnCarry

ResetLuckyNumberShowFlag:
	farcall LoadOrRegenerateLuckyIDNumber
	ret

CheckLuckyNumberShowFlag:
	ld hl, wLuckyNumberShowFlag
	bit LUCKYNUMBERSHOW_GAME_OVER_F, [hl]
	ret

SnorlaxAwake:
; Check if the Poké Flute channel is playing, and if the player is standing
; next to Snorlax.

; outputs:
; wScriptVar is 1 if the conditions are met, otherwise 0.

; check background music
	ld a, [wMapMusic]
	cp MUSIC_POKE_FLUTE_CHANNEL
	jr nz, .nope

	ld a, [wXCoord]
	ld b, a
	ld a, [wYCoord]
	ld c, a

	ld hl, .ProximityCoords
.loop
	ld a, [hli]
	cp -1
	jr z, .nope
	cp b
	jr nz, .nextcoord
	ld a, [hli]
	cp c
	jr nz, .loop

	ld a, TRUE
	jr .done

.nextcoord
	inc hl
	jr .loop

.nope
	xor a
.done
	ld [wScriptVar], a
	ret

.ProximityCoords:
	;   x,  y
	db 33,  8 ; left
	db 34, 10 ; below
	db 35, 10 ; below
	db 36,  8 ; right
	db 36,  9 ; right
	db -1

PlayCurMonCry:
	ld a, [wCurPartySpecies]
	jp PlayMonCry

GameboyCheck:
	ldh a, [hCGB]
	and a
	jr nz, .cgb
	ldh a, [hSGB]
	and a
	jr nz, .sgb
; gb
	xor a ; GBCHECK_GB
	jr .done

.sgb
	ld a, GBCHECK_SGB
	jr .done

.cgb
	ld a, GBCHECK_CGB
.done
	ld [wScriptVar], a
	ret

FadeOutMusic:
	ld a, LOW(MUSIC_NONE)
	ld [wMusicFadeID], a
	ld a, HIGH(MUSIC_NONE)
	ld [wMusicFadeID + 1], a
	ld a, $2
	ld [wMusicFade], a
	ret

Diploma:
	call FadeToMenu
	farcall _Diploma
	call ExitAllMenus
	ret

PrintDiploma:
	call FadeToMenu
	farcall _PrintDiploma
	call ExitAllMenus
	ret

TrainerHouse:
	ld a, BANK(sMysteryGiftTrainerHouseFlag)
	call OpenSRAM
	ld a, [sMysteryGiftTrainerHouseFlag]
	ld [wScriptVar], a
	jp CloseSRAM

GetHospitalRoomNumber:
	farcall _GetHospitalRoomNumber
	ret

GetQuantityOfHospitalizedMons:
	farcall _GetQuantityOfHospitalizedMons
	ret

CountHospitalMonsReadyToLeave:
	farcall _CountHospitalMonsReadyToLeave
	ret

CountHospitalMonsReadyToLeave2:
	farcall _CountHospitalMonsReadyToLeave2
	ret

RetrieveFirstMonFromHospitalBox:
	farcall _RetrieveFirstMonFromHospitalBox
	ret

HospitalVisitHappinessGain:
	farcall _HospitalVisit
	ret

GetItemNameFromIndex:
	call GetItemName
	ret

GetPartyCountWithoutEggs::
	push hl
	push de

	ld a, [wPartyCount]
	ld e, a ; E will be the return value.

	ld a, [wPartyCount]
	ld d, a
	xor a
	ld hl, wPartySpecies

.loop
	cp d
	jr nc, .end_loop

	push af
	ld a, [hl]
	cp EGG
	jr nz, .go_on

	dec e

.go_on
	pop af
	
	inc a
	inc hl
	jr .loop

.end_loop
	ld a, e
	ld [wScriptVar], a

	pop de
	pop hl
	ret

; Output: the vaccination status in [wScriptVar], and the selected mon in [wCurPartyMon].
SelectMonToVaccinate::
	push bc
	push de

	farcall SelectMonFromParty
	ld b, VACCINATION_CANCEL
	jr c, .return

	ld a, [wCurPartySpecies]
	cp EGG
	ld b, VACCINATION_IS_EGG
	jr z, .return

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1PokerusStatus
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, [hl]

	ld a, d
	and POKERUS_INVERSED_DURATION_MASK
	swap a
	ld b, VACCINATION_NEVER_GOT_COVID
	jr z, .return
	cp 1
	jr z, .got_1_or_2_shots

	; At this point, we know the Pokémon has never been vaccinated, and that he had has a non-zero strain in its pokerus status.
	; Which means it had or has COVID/sickness.

	ld a, d
	and POKERUS_DURATION_MASK
	cp POKERUS_IMMUNITY_DURATION + 1
	;ld b, VACCINATION_PREVIOUSLY_GOT_COVID
	jr c, .doesnt_have_symptoms_at_the_moment

	cp POKERUS_SYMPTOMS_START + 1
	jr nc, .doesnt_have_symptoms_at_the_moment

	; At this point, we determined that the Pokémon is currently sick (whether it's COVID or a mild illness).
	ld b, VACCINATION_CURRENTLY_SICK
	jr .return

.doesnt_have_symptoms_at_the_moment

	push de
	ld de, IsMildIllnessStrain
 	ld a, BANK(IsMildIllnessStrain)
 	call FarCall_de
 	pop de

	ld b, VACCINATION_NEVER_GOT_COVID ; Mild illnesses can only be caught until a Pokémon catches COVID. The Pokémon is then immune to mild illnesses for technical limitations. So we can infer that a Mon with a mild disease never got COVID.
	jr c, .return

	; There is only 1 last case to determine. If the Pokémon is currently incubating COVID, and has been tested positive, the Pokémon is considered sick by the doctor that vaccinates.

	ld a, d
	and POKERUS_TEST_MASK
	ld b, VACCINATION_PREVIOUSLY_GOT_COVID ; If the test bit isn't set, and a COVID strain is present, and no symptoms are present, either the Mon had covid in the past, or is currently incubating or within the immunity period without knowing it.
	jr z, .return

	; At this point we know the test bit is set.

	ld a, d
	and POKERUS_DURATION_MASK
	cp POKERUS_SYMPTOMS_START + 1
	ld b, VACCINATION_CURRENTLY_SICK
	jr nc, .return ; The Pokémon is incubating COVID, and has been tested positive, so the player knows it will have COVID. We consider the Pokémon sick.

	; In this case, the Pokémon has the status "IMMUNE".
	ld b, VACCINATION_PREVIOUSLY_GOT_COVID
	jr .return

.got_1_or_2_shots
	ld a, d
	and POKERUS_DURATION_MASK
	cp 2
	ld b, VACCINATION_GOT_FIRST_SHOT
	jr c, .return

	ld b, VACCINATION_FULLY_VACCINATED
	; fallthrough

.return
	ld a, b
	ld [wScriptVar], a

	pop de
	pop bc
	ret

; Output: 0/FALSE in wScriptVar if at least 1 mon in the party is not vaccinated, 1/TRUE otherwise.
IsWholeTeamVaccinated::
	xor a
	ld [wScriptVar], a ; FALSE.

	ld a, [wPartyCount]
	and a
	ret z ; Don't waste time on an empty party.
	ld c, a

	ld hl, wPartyMon1PokerusStatus
	ld de, PARTYMON_STRUCT_LENGTH

.loop
	ld a, [hl]
	and POKERUS_INVERSED_DURATION_MASK
	cp POKERUS_TEST_MASK
	ret nz

; next_mon
	add hl, de
	dec c
	jr nz, .loop

	ld a, 1
	ld [wScriptVar], a ; TRUE.
	ret

Vaccinate::
	farcall _Vaccinate
	ret

LoadSilphCoPokemonMoves::
	farcall _DisplaySilphCoPokemonMoves
	ret

SilphCo_SetMonAttributes::
	farcall _SilphCo_SetMonAttributes
	ret

SilphCo_GetTestSubjectProgress::
	farcall _SilphCo_GetTestSubjectProgress
	ret

SilphCo_GetTestSubjectHappiness::
	farcall _SilphCo_GetTestSubjectHappiness
	ret

SilphCo_GetTestSubjectLevel::
	farcall _SilphCo_GetTestSubjectLevel
	ret

SilphCo_TestSubjectRemovedFromParty::
	farcall _SilphCo_TestSubjectRemovedFromParty
	ret

SilphCo_PlayerGetsPropertyOfTestSubject::
	farcall _SilphCo_PlayerGetsPropertyOfTestSubject
	ret