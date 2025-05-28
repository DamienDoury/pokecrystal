	object_const_def
	const POWERPLANT_OFFICER1
	const POWERPLANT_GYM_GUIDE1
	const POWERPLANT_GYM_GUIDE2
	const POWERPLANT_OFFICER2
	const POWERPLANT_GYM_GUIDE3
	const POWERPLANT_MANAGER
	const POWERPLANT_FOREST
	const POWERPLANT_VERMILION_GYM_GUIDE
	const POWERPLANT_SURGE

PowerPlant_MapScripts:
	def_scene_scripts

	def_callbacks

PowerPlantGuardPhoneScript:
	playsound SFX_CALL
	showemote EMOTE_SHOCK, POWERPLANT_OFFICER1, 15
	waitsfx
	pause 30
	applymovement POWERPLANT_OFFICER1, PowerPlantOfficer1ApproachGymGuide2Movement
	turnobject POWERPLANT_GYM_GUIDE1, DOWN
	turnobject POWERPLANT_GYM_GUIDE2, DOWN
	turnobject PLAYER, RIGHT
	opentext
	writetext PowerPlantOfficer1CeruleanShadyCharacterText
	waitbutton
	closetext
	applymovement POWERPLANT_OFFICER1, PowerPlantOfficer1ReturnToPostMovement
	turnobject PLAYER, DOWN
	opentext
	writetext PowerPlantOfficer1CouldIAskForYourCooperationText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement POWERPLANT_OFFICER1, PowerPlantOfficer1ReturnToPostFinalMovement
	setscene SCENE_POWERPLANT_NOTHING
	end

PowerPlantOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	checkevent EVENT_MET_MANAGER_AT_POWER_PLANT
	iftrue .MetManager
	writetext PowerPlantOfficer1AThiefBrokeInText
	waitbutton
	closetext
	end

.MetManager:
	writetext PowerPlantOfficer1CouldIAskForYourCooperationText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext PowerPlantOfficer1HaveToBeefUpSecurityText
	waitbutton
	closetext
	end

PowerPlantGymGuide1Script:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext PowerPlantGymGuide1SomeoneStoleAPartText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext PowerPlantGymGuide1GeneratorUpAndRunningText
	waitbutton
	closetext
	end

PowerPlantGymGuide2Script:
	jumptextfaceplayer PowerPlantGymGuide2PowerPlantUpAndRunningText

PowerPlantOfficer2Script:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext PowerPlantOfficer2ManagerHasBeenSadAndFuriousText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext PowerPlantOfficer2ManagerHasBeenCheerfulText
	waitbutton
	closetext
	end

PowerPlantGymGuide4Script:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext PowerPlantGymGuide4MagnetTrainConsumesElectricityText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext PowerPlantGymGuide4WeCanGetMagnetTrainRunningText
	waitbutton
	closetext
	end

PowerPlantManager:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	checkitem MACHINE_PART
	iftrue .FoundMachinePart
	checkevent EVENT_MET_MANAGER_AT_POWER_PLANT
	iftrue .MetManager
	writetext PowerPlantManagerWhoWouldRuinMyGeneratorText
	waitbutton
	closetext
	setevent EVENT_MET_MANAGER_AT_POWER_PLANT
	clearevent EVENT_CERULEAN_GYM_ROCKET
	clearevent EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM
	setmapscene CERULEAN_GYM, SCENE_CERULEANGYM_GRUNT_RUNS_OUT
	setscene SCENE_POWERPLANT_GUARD_GETS_PHONE_CALL
	end

.MetManager:
	writetext PowerPlantManagerIWontForgiveCulpritText
	waitbutton
	closetext
	end

.FoundMachinePart:
	writetext PowerPlantManagerThatsThePartText
	promptbutton
	takeitem MACHINE_PART
	setevent EVENT_RETURNED_MACHINE_PART
	clearevent EVENT_TRAIN_STATION_POPULATION
	clearevent EVENT_OLIVINE_GYM_JASMINE ; Jasmine returns to her gym.
	setevent EVENT_JASMINE_AT_FUJIS
	setevent EVENT_RESTORED_POWER_TO_KANTO
	readmem wYearMonth
	addval 1
	writemem wYearMonth
.ReturnedMachinePart:
	checkevent EVENT_GOT_TM07_ZAP_CANNON
	iftrue .GotZapCannon
	writetext PowerPlantManagerTakeThisTMText
	promptbutton
	verbosegiveitem TM_ZAP_CANNON
	iffalse .NoRoom
	setevent EVENT_GOT_TM07_ZAP_CANNON
	writetext PowerPlantManagerTM07IsZapCannonText
	waitbutton
.NoRoom:
	closetext
	end

.GotZapCannon:
	writetext PowerPlantManagerMyBelovedGeneratorText
	waitbutton
	closetext
	end

Forest:
	faceplayer
	opentext
	trade NPC_TRADE_FOREST
	waitbutton
	closetext
	end

PowerPlantVermilionGymGuideScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .power_restored
	jumptextfaceplayer PowerPlantVermilionGymGuideText

.power_restored
	jumptextfaceplayer PowerPlantVermilionGymGuidePowerRestoredText

PowerPlantSurgeScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse .do_it

	jumptextfaceplayer PowerPlantSurgeMissionCompletedText

.do_it
	applymovement POWERPLANT_SURGE, PowerPlantStompLeftMovement
	opentext
	writetext PowerPlantSurgeText
	waitbutton
	closetext
	pause 5

PowerPlantRaichu:
	setval RAICHU
	loadmem wPowerPlantMoveSFX, SFX_THUNDERSHOCK
	loadmem wPowerPlantEarthquakeDuration, 42
	sjump PowerPlantThunderAnim

PowerPlantElectrode:
	setval ELECTRODE
	loadmem wPowerPlantMoveSFX, SFX_THUNDER
	loadmem wPowerPlantEarthquakeDuration, 36
	sjump PowerPlantThunderAnim

PowerPlantMagneton:
	setval MAGNETON
	loadmem wPowerPlantMoveSFX, SFX_ZAP_CANNON
	loadmem wPowerPlantEarthquakeDuration, 16
	sjump PowerPlantThunderAnim

PowerPlantElectabuzz:
	setval ELECTABUZZ
	loadmem wPowerPlantMoveSFX, SFX_THUNDER
	loadmem wPowerPlantEarthquakeDuration, 36
	sjump PowerPlantThunderAnim

PowerPlantJolteon:
	setval JOLTEON
	loadmem wPowerPlantMoveSFX, SFX_THUNDERSHOCK
	loadmem wPowerPlantEarthquakeDuration, 42

PowerPlantThunderAnim:
	getmonname STRING_BUFFER_3, USE_SCRIPT_VAR
	opentext
	writetext PowerPlantPokemonShoutText
	cry USE_SCRIPT_VAR
	waitsfx
	pause 5
	closetext

	pause 5

	readmem wPowerPlantMoveSFX
	playsound SFX_FROM_MEM
	readmem wPowerPlantEarthquakeDuration
	earthquake USE_SCRIPT_VAR
	waitsfx
	end

PowerPlantBookshelf:
	jumpstd DifficultBookshelfScript

PowerPlantOfficer1ApproachGymGuide2Movement:
	step RIGHT
	step RIGHT
	step UP
	step_end

PowerPlantOfficer1ReturnToPostMovement:
	step DOWN
	step LEFT
	turn_head UP
	step_end

PowerPlantOfficer1ReturnToPostFinalMovement:
	step LEFT
	turn_head DOWN
	step_end

PowerPlantStompLeftMovement:
	turn_step LEFT
	step_bump
	step_end

PowerPlantOfficer1AThiefBrokeInText: 
if DEF(_FR_FR)
	text "Un voleur s'est"
	line "introduit dans la"
	cont "CENTRALE..."

	para "Mais où va le"
	line "monde? Hein?"
else
	text "A thief broke into"
	line "the POWER PLANT…"

	para "What is the world"
	line "coming to?"
endc

	done

PowerPlantOfficer1CeruleanShadyCharacterText: 
if DEF(_FR_FR)
	text "On raconte des"
	line "trucs à AZURIA."

	para "Un drôle de type"
	line "rôde dans les"

	para "environs..."
	line "C'est flippant."
else
	text "I just got word"
	line "from CERULEAN."

	para "It appears that a"
	line "shady character"

	para "has been loitering"
	line "around."
endc

	done

PowerPlantOfficer1CouldIAskForYourCooperationText: 
if DEF(_FR_FR)
	text "Tu veux bien"
	line "m'aider?"
else
	text "Could I ask for"
	line "your cooperation?"
endc

	done

PowerPlantOfficer1HaveToBeefUpSecurityText: 
if DEF(_FR_FR)
	text "Il faut renforcer"
	line "la sécurité."
else
	text "We'll have to beef"
	line "up our security"
	cont "presence."
endc

	done

PowerPlantGymGuide1SomeoneStoleAPartText: 
if DEF(_FR_FR)
	text "Quelqu'un a volé"
	line "une partie essen-"

	para "tielle du généra-"
	line "teur."

	para "Sans elle, rien"
	line "ne marche!"
else
	text "Someone made off"
	line "with a part that's"

	para "essential for the"
	line "generator."

	para "Without it, the"
	line "new generator's"
	cont "useless!"
endc

	done

PowerPlantGymGuide1GeneratorUpAndRunningText: 
if DEF(_FR_FR)
	text "Le générateur est"
	line "en marche. Il crée"

	para "de l'électricité"
	line "à gogo."
else
	text "The generator's up"
	line "and running. It's"

	para "making electricity"
	line "to spare."
endc

	done

PowerPlantGymGuide2PowerPlantUpAndRunningText: ; TO TRANSLATE
	text "This POWER PLANT"
	line "had been abandoned"
	cont "in the past."

	para "A mythical #MON"
	line "that is the incar-"
	cont "nation of thunder"
	cont "took it over."

	para "A trainer named"
	line "RED cast the"
	cont "creature out"
	cont "4 years ago."

	para "Now we can"
	line "operate again."
	done

PowerPlantOfficer2ManagerHasBeenSadAndFuriousText: 
if DEF(_FR_FR)
	text "Le PATRON de la"
	line "CENTRALE est plus"
	cont "loin."

	para "Attention, il est"
	line "furax depuis que"
	cont "quelqu'un a tout"
	cont "bousillé son joli"
	cont "générateur..."
else
	text "The POWER PLANT's"
	line "MANAGER is up"
	cont "ahead."

	para "But since someone"
	line "wrecked the gener-"
	cont "ator, he's been"
	cont "both sad and"
	cont "furious…"
endc

	done

PowerPlantOfficer2ManagerHasBeenCheerfulText: 
if DEF(_FR_FR)
	text "Depuis la répara-"
	line "tion du générateur"

	para "le PATRON est très"
	line "heureux."
else
	text "Since the gener-"
	line "ator's been fixed,"

	para "the MANAGER has"
	line "been cheerful."
endc

	done

PowerPlantGymGuide4MagnetTrainConsumesElectricityText: 
if DEF(_FR_FR)
	text "Le TRAIN MAGNET"
	line "consomme beaucoup"
	cont "d'électricité."

	para "Il ne bougera pas"
	line "si le nouveau gé-"
	cont "nérateur ne marche"
	cont "pas..."
else
	text "The MAGNET TRAIN"
	line "consumes a lot of"
	cont "electricity."

	para "It can't move if"
	line "the new generator"
	cont "isn't operating."
endc

	done

PowerPlantGymGuide4WeCanGetMagnetTrainRunningText: 
if DEF(_FR_FR)
	text "OK! On peut à nou-"
	line "veau faire marcher"
	cont "le TRAIN MAGNET."
else
	text "All right! We can"
	line "finally get the"

	para "MAGNET TRAIN"
	line "running again."
endc

	done

PowerPlantManagerWhoWouldRuinMyGeneratorText: 
if DEF(_FR_FR)
	text "PATRON: J'vais"
	line "exploser! Faut que"
	cont "j'me défoule!"

	para "Qui a cassé mon"
	line "générateur? Qui?"

	para "Je l'aimais tant!"
	line "Comme mon bébé!"

	para "Si j'attrape cette"
	line "crapule, il aura"

	para "droit à un coup"
	line "d'ELECANON!"
else
	text "MANAGER: I, I, I'm"
	line "ready to blast"
	cont "someone!"

	para "Who would dare"
	line "ruin my generator?"

	para "I spent so much"
	line "time on it!"

	para "If I catch him,"
	line "he's going to get"

	para "a taste of my ZAP"
	line "CANNON!"
endc

	done

PowerPlantManagerIWontForgiveCulpritText: 
if DEF(_FR_FR)
	text "PATRON: Je vais"
	line "m'le faire!"

	para "Même s'il pleure,"
	line "même s'il prie,"

	para "je vais quand même"
	line "me l'faire!"

	para "Gahahahah!"
else
	text "MANAGER: I won't"
	line "forgive him!"

	para "The culprit can"
	line "cry and apologize,"

	para "but I'll still"
	line "hammer him!"

	para "Gahahahah!"
endc

	done

PowerPlantManagerThatsThePartText: 
if DEF(_FR_FR)
	text "PATRON: Ah! Oui!"

	para "C'est la PARTIE"
	line "manquante de mon"
	cont "joli générateur!"
	cont "Tu l'as trouvée?"
else
	text "MANAGER: Ah! Yeah!"

	para "That's the missing"
	line "PART from my be-"
	cont "loved generator!"
	cont "You found it?"
endc

	done

PowerPlantManagerTakeThisTMText: 
if DEF(_FR_FR)
	text "Wahah! Merci!"

	para "Tiens! Prends"
	line "cette CT!"
else
	text "Wahah! Thanks!"

	para "Here! Take this TM"
	line "as a reward!"
endc

	done

PowerPlantManagerTM07IsZapCannonText: 
if DEF(_FR_FR)
	text "PATRON: CT07 est"
	line "l'ELECANON. C'est"

	para "une technique"
	line "très puissante!"

	para "Elle n'est pas"
	line "très précise mais"

	para "elle dépote! Fais-"
	line "moi confiance!"
else
	text "MANAGER: TM07 is"
	line "my ZAP CANNON."

	para "It's a powerful"
	line "technique!"

	para "It's not what any-"
	line "one would consider"

	para "accurate, but it"
	line "packs a wallop!"
endc

	done

PowerPlantManagerMyBelovedGeneratorText: 
if DEF(_FR_FR)
	text "PATRON: Mon petit"
	line "générateur chéri!"

	para "Pompe l'électrici-"
	line "té! Allez! Tu dois"
	cont "pomper!"
else
	text "MANAGER: My be-"
	line "loved generator!"

	para "Keep pumping the"
	line "electricity out!"
endc

	done

PowerPlantVermilionGymGuideText: ; TO TRANSLATE
	text "Yo CHAMP!"

	para "LT.SURGE is our"
	line "saviour."

	para "His #MON squad"
	line "is strong enough"
	
	para "to provide emer-"
	line "gency power for"
	cont "all of KANTO!"
	done

PowerPlantVermilionGymGuidePowerRestoredText: ; TO TRANSLATE
	text "Yo CHAMP!"

	para "You did an amazing"
	line "job here!"

	para "I guess we'll see"
	line "you at VERMILION"
	cont "GYM."
	done

PowerPlantSurgeText: ; TO TRANSLATE
	text "SURGE: DO IT!"

	para "JUST DO IT!!"
	done

PowerPlantSurgeMissionCompletedText: ; TO TRANSLATE
	text "SURGE: So it's over"
	line "hey?"
	
	para "Mission completed,"
	line "gotta get back"
	cont "to base camp."
	done

PowerPlantPokemonShoutText: ; TO TRANSLATE
	text "@"
	text_ram wStringBuffer3
	text ": !!!"
	done

PowerPlant_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2, 17, ROUTE_10_NORTH, 2
	warp_event  3, 17, ROUTE_10_NORTH, 2

	def_coord_events
	coord_event  5, 12, CE_SCENE_ID, SCENE_POWERPLANT_GUARD_GETS_PHONE_CALL, PowerPlantGuardPhoneScript

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, PowerPlantBookshelf
	bg_event  1,  1, BGEVENT_READ, PowerPlantBookshelf

	def_object_events
	object_event  4, 14, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PowerPlantOfficerScript, -1
	object_event  2,  9, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PowerPlantGymGuide1Script, -1
	object_event  6, 11, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PowerPlantGymGuide2Script, -1
	object_event  9,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PowerPlantOfficer2Script, -1
	object_event  7,  2, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PowerPlantGymGuide4Script, -1
	object_event 14, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PowerPlantManager, -1
	object_event  5,  5, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Forest, -1
	object_event 19, 14, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PowerPlantVermilionGymGuideScript, EVENT_RESTORED_POWER_TO_KANTO
	object_event 15, 16, SPRITE_SURGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, PowerPlantSurgeScript, EVENT_RESTORED_POWER_TO_KANTO
	object_event 14, 16, SPRITE_RAICHU, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PowerPlantRaichu, EVENT_RESTORED_POWER_TO_KANTO
	object_event 17, 10, SPRITE_ELECTRODE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PowerPlantElectrode, EVENT_RESTORED_POWER_TO_KANTO
	object_event 13,  4, SPRITE_MAGNETON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_SILVER, OBJECTTYPE_SCRIPT, 0, PowerPlantMagneton, EVENT_RESTORED_POWER_TO_KANTO
	object_event 16,  4, SPRITE_ELECTABUZZ, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, PowerPlantElectabuzz, EVENT_RESTORED_POWER_TO_KANTO
	object_event 12, 10, SPRITE_JOLTEON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, PowerPlantJolteon, EVENT_RESTORED_POWER_TO_KANTO
