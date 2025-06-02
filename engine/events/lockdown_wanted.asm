; Returns in a the wanted level at the current landmark (as indicated by wCurLandmark).
; Returns the address hl where the information is stored.
; Returns the offset within the byte in b.
; Updates [wCurLandmark] (because it's never done at this point).
; Destroys c.
GetCurrentResearchLevelAtLandmark::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call GetWorldMapLocation
	ld [wCurLandmark], a
	cp KANTO_LANDMARK + 1
	ld c, 0
	jr nc, .masking

	ld c, a
	srl c
	srl c ; We divide the landmark ID by four, and floor the result, to know in which byte the wanted level is stored.
	ld b, 0
	ld hl, wWantedLevelPerLandmark
	add hl, bc
	; Here in hl we have the address of the byte we will read and write into, so we can freely use a, b and c.
	ld c, [hl] ; c contains the byte where the wanted level of this landmark is stored.

	and $03 ; We mask the last 2 bits of the a register to know at what offset the wanted level is stored within its byte.
	ld b, a ; We store a for later use.

.offset
	cp 0
	jr z, .masking
	dec a
	srl c
	srl c ; We shift by 1 landmark.
	jr .offset

.masking
	ld a, c
	and $03
	ld [wCurWantedLevel], a
	ret

; This is called after a won battle against a trainer.
; Destroys a, b, c and hl.
IncreaseResearchLevel::
	ld a, [wCurLandmark]
	cp KANTO_LANDMARK + 1
	ret nc

	call GetCurrentResearchLevelAtLandmark

	ld a, [wOtherTrainerClass]
	cp OFFICER
	ret c ; Only a won battle against an OFFICER (or SERGEANT or JENNY) can increase the research level.
	cp SWAT
	ret nc ; do not increase for SWAT (max wanted lvl already).

	ld a, [wCurLandmark]
	cp LANDMARK_ROUTE_45
	jr nc, .force_increase ; We force the level increase in the last roads.

	call ShouldResearchLevelBeIncreased
	ret c

.force_increase
	; level_increase
	ld a, [wCurWantedLevel]
	inc a
	ld [wCurWantedLevel], a
	ld c, a
	ld a, b ; B is retrieved from GetCurrentResearchLevelAtLandmark.
	ld b, %11111100 ; We now use b as the mask.

.offset
	cp 0
	jr z, .write_level
	dec a
	sla c
	sla c ; We shift by 1 landmark.
	rlc b
	rlc b ; We also shift the mask by 1 landmark (2 bits).
	jr .offset

.write_level
	ld a, [hl] ; HL is retrieved from GetCurrentResearchLevelAtLandmark.
	and b
	add c
	ld [hl], a

	; Also, we first the leftmost bit of the wCurFreedomState byte to notify that we just increased the wanted level (used and erased by RefreshPolice in warp_connection.asm to reload the map).
	ld a, [wCurWantedLevel]
	or %10000000
	ld [wCurWantedLevel], a
	ret

; Output: Carry if it should be increased. nc otherwise.
ShouldResearchLevelBeIncreased::
	ld a, [wCurWantedLevel]
	and a
	ret z ; Returns true. Backup is always called at level 0.

	cp 3
	jr z, .return_false ; Backup can never be called at level 3.
	
	cp 2
	jr z, .level2

;.level1 ; If the wanted level is 1, there is 75% odds that backup will be called.
	push hl
	farcall GetRandomPoliceSeed
	pop hl
	ldh a, [hDivisor]
	and %00000011
	jr nz, .return_true
	jr .return_false
	
.level2 ; The odds are 50% at level 2.
	push hl
	farcall GetRandomPoliceSeed
	pop hl
	ldh a, [hDivisor]
	and %00000011
	jr z, .return_true
	cp %00000011
	jr z, .return_true
	; fallthrough

.return_false
	scf
	ret

.return_true
	xor a
	ret

ResetResearchLevelInCurrentLandmark::
	ld a, [wCurLandmark]
	cp KANTO_LANDMARK + 1
	ret nc

	ld a, [wOtherTrainerClass]
	cp OFFICER
	ret c ; Only a won battle against an OFFICER (or SERGEANT or JENNY) can increase the research level.
	cp SWAT + 1
	ret nc ; do not increase for SWAT (max wanted lvl already).

	call GetCurrentResearchLevelAtLandmark

	xor a
	ld [wCurWantedLevel], a
	ld c, a
	ld a, b
	ld b, %11111100 ; We now use b as the mask.

.offset
	cp 0
	jr z, .write_level
	dec a
	sla c
	sla c ; We shift by 1 landmark.
	rlc b
	rlc b ; We also shift the mask by 1 landmark (2 bits).
	jr .offset

.write_level
	ld a, [hl]
	and b
	add c
	ld [hl], a
	ret

ResetAllResearchLevels::
	ld hl, wWantedLevelPerLandmark
	ld bc, NUM_LANDMARKS_QUARTER + 1 ; We add 1 to also reset wCurWantedLevel.
	xor a
	jmp ByteFill ; ; fill bc bytes with the value of a, starting at hl

GetOlivineCafeSalad:
	ld a, [wCurDay]
	ld b, 7
	call Modulo
	ld c, a
	ld b, 0
	ld hl, OlivineCafeBerries
	add hl, bc
	ld a, [hli]
	ld [wScriptVar], a
	ld [wOlivineCafeBerry1], a
	ld a, [hli]
	ld [wOlivineCafeBerry2], a
	ld a, [hli]
	ld [wOlivineCafeBerry3], a
	ret

OlivineCafeBerries:
	db PSNCUREBERRY
	db BURNT_BERRY
	db GOLD_BERRY
	db PRZCUREBERRY
	db MINT_BERRY
	db MYSTERYBERRY
	db BITTER_BERRY
	db PSNCUREBERRY
	db BURNT_BERRY

ApplyCurfewStateBasedOnTime::
	ld de, ENGINE_FLYPOINT_VERMILION ; Curfew stops once the player reaches Vermilion.
	farcall CheckEngineFlag
	ret nc ; If the flag is set, we don't edit the freedom state.

	ld b, CHECK_FLAG
	ld de, EVENT_FIRST_CURFEW_STARTED
	call EventFlagAction
	ld a, c
	and a
	ret z ; If the curfew hasn't started yet, we return.

	ld a, [wTimeOfDay]
	cp NITE_F
	jr z, .curfew

; .freedom
	ld a, 1 << FREE
	ld [wCurFreedomState], a

	jmp ResetAllResearchLevels

.curfew
	ld a, 1 << CURFEW
	ld [wCurFreedomState], a
	ret

DisplayRandomPoliceSeenText::
	farcall GetRandomPoliceSeed
	ldh a, [hDivisor]
	ld hl, PoliceSeenTextPool
	jr DisplayRandomPoliceBattleText

DisplayRandomPoliceBeatenText::
	ld a, [wCurWantedLevel]
	and %10000000
	jr nz, DisplayPoliceBackupText

	farcall GetRandomPoliceSeed
	ldh a, [hDivisor]
	ld c, a
	swap a
	xor c
	ld hl, PoliceBeatenTextPool

DisplayRandomPoliceBattleText:
	and $f
	add a
	ld c, a
	ld b, 0
	add hl, bc

	ld a, BANK(PoliceSeenTextPool)
	call GetFarWord ; retrieve a word from a:hl, and return it in hl.

	ld b, BANK(PoliceSeenTextPool)
	jmp MapTextbox

DisplayPoliceBackupText:
	ld a, BANK(PoliceSeenTextPool)
	call GetFarWord ; retrieve a word from a:hl, and return it in hl.

	ld hl, PoliceBeatenBackupText
	ld b, BANK(PoliceBeatenBackupText)
	jmp MapTextbox

ResetWantedLevelsTheNextDay::
	; Note: the wanted level will reset twice per night during the curfew, but it is acceptable.

	ld a, 1
	ldh [hWriteByte], a
	ld a, BANK(wMustResetWantedLevels)
	ld hl, wMustResetWantedLevels
	jmp WriteFarWRAMByte

CheckResetWantedLevels::
	ld a, BANK(wMustResetWantedLevels)
	ld hl, wMustResetWantedLevels
	call GetFarWRAMByte
	and a
	ret z

	xor a
	ldh [hWriteByte], a
	ld a, BANK(wMustResetWantedLevels)
	ld hl, wMustResetWantedLevels
	call WriteFarWRAMByte

	jmp ResetAllResearchLevels

VaccinePassportControllerChatScript::
	jumptextfaceplayer .dialog ; This happens way after the clapping, so no issue here.

.dialog
if DEF(_FR_FR)
	text "Je scanne les"
	line "CARTES DRESSEUR"
	cont "pour vérifier le"
	cont "PASS VACCINAL."

	para "Seules les per-"
	line "sonnes entièrement"
	cont "vaccinées, et"
	cont "portant un MASQUE"
	cont "sont admises."
	done
else
	text "I scan TRAINER"
	line "CARDS to check for"
	cont "VACCINE PASSPORTS."

	para "Only fully vacci-"
	line "nated people wear-"
	cont "ing a face mask"
	cont "are allowed in."
	done
endc


TravelControllerChatScript::
	faceplayer
	readmem wMap1ObjectTimeOfDay ; Note: the travel controller must always be the first map_object in its map!
	ifequal %11100000 | DAY | NITE, .morning_pause
	ifequal %11100000 | MORN | NITE, .day_pause
	ifequal %11100000 | MORN | DAY, .night_pause
	ifequal %11100000 | MORN, .morning_only
	; ifequal -1 -> always
	; Default.
.always
	jumptext TravelControllerAlwaysText

.morning_pause
	jumptext TravelControllerMorningPauseText

.day_pause
	jumptext TravelControllerDayPauseText

.night_pause
	jumptext TravelControllerNightPauseText

.morning_only
	jumptext TravelControllerMorningOnlyText

ArrestPlayerForTravellingScript::
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	readmem wPreventTrainerBattles
	ifequal $1, .end
endc

	readmem wMap1ObjectStructID
	ifequal $ff, .end

	readmem wMap1ObjectScript
	ifnotequal LOW(TravelController), .end

	readmem wMap1ObjectScript + 1
	ifnotequal HIGH(TravelController), .end

	loadmem wLandmarkSignTimer, 0 ; Hiding the Landmark Sign.
	pause 10
	turnobject 2, LEFT
	showemote EMOTE_SHOCK, 2, 15 ; Shows emote over the policeman's head.
	turnobject PLAYER, RIGHT

	opentext
	readmem wTravelViolationFine
	ifgreater 0, .not_the_first_time
	writetext TravelBanWarningText
	sjump .continue

.not_the_first_time
	writetext TravelBanArrestText
.continue
	waitbutton
	closetext

	applymovement 2, .stepLeftMovement
	special FadeOutPalettes
	special ClearBGPalettes
	special FadeOutMusic
	pause 20
	playsound SFX_ENTER_DOOR
	waitsfx
	pause 30
	warpfacing RIGHT, ECRUTEAK_POLICE_STATION, 7, 5
	special FadeInPalettes

	pause 10
	opentext
	special PlaceMoneyTopRight

	loadmem wCurLandmark, -1 ; Making the map act as a GATE for the purpose of the Landmark Sign.

	readmem wTravelViolationFine
	ifgreater 0, .pay_fine

	loadmem wTravelViolationFine, 1
	writetext TravelFineText1
	waitbutton
	closetext	
.end
	end

.pay_fine
	checkmoney YOUR_MONEY, $ffffff ; This is only used to call LoadMoneyAmountToMem which updates hMoneyTemp.
	writetext TravelFineText1Bis
	promptbutton
	readmem wTravelViolationFine
	takemoney YOUR_MONEY, $ffffff
	waitsfx
	playsound SFX_TRANSACTION
	pause 15
	special PlaceMoneyTopRight
	pause 5
	writetext TravelFineText2
	waitbutton
	closetext

	;pause 3
	;turnobject PLAYER, DOWN

	; Increasing the fine for next time the player gets caught.
	readmem wTravelViolationFine
	ifgreater 99, .save_fine
	ifgreater 4, .high_increase
; low_increase:
	addval 2
	sjump .save_fine

.high_increase
	addval 5
.save_fine
	writemem wTravelViolationFine
	end

.stepLeftMovement:
	step LEFT
	step_end

TravelBanWarningText:
if DEF(_FR_FR)
	text "Ha! Pris en"
	line "flagrant délit!"

	para "Tu as enfreint"
	line "l'interdiction"
	cont "de voyager."

	para "..."

	para "Tu en as entendu"
	line "parler... non?"

	para "Tu vis dans une"
	line "grotte ou quoi?"

	para "..."

	para "Je t'emmène au"
	line "POSTE DE POLICE."

	para "On doit faire un"
	line "test PCR afin de"
	cont "s'assurer que tu"
	cont "n'apportes pas le"
	cont "virus d'ailleurs."
	done
else
	text "Ha! Caught you"
	line "red handed!"

	para "You've violated"
	line "the travel"
	cont "restriction."

	para "…"

	para "You must have"
	line "heard about it…"
	cont "don't you?"
	
	para "Are you living"
	line "under a rock?"

	para "…"

	para "I'm taking you to"
	line "the police station"
	cont "anyway."

	para "We must conduct a"
	line "PCR test to check"
	cont "that you are not"
	cont "bringing the virus"
	cont "from afar."
	done
endc

TravelBanArrestText:
if DEF(_FR_FR)
	text "ARRETEZ-VOUS!"

	para "Pris en train"
	line "d'enfreindre"
	cont "l'interdiction"
	cont "de voyager."

	para "Vous êtes en état"
	line "d'arrestation."
	
	para "Suivez-moi."
	done
else
	text "STOP RIGHT HERE!"

	para "You have been"
	line "caught violating"
	cont "the travel ban."

	para "You are under"
	line "arrest."

	para "I'm taking you"
	line "with me."
	done
endc

TravelFineText1:
if DEF(_FR_FR)
	text "POLICIER: Je ne"
	line "t'ai jamais vu ici."

	para "Je passe l'éponge"
	line "pour cette fois."

	para "Considère que c'est"
	line "un avertissement."

	para "La prochaine fois"
	line "que je te vois, ce"
	cont "sera une amende."
	done
else
	text "OFFICER: I've never"
	line "seen you here."

	para "I'll let it slide"
	line "for this time."

	para "Consider this your"
	line "warning call."

	para "Next time I see"
	line "you, it's a fine."
	done
endc

TravelFineText1Bis:
if DEF(_FR_FR)
	text "POLICIER: Le dos-"
	line "sier indique que"
	
	para "ce n'est pas la"
	line "première fois que"
	cont "tu enfreins"
	cont "l'interdiction de"
	cont "voyager..."

	para "Ton amende sera"
	line "de @"
	text_decimal hMoneyTemp, 3, 6
	text "¥."
	done
else
	text "OFFICER: The file"
	line "says that it's not"
	
	para "the first time you"
	line "violate the travel"
	cont "restriction…"

	para "Your fine will be"
	line "¥@"
	text_decimal hMoneyTemp, 3, 6
	text "."
	done
endc

TravelFineText2:
if DEF(_FR_FR)
	text "Ton test PCR"
	line "est négatif."

	para "Tu es libre"
	line "de partir."
	done
else
	text "Your PCR test"
	line "was negative."

	para "You're free to go."
	done
endc

TravelControllerAlwaysText:
if DEF(_FR_FR)
	text "Ne fais pas gaffe"
	line "à moi."

	para "Je suis ici pour"
	line "faire appliquer"
	cont "l'interdiction de"
	cont "voyager."

	para "J'arrête seulement"
	line "les dresseurs qui"
	cont "utilisent VOL ou"
	cont "TELEPORT."
	done
else
	text "Don't mind me."
	line "I'm here to enforce"
	cont "the travel ban."

	para "I only arrest"
	line "trainers that use"
	cont "FLY or TELEPORT."
	done
endc

TravelControllerMorningOnlyText:
if DEF(_FR_FR)
	text "Cette ville est"
	line "un trou paumé!"

	para "Je veille au"
	line "respect de"
	cont "l'interdiction de"
	cont "voyager,"
	
	para "mais comme"
	line "personne ne vient"
	cont "ici, je ne bosse"
	cont "que la demie-"
	cont "journée."
	done
else
	text "This town's in the"
	line "middle of nowhere!"

	para "I make sure that"
	line "people respect the"
	cont "travel restriction"
	
	para "but as no one"
	line "comes here anyway,"
	cont "I only work half"
	cont "of the day."
	done
endc

TravelControllerMorningPauseText:
if DEF(_FR_FR)
	text "Je suis contrôleur"
	line "de l'interdiction"
	cont "de voyager, et j'ai"
	cont "besoin d'un café."

	para "Je fais tellement"
	line "d'heures que je"
	cont "peine à me lever"
	cont "chaque matin..."
	done
else
	text "I'm a long-distance"
	line "travel controller,"
	cont "and I need coffee."

	para "I'm working so many"
	line "hours that it's"
	cont "hard to wake up"
	cont "every morning…"
	done
endc

TravelControllerDayPauseText:
if DEF(_FR_FR)
	text "Tu es au courant"
	line "de l'interdiction"
	cont "de voyager?"

	para "Je reste ici toute"
	line "la nuit jusqu'à"
	cont "tard le matin,"
	
	para "pour m'assurer que"
	line "tout le monde la"
	cont "respecte."
	done
else
	text "Have you heard"
	line "about the travel"
	cont "restriction?"

	para "I'm staying here"
	line "all night long"
	cont "until late morning"
	
	para "to make sure"
	line "people respect it."
	done
endc

TravelControllerNightPauseText:
if DEF(_FR_FR)
	text "Je traque les gens"
	line "qui utilisent VOL"
	cont "ou TELEPORT malgré"
	cont "l'interdiction."

	para "Mon secret pour"
	line "rester vigilant"
	cont "toute la journée?"
	
	para "Une bonne nuit"
	line "de sommeil!"
	done
else
	text "I search for"
	line "trainers that use"
	cont "FLY or TELEPORT"
	cont "despite the ban."

	para "My secret for"
	line "staying vigilant"
	cont "all day long?"
	
	para "A good night's"
	line "sleep!"
	done
endc
