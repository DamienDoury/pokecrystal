PlayRadioShow:
	ldh a, [hInMenu]
	and a
	jr z, .rockets_check

	push de
	push hl
	ld b, CHECK_FLAG
	ld de, EVENT_CINNABAR_RAVE_PARTY
	call EventFlagAction
	pop hl
	pop de
	ld a, c
	and a
	jr nz, .rave_party

; If we're already in the radio program proper, we don't need to be here.
.rockets_check
	ld a, [wCurRadioLine]
	cp POKE_FLUTE_RADIO
	jr nc, .ok
; If Team Rocket is not occupying the radio tower, we don't need to be here.
	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_ROCKETS_IN_RADIO_TOWER_F, a
	jr z, .ok
; If we're in Kanto, we don't need to be here.
	call IsInJohto
	and a
	jr nz, .ok
; Team Rocket broadcasts on all stations.
	ld a, ROCKET_RADIO
	ld [wCurRadioLine], a
.ok
; Jump to the currently loaded station.  The index to which we need to jump is in wCurRadioLine.
	jumptable RadioJumptable, wCurRadioLine

.rave_party
	ld hl, CantHearAThing_Text
	jp BuenaPrintText

CantHearAThing_Text:
if DEF(_FR_FR)
	text "- On n'entend"
	line "rien du tout! -"
else
	text "- You can't hear"
	line "a thing! -"
endc
	done

RadioJumptable:
	; entries correspond to constants/radio_constants.asm
	table_width 2, RadioJumptable
	dw OaksPKMNTalk1     ; $00
	dw PokedexShow1      ; $01
	dw BenMonMusic1      ; $02
	dw LuckyNumberShow1  ; $03
	dw BuenasPassword1   ; $04
	dw NewsRadio1        ; $05
	dw PeoplePlaces1     ; $06
	dw FernMonMusic1     ; $07
	dw RocketRadio1      ; $08
	dw PokeFluteRadio    ; $09
	dw UnownRadio        ; $0a
	dw EvolutionRadio    ; $0b
	assert_table_length NUM_RADIO_CHANNELS
; OaksPKMNTalk
	dw OaksPKMNTalk2     ; $0b
	dw OaksPKMNTalk3     ; $0c
	dw OaksPKMNTalk4     ; $0d
	dw OaksPKMNTalk5     ; $0e
	dw OaksPKMNTalk6     ; $0f
	dw OaksPKMNTalk7     ; $10
	dw OaksPKMNTalk8     ; $11
	dw OaksPKMNTalk9     ; $12
	dw PokedexShow2      ; $13
	dw PokedexShow3      ; $14
	dw PokedexShow4      ; $15
	dw PokedexShow5      ; $16
; Ben Music
	dw BenMonMusic2      ; $17
	dw BenMonMusic3      ; $18
	dw BenFernMusic4     ; $19
	dw BenFernMusic5     ; $1a
	dw BenFernMusic6     ; $1b
	dw BenFernMusic7     ; $1c
	dw FernMonMusic2     ; $1d
; Lucky Number Show
	dw LuckyNumberShow2  ; $1e
	dw LuckyNumberShow3  ; $1f
	dw LuckyNumberShow4  ; $20
	dw LuckyNumberShow5  ; $21
	dw LuckyNumberShow6  ; $22
	dw LuckyNumberShow7  ; $23
	dw LuckyNumberShow8  ; $24
	dw LuckyNumberShow9  ; $25
	dw LuckyNumberShow10 ; $26
	dw LuckyNumberShow11 ; $27
	dw LuckyNumberShow12 ; $28
	dw LuckyNumberShow13 ; $29
	dw LuckyNumberShow14 ; $2a
	dw LuckyNumberShow15 ; $2b
; People & Places
	dw PeoplePlaces2     ; $2c
	dw PeoplePlaces3     ; $2d
	dw PeoplePlaces4     ; $2e
	dw PeoplePlaces5     ; $2f
	dw PeoplePlaces6     ; $30
	dw PeoplePlaces7     ; $31
; Rocket Radio
	dw RocketRadio2      ; $32
	dw RocketRadio3      ; $33
	dw RocketRadio4      ; $34
	dw RocketRadio5      ; $35
	dw RocketRadio6      ; $36
	dw RocketRadio7      ; $37
	dw RocketRadio8      ; $38
	dw RocketRadio9      ; $39
	dw RocketRadio10     ; $3a
; More Pokemon Channel stuff
	dw OaksPKMNTalk10    ; $3b
	dw OaksPKMNTalk11    ; $3c
	dw OaksPKMNTalk12    ; $3d
	dw OaksPKMNTalk13    ; $3e
	dw OaksPKMNTalk14    ; $3f
; Buenas Password
	dw BuenasPassword2   ; $40
	dw BuenasPassword3   ; $41
	dw BuenasPassword4   ; $42
	dw BuenasPassword5   ; $43
	dw BuenasPassword6   ; $44
	dw BuenasPassword7   ; $45
	dw BuenasPassword8   ; $46
	dw BuenasPassword9   ; $47
	dw BuenasPassword10  ; $48
	dw BuenasPassword11  ; $49
	dw BuenasPassword12  ; $4a
	dw BuenasPassword13  ; $4b
	dw BuenasPassword14  ; $4c
	dw BuenasPassword15  ; $4d
	dw BuenasPassword16  ; $4e
	dw BuenasPassword17  ; $4f
	dw BuenasPassword18  ; $50
	dw BuenasPassword19  ; $51
	dw BuenasPassword20  ; $52
	dw BuenasPassword21  ; $53
	dw RadioScroll       ; $54
; More Pokemon Channel stuff
	dw PokedexShow6      ; $55
	dw PokedexShow7      ; $56
	dw PokedexShow8      ; $57
; More Team Rocket
	dw RocketRadio11	 ; $58
	dw RocketRadio12	 ; $59
	dw RocketRadio13	 ; $5a
	dw RocketRadio14	 ; $5b
; Johto Daily / Kanto News
	dw NewsRadio2        ; $5c
	dw NewsRadio3        ; $5d
	assert_table_length NUM_RADIO_SEGMENTS

PrintRadioLine:
	ld [wNextRadioLine], a
	ld hl, wRadioText
	ld a, [wNumRadioLinesPrinted]
	cp 2
	jr nc, .print
	inc hl
	ld [hl], TX_START
	inc a
	ld [wNumRadioLinesPrinted], a
	cp 2
	jr nz, .print
	bccoord 1, 16
	call PlaceHLTextAtBC
	jr .skip
.print
	call PrintTextboxText
.skip
	ld a, RADIO_SCROLL
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	ret

RadioScroll:
	ld hl, wRadioTextDelay
	ld a, [hl]
	and a
	jr z, .proceed
	dec [hl]
	ret
.proceed
	ld a, [wNextRadioLine]
	ld [wCurRadioLine], a
	ld a, [wNumRadioLinesPrinted]
	cp 1
	call nz, CopyBottomLineToTopLine
	jp ClearBottomLine

OaksPKMNTalk1:
	call StartRadioStation
	ld a, 5
	ld [wOaksPKMNTalkSegmentCounter], a
	ld hl, OPT_IntroText1
	ld a, OAKS_POKEMON_TALK_2
	jp NextRadioLine

OaksPKMNTalk2:
	ld hl, OPT_IntroText2
	ld a, OAKS_POKEMON_TALK_3
	jp NextRadioLine

OaksPKMNTalk3:
	ld hl, OPT_IntroText3
	ld a, OAKS_POKEMON_TALK_4
	jp NextRadioLine

OaksPKMNTalk4:
; Choose a random route, and a random Pokemon from that route.
.sample
	call Random
	and %11111
	cp (OaksPKMNTalkRoutes.End - OaksPKMNTalkRoutes) / 2
	jr nc, .sample
	ld hl, OaksPKMNTalkRoutes
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	; bc now contains the chosen map's group and number indices.
	push bc

	; Search the JohtoGrassWildMons array for the chosen map.
	ld hl, JohtoGrassWildMons
.loop
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	cp -1
	jr z, .overflow
	inc hl
	cp b
	jr nz, .next
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	cp c
	jr z, .done
.next
	dec hl
	ld de, GRASS_WILDDATA_LENGTH
	add hl, de
	jr .loop

.done
	; Point hl to the list of morning Pokémon., skipping percentages
rept 4
	inc hl
endr
	; Generate a number, either 0, 1, or 2, to choose a time of day.
.loop2
	call Random
	maskbits NUM_DAYTIMES
	cp DARKNESS_F
	jr z, .loop2

	ld bc, 2 * NUM_GRASSMON
	call AddNTimes
.loop3
	; Choose one of the middle three Pokemon.
	call Random
	maskbits NUM_GRASSMON
	cp 2
	jr c, .loop3
	cp 5
	jr nc, .loop3
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	inc hl ; skip level
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld [wNamedObjectIndex], a
	ld [wCurPartySpecies], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	; Now that we've chosen our wild Pokemon,
	; let's recover the map index info and get its name.
	pop bc
	call GetWorldMapLocation
	ld e, a
	farcall GetLandmarkName
	ld hl, OPT_OakText1
	call CopyRadioTextToRAM
	ld a, OAKS_POKEMON_TALK_5
	jp PrintRadioLine

.overflow
	pop bc
	ld a, OAKS_POKEMON_TALK
	jp PrintRadioLine

INCLUDE "data/radio/oaks_pkmn_talk_routes.asm"

OaksPKMNTalk5:
	ld hl, OPT_OakText2
	ld a, OAKS_POKEMON_TALK_6
	jp NextRadioLine

OaksPKMNTalk6:
	ld hl, OPT_OakText3
	ld a, OAKS_POKEMON_TALK_7
	jp NextRadioLine

OPT_IntroText1:
	text_far _OPT_IntroText1
	text_end

OPT_IntroText2:
	text_far _OPT_IntroText2
	text_end

OPT_IntroText3:
	text_far _OPT_IntroText3
	text_end

OPT_OakText1:
	text_far _OPT_OakText1
	text_end

OPT_OakText2:
	text_far _OPT_OakText2
	text_end

OPT_OakText3:
	text_far _OPT_OakText3
	text_end

OaksPKMNTalk7:
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, OPT_MaryText1
	ld a, OAKS_POKEMON_TALK_8
	jp NextRadioLine

OPT_MaryText1:
	text_far _OPT_MaryText1
	text_end

OaksPKMNTalk8:
	; 0-15 are all valid indexes into .Adverbs,
	; so no need for a retry loop
	call Random
	maskbits NUM_OAKS_POKEMON_TALK_ADVERBS
	assert_power_of_2 NUM_OAKS_POKEMON_TALK_ADVERBS
	ld e, a
	ld d, 0
	ld hl, .Adverbs
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, OAKS_POKEMON_TALK_9
	jp NextRadioLine

.Adverbs:
	table_width 2, OaksPKMNTalk8.Adverbs
	dw .OPT_SweetAdorablyText
	dw .OPT_WigglySlicklyText
	dw .OPT_AptlyNamedText
	dw .OPT_UndeniablyKindOfText
	dw .OPT_UnbearablyText
	dw .OPT_WowImpressivelyText
	dw .OPT_AlmostPoisonouslyText
	dw .OPT_SensuallyText
	dw .OPT_MischievouslyText
	dw .OPT_TopicallyText
	dw .OPT_AddictivelyText
	dw .OPT_LooksInWaterText
	dw .OPT_EvolutionMustBeText
	dw .OPT_ProvocativelyText
	dw .OPT_FlippedOutText
	dw .OPT_HeartMeltinglyText
	assert_table_length NUM_OAKS_POKEMON_TALK_ADVERBS

.OPT_SweetAdorablyText:
	text_far _OPT_SweetAdorablyText
	text_end

.OPT_WigglySlicklyText:
	text_far _OPT_WigglySlicklyText
	text_end

.OPT_AptlyNamedText:
	text_far _OPT_AptlyNamedText
	text_end

.OPT_UndeniablyKindOfText:
	text_far _OPT_UndeniablyKindOfText
	text_end

.OPT_UnbearablyText:
	text_far _OPT_UnbearablyText
	text_end

.OPT_WowImpressivelyText:
	text_far _OPT_WowImpressivelyText
	text_end

.OPT_AlmostPoisonouslyText:
	text_far _OPT_AlmostPoisonouslyText
	text_end

.OPT_SensuallyText:
	text_far _OPT_SensuallyText
	text_end

.OPT_MischievouslyText:
	text_far _OPT_MischievouslyText
	text_end

.OPT_TopicallyText:
	text_far _OPT_TopicallyText
	text_end

.OPT_AddictivelyText:
	text_far _OPT_AddictivelyText
	text_end

.OPT_LooksInWaterText:
	text_far _OPT_LooksInWaterText
	text_end

.OPT_EvolutionMustBeText:
	text_far _OPT_EvolutionMustBeText
	text_end

.OPT_ProvocativelyText:
	text_far _OPT_ProvocativelyText
	text_end

.OPT_FlippedOutText:
	text_far _OPT_FlippedOutText
	text_end

.OPT_HeartMeltinglyText:
	text_far _OPT_HeartMeltinglyText
	text_end

OaksPKMNTalk9:
	; 0-15 are all valid indexes into .Adjectives,
	; so no need for a retry loop
	call Random
	maskbits NUM_OAKS_POKEMON_TALK_ADJECTIVES
	assert_power_of_2 NUM_OAKS_POKEMON_TALK_ADJECTIVES
	ld e, a
	ld d, 0
	ld hl, .Adjectives
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wOaksPKMNTalkSegmentCounter]
	dec a
	ld [wOaksPKMNTalkSegmentCounter], a
	ld a, OAKS_POKEMON_TALK_4
	jr nz, .ok
	ld a, 5
	ld [wOaksPKMNTalkSegmentCounter], a
	ld a, OAKS_POKEMON_TALK_10
.ok
	jp NextRadioLine

.Adjectives:
	table_width 2, OaksPKMNTalk9.Adjectives
	dw .OPT_CuteText
	dw .OPT_WeirdText
	dw .OPT_PleasantText
	dw .OPT_BoldSortOfText
	dw .OPT_FrighteningText
	dw .OPT_SuaveDebonairText
	dw .OPT_PowerfulText
	dw .OPT_ExcitingText
	dw .OPT_GroovyText
	dw .OPT_InspiringText
	dw .OPT_FriendlyText
	dw .OPT_HotHotHotText
	dw .OPT_StimulatingText
	dw .OPT_GuardedText
	dw .OPT_LovelyText
	dw .OPT_SpeedyText
	assert_table_length NUM_OAKS_POKEMON_TALK_ADJECTIVES

.OPT_CuteText:
	text_far _OPT_CuteText
	text_end

.OPT_WeirdText:
	text_far _OPT_WeirdText
	text_end

.OPT_PleasantText:
	text_far _OPT_PleasantText
	text_end

.OPT_BoldSortOfText:
	text_far _OPT_BoldSortOfText
	text_end

.OPT_FrighteningText:
	text_far _OPT_FrighteningText
	text_end

.OPT_SuaveDebonairText:
	text_far _OPT_SuaveDebonairText
	text_end

.OPT_PowerfulText:
	text_far _OPT_PowerfulText
	text_end

.OPT_ExcitingText:
	text_far _OPT_ExcitingText
	text_end

.OPT_GroovyText:
	text_far _OPT_GroovyText
	text_end

.OPT_InspiringText:
	text_far _OPT_InspiringText
	text_end

.OPT_FriendlyText:
	text_far _OPT_FriendlyText
	text_end

.OPT_HotHotHotText:
	text_far _OPT_HotHotHotText
	text_end

.OPT_StimulatingText:
	text_far _OPT_StimulatingText
	text_end

.OPT_GuardedText:
	text_far _OPT_GuardedText
	text_end

.OPT_LovelyText:
	text_far _OPT_LovelyText
	text_end

.OPT_SpeedyText:
	text_far _OPT_SpeedyText
	text_end

OaksPKMNTalk10:
	farcall RadioMusicRestartPokemonChannel
	ld hl, OPT_RestartText
	call PrintText
	call WaitBGMap
	ld hl, OPT_PokemonChannelText
	call PrintText
	ld a, OAKS_POKEMON_TALK_11
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	ret

OPT_PokemonChannelText:
	text_far _OPT_PokemonChannelText
	text_end

OPT_RestartText:
	text_end

OaksPKMNTalk11:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 9, 14
	ld de, .pokemon_string
	ld a, OAKS_POKEMON_TALK_12
	jp PlaceRadioString

.pokemon_string
	db "#MON@"

OaksPKMNTalk12:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 1, 16
	ld de, .pokemon_channel_string
	ld a, OAKS_POKEMON_TALK_13
	jp PlaceRadioString

.pokemon_channel_string
if DEF(_FR_FR)
	db "Antenne #MON@"
else
	db "#MON Channel@"
endc

OaksPKMNTalk13:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 12, 16
	ld de, .terminator
	ld a, OAKS_POKEMON_TALK_14
	jp PlaceRadioString

.terminator
	db "@"

OaksPKMNTalk14:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	ld de, MUSIC_POKEMON_TALK
	callfar RadioMusicRestartDE
	ld hl, .terminator
	call PrintText
	ld a, OAKS_POKEMON_TALK_4
	ld [wNextRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	ld a, RADIO_SCROLL
	ld [wCurRadioLine], a
	ld a, 10
	ld [wRadioTextDelay], a
	ret

.terminator
	db "@"

PlaceRadioString:
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	jp PlaceString

CopyBottomLineToTopLine:
	hlcoord 0, 15
	decoord 0, 13
	ld bc, SCREEN_WIDTH * 2
	jp CopyBytes

ClearBottomLine:
	hlcoord 1, 15
	ld bc, SCREEN_WIDTH - 2
	ld a, " "
	call ByteFill
	hlcoord 1, 16
	ld bc, SCREEN_WIDTH - 2
	ld a, " "
	jp ByteFill

PokedexShow_GetDexEntryBank:
	push hl
	push de
	ld a, [wCurPartySpecies]
	dec a
	rlca
	rlca
	maskbits NUM_DEX_ENTRY_BANKS
	ld hl, .PokedexEntryBanks
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	ret

.PokedexEntryBanks:
	db BANK("Pokedex Entries 001-064")
	db BANK("Pokedex Entries 065-128")
	db BANK("Pokedex Entries 129-192")
	db BANK("Pokedex Entries 193-251")

PokedexShow1:
	call StartRadioStation
.loop
	call Random
	cp NUM_POKEMON
	jr nc, .loop
	ld c, a
	push bc
	ld a, c
	call CheckCaughtMon
	pop bc
	jr z, .loop
	inc c
	ld a, c
	ld [wCurPartySpecies], a
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, PokedexShowText
	ld a, POKEDEX_SHOW_2
	jp NextRadioLine

PokedexShow2:
	ld a, [wCurPartySpecies]
	dec a
	ld hl, PokedexDataPointerTable
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, BANK(PokedexDataPointerTable)
	call GetFarWord
	call PokedexShow_GetDexEntryBank
	push af
	push hl
	call CopyDexEntryPart1
	dec hl
	ld [hl], "<DONE>"
	ld hl, wPokedexShowPointerAddr
	call CopyRadioTextToRAM
	pop hl
	pop af
	call CopyDexEntryPart2
if DEF(_FR_FR)
	inc hl
	inc hl
	inc hl
else
	inc hl
	inc hl
	inc hl
	inc hl
endc
	ld a, l
	ld [wPokedexShowPointerAddr], a
	ld a, h
	ld [wPokedexShowPointerAddr + 1], a
	ld a, POKEDEX_SHOW_3
	jp PrintRadioLine

PokedexShow3:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_4
	jp PrintRadioLine

PokedexShow4:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_5
	jp PrintRadioLine

PokedexShow5:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_6
	jp PrintRadioLine

PokedexShow6:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_7
	jp PrintRadioLine

PokedexShow7:
	call CopyDexEntry
	ld a, POKEDEX_SHOW_8
	jp PrintRadioLine

PokedexShow8:
	call CopyDexEntry
	ld a, POKEDEX_SHOW
	jp PrintRadioLine

CopyDexEntry:
	ld a, [wPokedexShowPointerAddr]
	ld l, a
	ld a, [wPokedexShowPointerAddr + 1]
	ld h, a
	ld a, [wPokedexShowPointerBank]
	push af
	push hl
	call CopyDexEntryPart1
	dec hl
	ld [hl], "<DONE>"
	ld hl, wPokedexShowPointerAddr
	call CopyRadioTextToRAM
	pop hl
	pop af
	call CopyDexEntryPart2
	ret

CopyDexEntryPart1:
	ld de, wPokedexShowPointerBank
	ld bc, SCREEN_WIDTH - 1
	call FarCopyBytes
	ld hl, wPokedexShowPointerAddr
	ld [hl], TX_START
	inc hl
	ld [hl], "<LINE>"
	inc hl
.loop
	ld a, [hli]
	cp "@"
	ret z
	cp "<NEXT>"
	ret z
	cp "<DEXEND>"
	ret z
	jr .loop

CopyDexEntryPart2:
	ld d, a
.loop
	ld a, d
	call GetFarByte
	inc hl
	cp "@"
	jr z, .okay
	cp "<NEXT>"
	jr z, .okay
	cp "<DEXEND>"
	jr nz, .loop
.okay
	ld a, l
	ld [wPokedexShowPointerAddr], a
	ld a, h
	ld [wPokedexShowPointerAddr + 1], a
	ld a, d
	ld [wPokedexShowPointerBank], a
	ret

PokedexShowText:
	text_far _PokedexShowText
	text_end

BenMonMusic1:
	call StartPokemonMusicChannel
	ld hl, BenIntroText1
	ld a, POKEMON_MUSIC_2
	jp NextRadioLine

BenMonMusic2:
	ld hl, BenIntroText2
	ld a, POKEMON_MUSIC_3
	jp NextRadioLine

BenMonMusic3:
	ld hl, BenIntroText3
	ld a, POKEMON_MUSIC_4
	jp NextRadioLine

FernMonMusic1:
	call StartPokemonMusicChannel
	ld hl, FernIntroText1
	ld a, LETS_ALL_SING_2
	jp NextRadioLine

FernMonMusic2:
	ld hl, FernIntroText2
	ld a, POKEMON_MUSIC_4
	jp NextRadioLine

BenFernMusic4:
	ld hl, BenFernText1
	ld a, POKEMON_MUSIC_5
	jp NextRadioLine

BenFernMusic5:
	call GetWeekday
	and 1
	ld hl, BenFernText2A
	jr z, .SunTueThurSun
	ld hl, BenFernText2B
.SunTueThurSun:
	ld a, POKEMON_MUSIC_6
	jp NextRadioLine

BenFernMusic6:
	call GetWeekday
	and 1
	ld hl, BenFernText3A
	jr z, .SunTueThurSun
	ld hl, BenFernText3B
.SunTueThurSun:
	ld a, POKEMON_MUSIC_7
	jp NextRadioLine

BenFernMusic7:
	ret

StartPokemonMusicChannel:
	call RadioTerminator
	call PrintText
	ld de, MUSIC_POKEMON_MARCH
	call GetWeekday
	and 1
	jr z, .SunTueThurSun
	ld de, MUSIC_POKEMON_LULLABY
.SunTueThurSun:
	callfar RadioMusicRestartDE
	ret

BenIntroText1:
	text_far _BenIntroText1
	text_end

BenIntroText2:
	text_far _BenIntroText2
	text_end

BenIntroText3:
	text_far _BenIntroText3
	text_end

FernIntroText1:
	text_far _FernIntroText1
	text_end

FernIntroText2:
	text_far _FernIntroText2
	text_end

BenFernText1:
	text_far _BenFernText1
	text_end

BenFernText2A:
	text_far _BenFernText2A
	text_end

BenFernText2B:
	text_far _BenFernText2B
	text_end

BenFernText3A:
	text_far _BenFernText3A
	text_end

BenFernText3B:
	text_far _BenFernText3B
	text_end

LuckyNumberShow1:
	call StartRadioStation
	callfar CheckLuckyNumberShowFlag
	jr nz, .dontreset
	callfar ResetLuckyNumberShowFlag
.dontreset
	ld hl, LC_Text1
	ld a, LUCKY_NUMBER_SHOW_2
	jp NextRadioLine

LuckyNumberShow2:
	ld hl, LC_Text2
	ld a, LUCKY_NUMBER_SHOW_3
	jp NextRadioLine

LuckyNumberShow3:
	ld hl, LC_Text3
	ld a, LUCKY_NUMBER_SHOW_4
	jp NextRadioLine

LuckyNumberShow4:
	ld hl, LC_Text4
	ld a, LUCKY_NUMBER_SHOW_5
	jp NextRadioLine

LuckyNumberShow5:
	ld hl, LC_Text5
	ld a, LUCKY_NUMBER_SHOW_6
	jp NextRadioLine

LuckyNumberShow6:
	ld hl, LC_Text6
	ld a, LUCKY_NUMBER_SHOW_7
	jp NextRadioLine

LuckyNumberShow7:
	ld hl, LC_Text7
	ld a, LUCKY_NUMBER_SHOW_8
	jp NextRadioLine

LuckyNumberShow8:
	ld hl, wStringBuffer1
	ld de, wLuckyIDNumber
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld a, "@"
	ld [wStringBuffer1 + 5], a
	ld hl, LC_Text8
	ld a, LUCKY_NUMBER_SHOW_9
	jp NextRadioLine

LuckyNumberShow9:
	ld hl, LC_Text9
	ld a, LUCKY_NUMBER_SHOW_10
	jp NextRadioLine

LuckyNumberShow10:
	ld hl, LC_Text7
	ld a, LUCKY_NUMBER_SHOW_11
	jp NextRadioLine

LuckyNumberShow11:
	ld hl, LC_Text8
	ld a, LUCKY_NUMBER_SHOW_12
	jp NextRadioLine

LuckyNumberShow12:
	ld hl, LC_Text10
	ld a, LUCKY_NUMBER_SHOW_13
	jp NextRadioLine

LuckyNumberShow13:
	ld hl, LC_Text11
	call Random
	and a
	ld a, LUCKY_CHANNEL
	jr nz, .okay
	ld a, LUCKY_NUMBER_SHOW_14
.okay
	jp NextRadioLine

LuckyNumberShow14:
	ld hl, LC_DragText1
	ld a, LUCKY_NUMBER_SHOW_15
	jp NextRadioLine

LuckyNumberShow15:
	ld hl, LC_DragText2
	ld a, LUCKY_CHANNEL
	jp NextRadioLine

LC_Text1:
	text_far _LC_Text1
	text_end

LC_Text2:
	text_far _LC_Text2
	text_end

LC_Text3:
	text_far _LC_Text3
	text_end

LC_Text4:
	text_far _LC_Text4
	text_end

LC_Text5:
	text_far _LC_Text5
	text_end

LC_Text6:
	text_far _LC_Text6
	text_end

LC_Text7:
	text_far _LC_Text7
	text_end

LC_Text8:
	text_far _LC_Text8
	text_end

LC_Text9:
	text_far _LC_Text9
	text_end

LC_Text10:
	text_far _LC_Text10
	text_end

LC_Text11:
	text_far _LC_Text11
	text_end

LC_DragText1:
	text_far _LC_DragText1
	text_end

LC_DragText2:
	text_far _LC_DragText2
	text_end

PeoplePlaces1:
	call StartRadioStation
	ld hl, PnP_Text1
	ld a, PLACES_AND_PEOPLE_2
	jp NextRadioLine

PeoplePlaces2:
	ld hl, PnP_Text2
	ld a, PLACES_AND_PEOPLE_3
	jp NextRadioLine

PeoplePlaces3:
	ld hl, PnP_Text3
	call Random
	cp 49 percent - 1
	ld a, PLACES_AND_PEOPLE_4 ; People
	jr c, .ok
	ld a, PLACES_AND_PEOPLE_6 ; Places
.ok
	jp NextRadioLine

PnP_Text1:
	text_far _PnP_Text1
	text_end

PnP_Text2:
	text_far _PnP_Text2
	text_end

PnP_Text3:
	text_far _PnP_Text3
	text_end

PeoplePlaces4: ; People
	call Random
	maskbits NUM_TRAINER_CLASSES
	inc a
	cp NUM_TRAINER_CLASSES ; exclude MYSTICALMAN
	jr nc, PeoplePlaces4
	push af
	ld hl, PnP_HiddenPeople
	ld a, [wStatusFlags]
	bit STATUSFLAGS_HALL_OF_FAME_F, a
	jr z, .ok
	ld hl, PnP_HiddenPeople_BeatE4
	ld a, [wKantoBadges]
	cp %11111111 ; all badges
	jr nz, .ok
	ld hl, PnP_HiddenPeople_BeatKanto
.ok
	pop af
	ld c, a
	push bc
	call IsInByteArray
	pop bc
	jr c, PeoplePlaces4
	push bc
	callfar GetTrainerClassName
	ld de, wStringBuffer1
	call CopyName1
	pop bc
	ld b, 1
	callfar GetTrainerName
	ld hl, PnP_Text4
	ld a, PLACES_AND_PEOPLE_5
	jp NextRadioLine

INCLUDE "data/radio/pnp_hidden_people.asm"

PnP_Text4:
	text_far _PnP_Text4
	text_end

PeoplePlaces5:
	; 0-15 are all valid indexes into .Adjectives,
	; so no need for a retry loop
	call Random
	maskbits NUM_PNP_PEOPLE_ADJECTIVES
	assert_power_of_2 NUM_PNP_PEOPLE_ADJECTIVES
	ld e, a
	ld d, 0
	ld hl, .Adjectives
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Random
	cp 4 percent
	ld a, PLACES_AND_PEOPLE
	jr c, .ok
	call Random
	cp 49 percent - 1
	ld a, PLACES_AND_PEOPLE_4 ; People
	jr c, .ok
	ld a, PLACES_AND_PEOPLE_6 ; Places
.ok
	jp NextRadioLine

.Adjectives:
	table_width 2, PeoplePlaces5.Adjectives
	dw PnP_CuteText
	dw PnP_LazyText
	dw PnP_HappyText
	dw PnP_NoisyText
	dw PnP_PrecociousText
	dw PnP_BoldText
	dw PnP_PickyText
	dw PnP_SortOfOKText
	dw PnP_SoSoText
	dw PnP_GreatText
	dw PnP_MyTypeText
	dw PnP_CoolText
	dw PnP_InspiringText
	dw PnP_WeirdText
	dw PnP_RightForMeText
	dw PnP_OddText
	assert_table_length NUM_PNP_PEOPLE_ADJECTIVES

PnP_CuteText:
	text_far _PnP_CuteText
	text_end

PnP_LazyText:
	text_far _PnP_LazyText
	text_end

PnP_HappyText:
	text_far _PnP_HappyText
	text_end

PnP_NoisyText:
	text_far _PnP_NoisyText
	text_end

PnP_PrecociousText:
	text_far _PnP_PrecociousText
	text_end

PnP_BoldText:
	text_far _PnP_BoldText
	text_end

PnP_PickyText:
	text_far _PnP_PickyText
	text_end

PnP_SortOfOKText:
	text_far _PnP_SortOfOKText
	text_end

PnP_SoSoText:
	text_far _PnP_SoSoText
	text_end

PnP_GreatText:
	text_far _PnP_GreatText
	text_end

PnP_MyTypeText:
	text_far _PnP_MyTypeText
	text_end

PnP_CoolText:
	text_far _PnP_CoolText
	text_end

PnP_InspiringText:
	text_far _PnP_InspiringText
	text_end

PnP_WeirdText:
	text_far _PnP_WeirdText
	text_end

PnP_RightForMeText:
	text_far _PnP_RightForMeText
	text_end

PnP_OddText:
	text_far _PnP_OddText
	text_end

PeoplePlaces6: ; Places
	call Random
	cp (PnP_Places.End - PnP_Places) / 2
	jr nc, PeoplePlaces6
	ld hl, PnP_Places
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	call GetWorldMapLocation
	ld e, a
	farcall GetLandmarkName
	ld hl, PnP_Text5
	ld a, PLACES_AND_PEOPLE_7
	jp NextRadioLine

INCLUDE "data/radio/pnp_places.asm"

PnP_Text5:
	text_far _PnP_Text5
	text_end

PeoplePlaces7:
	; 0-15 are all valid indexes into .Adjectives,
	; so no need for a retry loop
	call Random
	maskbits NUM_PNP_PLACES_ADJECTIVES
	assert_power_of_2 NUM_PNP_PLACES_ADJECTIVES
	ld e, a
	ld d, 0
	ld hl, .Adjectives
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CopyRadioTextToRAM
	call Random
	cp 4 percent
	ld a, PLACES_AND_PEOPLE
	jr c, .ok
	call Random
	cp 49 percent - 1
	ld a, PLACES_AND_PEOPLE_4 ; People
	jr c, .ok
	ld a, PLACES_AND_PEOPLE_6 ; Places
.ok
	jp PrintRadioLine

.Adjectives:
	table_width 2, PeoplePlaces7.Adjectives
	dw PnP_CuteText
	dw PnP_LazyText
	dw PnP_HappyText
	dw PnP_NoisyText
	dw PnP_PrecociousText
	dw PnP_BoldText
	dw PnP_PickyText
	dw PnP_SortOfOKText
	dw PnP_SoSoText
	dw PnP_GreatText
	dw PnP_MyTypeText
	dw PnP_CoolText
	dw PnP_InspiringText
	dw PnP_WeirdText
	dw PnP_RightForMeText
	dw PnP_OddText
	assert_table_length NUM_PNP_PLACES_ADJECTIVES

RocketRadio1:
	call StartRadioStation
	ld hl, RocketRadioText1
	ld a, ROCKET_RADIO_2
	jp NextRadioLine

RocketRadio2:
	ld hl, RocketRadioText2
	ld a, ROCKET_RADIO_3
	jp NextRadioLine

RocketRadio3:
	ld hl, RocketRadioText3
	ld a, ROCKET_RADIO_4
	jp NextRadioLine

RocketRadio4:
	ld hl, RocketRadioText4
	ld a, ROCKET_RADIO_5
	jp NextRadioLine

RocketRadio5:
	ld hl, RocketRadioText5
	ld a, ROCKET_RADIO_6
	jp NextRadioLine

RocketRadio6:
	ld hl, RocketRadioText6
	ld a, ROCKET_RADIO_7
	jp NextRadioLine

RocketRadio7:
	ld hl, RocketRadioText7
	ld a, ROCKET_RADIO_8
	jp NextRadioLine

RocketRadio8:
	ld hl, RocketRadioText8
	ld a, ROCKET_RADIO_9
	jp NextRadioLine

RocketRadio9:
	ld hl, RocketRadioText9
	ld a, ROCKET_RADIO_10
	jp NextRadioLine

RocketRadio10:
	ld hl, RocketRadioText10
	ld a, ROCKET_RADIO_11
	jp NextRadioLine

RocketRadio11:
	ld hl, RocketRadioText11
	ld a, ROCKET_RADIO_12
	jp NextRadioLine

RocketRadio12:
	ld hl, RocketRadioText12
	ld a, ROCKET_RADIO_13
	jp NextRadioLine

RocketRadio13:
	ld hl, RocketRadioText13
	ld a, ROCKET_RADIO_14
	jp NextRadioLine

RocketRadio14:
	ld hl, RocketRadioText14
	ld a, ROCKET_RADIO
	jp NextRadioLine

RocketRadioText1:
	text_far _RocketRadioText1
	text_end

RocketRadioText2:
	text_far _RocketRadioText2
	text_end

RocketRadioText3:
	text_far _RocketRadioText3
	text_end

RocketRadioText4:
	text_far _RocketRadioText4
	text_end

RocketRadioText5:
	text_far _RocketRadioText5
	text_end

RocketRadioText6:
	text_far _RocketRadioText6
	text_end

RocketRadioText7:
	text_far _RocketRadioText7
	text_end

RocketRadioText8:
	text_far _RocketRadioText8
	text_end

RocketRadioText9:
	text_far _RocketRadioText9
	text_end

RocketRadioText10:
	text_far _RocketRadioText10
	text_end

RocketRadioText11:
	text_far _RocketRadioText11
	text_end
	
RocketRadioText12:
	text_far _RocketRadioText12
	text_end
	
RocketRadioText13:
	text_far _RocketRadioText13
	text_end
	
RocketRadioText14:
	text_far _RocketRadioText14
	text_end

PokeFluteRadio:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

UnownRadio:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

EvolutionRadio:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

BuenasPassword1:
; Determine if we need to be here
	call BuenasPasswordCheckTime
	jp nc, .PlayPassword
	ld a, [wNumRadioLinesPrinted]
	and a
	jp z, BuenasPassword20
	jp BuenasPassword8

.PlayPassword:
	call StartRadioStation
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ld de, BuenasPasswordChannelName
	hlcoord 2, 9
	call PlaceString
	pop af
	ldh [hBGMapMode], a
	ld hl, BuenaRadioText1
	ld a, BUENAS_PASSWORD_2
	jp NextRadioLine

BuenasPassword2:
	ld hl, BuenaRadioText2
	ld a, BUENAS_PASSWORD_3
	jp NextRadioLine

BuenasPassword3:
	call BuenasPasswordCheckTime
	ld hl, BuenaRadioText3
	jp c, BuenasPasswordAfterMidnight
	ld a, BUENAS_PASSWORD_4
	jp NextRadioLine

BuenasPassword4:
	call BuenasPasswordCheckTime
	jp c, BuenasPassword8
	ld a, [wBuenasPassword]
; If we already generated the password today, we don't need to generate a new one.
	ld hl, wDailyFlags2
	bit DAILYFLAGS2_BUENAS_PASSWORD_F, [hl]
	jr nz, .AlreadyGotIt
; There are only 11 groups to choose from.
.greater_than_11
	call Random
	maskbits NUM_PASSWORD_CATEGORIES
	cp NUM_PASSWORD_CATEGORIES
	jr nc, .greater_than_11
; Store it in the high nybble of e.
	swap a
	ld e, a
; For each group, choose one of the three passwords.
.greater_than_three
	call Random
	maskbits NUM_PASSWORDS_PER_CATEGORY
	cp NUM_PASSWORDS_PER_CATEGORY
	jr nc, .greater_than_three
; The high nybble of wBuenasPassword will now contain the password group index, and the low nybble contains the actual password.
	add e
	ld [wBuenasPassword], a
; Set the flag so that we don't generate a new password this week.
	ld hl, wDailyFlags2
	set DAILYFLAGS2_BUENAS_PASSWORD_F, [hl]
.AlreadyGotIt:
	ld c, a
	call GetBuenasPassword
	ld hl, BuenaRadioText4
	ld a, BUENAS_PASSWORD_5
	jp NextRadioLine

GetBuenasPassword:
; The password indices are held in c.  High nybble contains the group index, low nybble contains the word index.
; Load the password group pointer in hl.
	ld a, c
	swap a
	and $f
	ld hl, BuenasPasswordTable
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
; Get the password type and store it in b.
	ld a, [hli]
	ld b, a
	push hl
	inc hl
; Get the password index.
	ld a, c
	and $f
	ld c, a
	push hl
	ld hl, .StringFunctionJumpTable
	ld e, b
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de ; de now contains the pointer to the value of this week's password, in Blue Card Points.
	call _hl_
	pop hl
	ld c, [hl]
	ret

.StringFunctionJumpTable:
; entries correspond to BUENA_* constants
	dw .Mon       ; BUENA_MON
	dw .Item      ; BUENA_ITEM
	dw .Move      ; BUENA_MOVE
	dw .RawString ; BUENA_STRING

.Mon:
	call .GetTheIndex
	call GetPokemonName
	ret

.Item:
	call .GetTheIndex
	call GetItemName
	ret

.Move:
	call .GetTheIndex
	call GetMoveName
	ret

.GetTheIndex:
	ld h, 0
	ld l, c
	add hl, de
	ld a, [hl]
	ld [wNamedObjectIndex], a
	ret

.RawString:
; Get the string from the table...
	ld a, c
	and a
	jr z, .skip
.read_loop
	ld a, [de]
	inc de
	cp "@"
	jr nz, .read_loop
	dec c
	jr nz, .read_loop
; ... and copy it into wStringBuffer1.
.skip
	ld hl, wStringBuffer1
.copy_loop
	ld a, [de]
	inc de
	ld [hli], a
	cp "@"
	jr nz, .copy_loop
	ld de, wStringBuffer1
	ret

INCLUDE "data/radio/buenas_passwords.asm"

BuenasPassword5:
	ld hl, BuenaRadioText5
	ld a, BUENAS_PASSWORD_6
	jp NextRadioLine

BuenasPassword6:
	ld hl, BuenaRadioText6
	ld a, BUENAS_PASSWORD_7
	jp NextRadioLine

BuenasPassword7:
	call BuenasPasswordCheckTime
	ld hl, BuenaRadioText7
	jr c, BuenasPasswordAfterMidnight
	ld a, BUENAS_PASSWORD
	jp NextRadioLine

BuenasPasswordAfterMidnight:
	push hl
	ld hl, wDailyFlags2
	res DAILYFLAGS2_BUENAS_PASSWORD_F, [hl]
	pop hl
	ld a, BUENAS_PASSWORD_8
	jp NextRadioLine

BuenasPassword8:
	ld hl, wDailyFlags2
	res DAILYFLAGS2_BUENAS_PASSWORD_F, [hl]
	ld hl, BuenaRadioMidnightText10
	ld a, BUENAS_PASSWORD_9
	jp NextRadioLine

BuenasPassword9:
	ld hl, BuenaRadioMidnightText1
	ld a, BUENAS_PASSWORD_10
	jp NextRadioLine

BuenasPassword10:
	ld hl, BuenaRadioMidnightText2
	ld a, BUENAS_PASSWORD_11
	jp NextRadioLine

BuenasPassword11:
	ld hl, BuenaRadioMidnightText3
	ld a, BUENAS_PASSWORD_12
	jp NextRadioLine

BuenasPassword12:
	ld hl, BuenaRadioMidnightText4
	ld a, BUENAS_PASSWORD_13
	jp NextRadioLine

BuenasPassword13:
	ld hl, BuenaRadioMidnightText5
	ld a, BUENAS_PASSWORD_14
	jp NextRadioLine

BuenasPassword14:
	ld hl, BuenaRadioMidnightText6
	ld a, BUENAS_PASSWORD_15
	jp NextRadioLine

BuenasPassword15:
	ld hl, BuenaRadioMidnightText7
	ld a, BUENAS_PASSWORD_16
	jp NextRadioLine

BuenasPassword16:
	ld hl, BuenaRadioMidnightText8
	ld a, BUENAS_PASSWORD_17
	jp NextRadioLine

BuenasPassword17:
	ld hl, BuenaRadioMidnightText9
	ld a, BUENAS_PASSWORD_18
	jp NextRadioLine

BuenasPassword18:
	ld hl, BuenaRadioMidnightText10
	ld a, BUENAS_PASSWORD_19
	jp NextRadioLine

BuenasPassword19:
	ld hl, BuenaRadioMidnightText10
	ld a, BUENAS_PASSWORD_20
	jp NextRadioLine

BuenasPassword20:
	ldh a, [hBGMapMode]
	push af
	farcall NoRadioMusic
	farcall NoRadioName
	pop af
	ldh [hBGMapMode], a
	ld hl, wDailyFlags2
	res DAILYFLAGS2_BUENAS_PASSWORD_F, [hl]
	ld a, BUENAS_PASSWORD
	ld [wCurRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	ld hl, BuenaOffTheAirText
	ld a, BUENAS_PASSWORD_21
	jp NextRadioLine

BuenasPassword21:
	ld a, BUENAS_PASSWORD
	ld [wCurRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	call BuenasPasswordCheckTime
	jp nc, BuenasPassword1
	ld hl, BuenaOffTheAirText
	ld a, BUENAS_PASSWORD_21
	jp NextRadioLine

BuenasPasswordCheckTime:
	call UpdateTime
	ldh a, [hHours]
	cp NITE_HOUR
	ret

BuenasPasswordChannelName:
if DEF(_FR_FR)
	db "CODE DE BUENA@"
else
	db "BUENA'S PASSWORD@"
endc

BuenaRadioText1:
	text_far _BuenaRadioText1
	text_end

BuenaRadioText2:
	text_far _BuenaRadioText2
	text_end

BuenaRadioText3:
	text_far _BuenaRadioText3
	text_end

BuenaRadioText4:
	text_far _BuenaRadioText4
	text_end

BuenaRadioText5:
	text_far _BuenaRadioText5
	text_end

BuenaRadioText6:
	text_far _BuenaRadioText6
	text_end

BuenaRadioText7:
	text_far _BuenaRadioText7
	text_end

BuenaRadioMidnightText1:
	text_far _BuenaRadioMidnightText1
	text_end

BuenaRadioMidnightText2:
	text_far _BuenaRadioMidnightText2
	text_end

BuenaRadioMidnightText3:
	text_far _BuenaRadioMidnightText3
	text_end

BuenaRadioMidnightText4:
	text_far _BuenaRadioMidnightText4
	text_end

BuenaRadioMidnightText5:
	text_far _BuenaRadioMidnightText5
	text_end

BuenaRadioMidnightText6:
	text_far _BuenaRadioMidnightText6
	text_end

BuenaRadioMidnightText7:
	text_far _BuenaRadioMidnightText7
	text_end

BuenaRadioMidnightText8:
	text_far _BuenaRadioMidnightText8
	text_end

BuenaRadioMidnightText9:
	text_far _BuenaRadioMidnightText9
	text_end

BuenaRadioMidnightText10:
	text_far _BuenaRadioMidnightText10
	text_end

BuenaOffTheAirText:
	text_far _BuenaOffTheAirText
	text_end

; The news radio displays three news in sequence:
; 1: info about the current freedom state.
; 2: cluster info, or important info about covid.
; 3: death count.
NewsRadio1:
	call StartRadioStation
	call NewsRadio_GetNews1Index ; Outputs index in C.

	; Display the next line of the current news.
	push bc ; Save index.
	ld hl, News1_pools
	call NewsRadio_GetNewsLine
	pop bc
	
	; Determine the next action.
	; Either stay in this news to display its next line.
	; Or move on to the next news.
	push hl ; Saving the text pointer.
	ld hl, News1_topics_line_count
	call NewsRadio_GetCurrentNewsLineCount ; Input in C, output in B.
	pop hl ; Retrieving the text pointer.
	
	call IncRadioSegment ; Input in B, output in carry.
	ld a, NEWS_RADIO
	jr c, .next_news_determined

	xor a
	ld [wNewsRadioSegmentCounter], a
	ld a, NEWS_RADIO_3
.next_news_determined
	jp NextRadioLine

NewsRadio2:
	ld hl, BuenaRadioMidnightText6
	ld a, NEWS_RADIO_3
	jp NextRadioLine

NewsRadio3:
	call NewsRadio_GetNews3Index ; Outputs index in C.

	; Display the next line of the current news.
	push bc ; Save index.
	ld hl, News3_pools
	call NewsRadio_GetNewsLine
	pop bc
	
	; Determine the next action.
	; Either stay in this news to display its next line.
	; Or move on to the next news.
	push hl ; Saving the text pointer.
	ld hl, News3_topics_line_count
	call NewsRadio_GetCurrentNewsLineCount ; Input in C, output in B.
	pop hl ; Retrieving the text pointer.

	ld a, c
	and a
	jr nz, .skip_death_count

	ld a, [wNewsRadioSegmentCounter]
	cp 1
	jr nz, .skip_death_count

	push bc
	push hl
	call GetWorldwideCovidDeathCount
	pop hl
	pop bc

.skip_death_count
	
	call IncRadioSegment ; Input in B, output in carry.
	ld a, NEWS_RADIO_3
	jr c, .next_news_determined

	xor a
	ld [wNewsRadioSegmentCounter], a
	ld a, NEWS_RADIO
.next_news_determined
	jp NextRadioLine

; Input: In B, the number of lines to be displayed for the current news.
; Output: carry if there are still more lines to be displayed.
IncRadioSegment:
	ld a, [wNewsRadioSegmentCounter]
	inc a
	ld [wNewsRadioSegmentCounter], a
	cp b
	ret

; Input: the news pool in HL, and the news index in C.
; Output: the news current text pointer in HL.
NewsRadio_GetNewsLine:
	sla c
	ld b, 0
	add hl, bc

	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wNewsRadioSegmentCounter]
	rlca ; Multiplies A by 2. Works fine because bit 7 of A is always 0.
	ld c, a
	add hl, bc

	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

News1_pools:
	dw .news1_topic0
	dw .news1_topic1
	dw .news1_topic2
	dw .news1_topic3
	dw .news1_topic4
	dw .news1_topic5
.news1_topic0
	dw .news1_topic0_line0
	dw .news1_topic0_line1
	dw .news1_topic0_line2
if DEF(_FR_FR)
	dw .news1_topic0_line3
endc
.news1_topic1
	dw .news1_topic1_line0
	dw .news1_topic1_line1
	dw .news1_topic1_line2
	dw .news1_topic1_line3
	dw .news1_topic1_line4
	dw .news1_topic1_line5
	dw .news1_topic1_line6
.news1_topic2
	dw .news1_topic2_line0
	dw .news1_topic2_line1
	dw .news1_topic2_line2
	dw .news1_topic2_line3
	dw .news1_topic2_line4
	dw .news1_topic2_line5
	dw .news1_topic2_line6
	dw .news1_topic2_line7
	dw .news1_topic2_line8
.news1_topic3
	dw .news1_topic3_line0
	dw .news1_topic3_line1
	dw .news1_topic3_line2
	dw .news1_topic3_line3
	dw .news1_topic3_line4
	dw .news1_topic3_line5
	dw .news1_topic3_line6
	dw .news1_topic3_line7
	dw .news1_topic3_line8
	dw .news1_topic3_line9
.news1_topic4
	dw .news1_topic4_line0
	dw .news1_topic4_line1
	dw .news1_topic4_line2
	dw .news1_topic4_line3
	dw .news1_topic4_line4
	dw .news1_topic4_line5
.news1_topic5
	dw .news1_topic5_line0
	dw .news1_topic5_line1
	dw .news1_topic5_line2
	dw .news1_topic5_line3
	dw .news1_topic5_line4
if DEF(_FR_FR)
	dw .news1_topic5_line5
endc

.news1_topic0_line0
	text_far _News1_Topic0_Line0
	text_end
	
.news1_topic0_line1
	text_far _News1_Topic0_Line1
	text_end
	
.news1_topic0_line2
	text_far _News1_Topic0_Line2
	text_end
	
if DEF(_FR_FR)
.news1_topic0_line3
	text_far _News1_Topic0_Line3
	text_end
endc

.news1_topic1_line0
	text_far _News1_Topic1_Line0
	text_end
	
.news1_topic1_line1
	text_far _News1_Topic1_Line1
	text_end
	
.news1_topic1_line2
	text_far _News1_Topic1_Line2
	text_end
	
.news1_topic1_line3
	text_far _News1_Topic1_Line3
	text_end
	
.news1_topic1_line4
	text_far _News1_Topic1_Line4
	text_end
	
.news1_topic1_line5
	text_far _News1_Topic1_Line5
	text_end
	
.news1_topic1_line6
	text_far _News1_Topic1_Line6
	text_end
	
.news1_topic2_line0
	text_far _News1_Topic2_Line0
	text_end
	
.news1_topic2_line1
	text_far _News1_Topic2_Line1
	text_end
	
.news1_topic2_line2
	text_far _News1_Topic2_Line2
	text_end
	
.news1_topic2_line3
	text_far _News1_Topic2_Line3
	text_end
	
.news1_topic2_line4
	text_far _News1_Topic2_Line4
	text_end
	
.news1_topic2_line5
	text_far _News1_Topic2_Line5
	text_end
	
.news1_topic2_line6
	text_far _News1_Topic2_Line6
	text_end
	
.news1_topic2_line7
	text_far _News1_Topic2_Line7
	text_end
	
.news1_topic2_line8
	text_far _News1_Topic2_Line8
	text_end
	
.news1_topic3_line0
	text_far _News1_Topic3_Line0
	text_end
	
.news1_topic3_line1
	text_far _News1_Topic3_Line1
	text_end
	
.news1_topic3_line2
	text_far _News1_Topic3_Line2
	text_end
	
.news1_topic3_line3
	text_far _News1_Topic3_Line3
	text_end
	
.news1_topic3_line4
	text_far _News1_Topic3_Line4
	text_end
	
.news1_topic3_line5
	text_far _News1_Topic3_Line5
	text_end
	
.news1_topic3_line6
	text_far _News1_Topic3_Line6
	text_end
	
.news1_topic3_line7
	text_far _News1_Topic3_Line7
	text_end
	
.news1_topic3_line8
	text_far _News1_Topic3_Line8
	text_end
	
.news1_topic3_line9
	text_far _News1_Topic3_Line9
	text_end
	
.news1_topic4_line0
	text_far _News1_Topic4_Line0
	text_end
	
.news1_topic4_line1
	text_far _News1_Topic4_Line1
	text_end
	
.news1_topic4_line2
	text_far _News1_Topic4_Line2
	text_end
	
.news1_topic4_line3
	text_far _News1_Topic4_Line3
	text_end
	
.news1_topic4_line4
	text_far _News1_Topic4_Line4
	text_end
	
.news1_topic4_line5
	text_far _News1_Topic4_Line5
	text_end
	
.news1_topic5_line0
	text_far _News1_Topic5_Line0
	text_end
	
.news1_topic5_line1
	text_far _News1_Topic5_Line1
	text_end
	
.news1_topic5_line2
	text_far _News1_Topic5_Line2
	text_end
	
.news1_topic5_line3
	text_far _News1_Topic5_Line3
	text_end
	
.news1_topic5_line4
	text_far _News1_Topic5_Line4
	text_end
	
if DEF(_FR_FR)
.news1_topic5_line5
	text_far _News1_Topic5_Line5
	text_end
endc

News3_pools:
	dw .news3_topic0
	dw .news3_topic1
.news3_topic0
	dw .news3_topic0_line0
	dw .news3_topic0_line1
	dw .news3_topic0_line2
	dw .news3_topic0_line3
	dw .news3_topic0_line4
if DEF(_FR_FR)
	dw .news3_topic0_line5
endc
.news3_topic1
	dw .news3_topic1_line0
	dw .news3_topic1_line1
	dw .news3_topic1_line2
	dw .news3_topic1_line3
	dw .news3_topic1_line4
	dw .news3_topic1_line5
	dw .news3_topic1_line6

.news3_topic0_line0
	text_far _News3_Topic0_Line0
	text_end
	
.news3_topic0_line1
	text_far _News3_Topic0_Line1
	text_end
	
.news3_topic0_line2
	text_far _News3_Topic0_Line2
	text_end
	
.news3_topic0_line3
	text_far _News3_Topic0_Line3
	text_end
	
.news3_topic0_line4
	text_far _News3_Topic0_Line4
	text_end

if DEF(_FR_FR)
.news3_topic0_line5
	text_far _News3_Topic0_Line5
	text_end
endc

.news3_topic1_line0
	text_far _News3_Topic1_Line0
	text_end
	
.news3_topic1_line1
	text_far _News3_Topic1_Line1
	text_end
	
.news3_topic1_line2
	text_far _News3_Topic1_Line2
	text_end
	
.news3_topic1_line3
	text_far _News3_Topic1_Line3
	text_end
	
.news3_topic1_line4
	text_far _News3_Topic1_Line4
	text_end
	
.news3_topic1_line5
	text_far _News3_Topic1_Line5
	text_end
	
.news3_topic1_line6
	text_far _News3_Topic1_Line6
	text_end

; Input: the news line count array address in HL, and the news index in C.
; Output: the current news line count in B.
NewsRadio_GetCurrentNewsLineCount:
	ld b, 0
	add hl, bc

	ld b, [hl]
	ret

News1_topics_line_count:
if DEF(_FR_FR)
	db 4
else
	db 3
endc
	db 7
	db 9
	db 10
	db 6
if DEF(_FR_FR)
	db 6
else
	db 5
endc

News3_topics_line_count:
if DEF(_FR_FR)
	db 6
else
	db 5
endc
	db 7

; Input: none.
; Output: the news index in C.
NewsRadio_GetNews1Index:
	ld c, 5
	ld a, [wYearMonth]
	cp $30
	ret nc

	dec c ; c = 4
	cp $23
	ret nc

	dec c ; c = 3
	ld a, [wCurFreedomState]
	bit VACCINE_PASSPORT, a
	ret nz

	dec c ; c = 2
	bit CURFEW, a
	ret nz

	dec c ; c = 1
	bit LOCKDOWN, a
	ret nz

	dec c ; c = 0
	ret

; Input: none.
; Output: the news index in C.
NewsRadio_GetNews3Index:
	ld c, 1
	ld a, [wYearMonth]
	cp $40
	ret nc

	dec c
	ret

GetWorldwideCovidDeathCount:
    ld a, [wYearMonth]

	; We clamp the value to prevent out of bounds readings.
	cp $02
	jr c, .clamp_min

	cp $3c
	jr nc, .clamp_max

	jr .get_index

.clamp_min
	ld a, $02
	jr .get_index

.clamp_max
	ld a, $3b

.get_index
    ; Starting from here, this code is added so that there is no "padding" or unused data in the death count database.
    ; The padding would be 8 bytes per year, which is 24 bytes total.
    ; As long as the code is smaller than that, we are saving bytes.
    ; CPU cycles don't matter here.
    ; We save the value of wYearMonth for later.
    ld b, a ; 1 byte.
    ; We multiply the year (upper nybble) by 4.
    and $f0 ; 2 bytes.
    rrca ; 1 byte.
    rrca ; 1 byte.
   
    ; We subtract the year multiplied by 4 to wYearMonth.
    ld c, a ; 1 byte.
    ld a, b ; 1 byte.
    sub c ; 1 byte.
    ; We are done with the added code that suppresses the padding in the database.
    ; This totals to 8 bytes. We saved 16 bytes, and created a cleaner database!

	add a ; We need to double A, as it's an array of dw. As A is 32 or lower, the doubling can never overflow A.
    ld c, a
    ld b, 0
    ld hl, .deathCountData - 2 * 2 ; As our array starts at index 2, we need to account for it.
    add hl, bc
    
	; Now that we have found the death count, we need to store it for display as a text_decimal.
	ld a, [hli]
	ld [wStringBuffer2 + 1], a
	ld a, [hl]
	ld [wStringBuffer2], a
    ret

.deathCountData ; Multiply by 1000 to get the actual value.
    dw 7    ; 0x02 March 2020
    dw 46   ; 0x03 April 2020
    dw 242  ; 0x04 May 2020
    dw 406  ; 0x05 June 2020
    dw 560  ; 0x06 July 2020
    dw 746  ; 0x07 August 2020
    dw 938  ; 0x08 September 2020
    dw 1107 ; 0x09 October 2020
    dw 1294 ; 0x0a November 2020
    dw 1584 ; 0x0b December 2020
    dw 1949 ; 0x10 January 2021
    dw 2392 ; 0x11 February 2021
    dw 2692 ; 0x12 March 2021
    dw 2980 ; 0x13 April 2021
    dw 3327 ; 0x14 May 2021
    dw 3730 ; 0x15 June 2021
    dw 4000 ; 0x16 July 2021
    dw 4269 ; 0x17 August 2021
    dw 4577 ; 0x18 September 2021
    dw 4832 ; 0x19 October 2021
    dw 5050 ; 0x1a November 2021
    dw 5265 ; 0x1b December 2021
    dw 5479 ; 0x20 January 2022
    dw 5730 ; 0x21 February 2022
    dw 6008 ; 0x22 March 2022
    dw 6189 ; 0x23 April 2022
    dw 6274 ; 0x24 May 2022
    dw 6322 ; 0x25 June 2022
    dw 6363 ; 0x26 July 2022
    dw 6431 ; 0x27 August 2022
    dw 6502 ; 0x28 September 2022
    dw 6549 ; 0x29 October 2022
    dw 6598 ; 0x2a November 2022
    dw 6641 ; 0x2b December 2022
    dw 6728 ; 0x30 January 2023
    dw 6839 ; 0x31 February 2023
    dw 6879 ; 0x32 March 2023
    dw 6905 ; 0x33 April 2023
    dw 6928 ; 0x34 May 2023
    dw 6943 ; 0x35 June 2023
    dw 6951 ; 0x36 July 2023
    dw 6957 ; 0x37 August 2023
    dw 6963 ; 0x38 September 2023
    dw 6974 ; 0x39 October 2023
    dw 6988 ; 0x3a November 2023
    dw 7000 ; 0x3b December 2023

CopyRadioTextToRAM:
	ld a, [hl]
	cp TX_FAR
	jp z, FarCopyRadioText
	ld de, wRadioText
	ld bc, 2 * SCREEN_WIDTH
	jp CopyBytes

StartRadioStation:
	ld a, [wNumRadioLinesPrinted]
	and a
	ret nz

	ld [wNewsRadioSegmentCounter], a ; a = 0
	call RadioTerminator
	call PrintText
	ld hl, RadioChannelSongs
	ld a, [wCurRadioLine]
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	callfar RadioMusicRestartDE
	ret

INCLUDE "data/radio/channel_music.asm"

NextRadioLine:
	push af
	call CopyRadioTextToRAM
	pop af
	jp PrintRadioLine
