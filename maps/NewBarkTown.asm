	object_const_def
	const NEWBARKTOWN_TEACHER
	const NEWBARKTOWN_FISHER
	const NEWBARKTOWN_SILVER

NewBarkTown_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_NEW_BARK
	clearevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	endcallback

FakeSilverScript:
	checkevent EVENT_RIVAL_NEW_BARK_TOWN
	iftrue .quit
	sjump NewBarkTownSilverScript
.quit:
	opentext
	writetext FootstepsText
	promptbutton
	closetext
	end

NewBarkTown_TeacherStopsYouScene1:
	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_TEACHER, LEFT
	opentext
	writetext Text_WaitPlayer
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherRunsToYouMovement1
	opentext
	writetext Text_WhatDoYouThinkYoureDoing
	waitbutton
	closetext
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherBringsYouBackMovement1
	stopfollow
	opentext
	writetext Text_ItsDangerousToGoAlone
	waitbutton
	closetext
	special RestartMapMusic
	end

NewBarkTown_TeacherStopsYouScene2:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .end

	playmusic MUSIC_MOM
	turnobject NEWBARKTOWN_TEACHER, LEFT
	opentext
	writetext Text_WaitPlayer
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherRunsToYouMovement2
	opentext
	writetext Text_WhatDoYouThinkYoureDoing
	waitbutton
	closetext
	follow NEWBARKTOWN_TEACHER, PLAYER
	applymovement NEWBARKTOWN_TEACHER, NewBarkTown_TeacherBringsYouBackMovement2
	stopfollow
	opentext
	writetext Text_ItsDangerousToGoAlone
	waitbutton
	closetext
	special RestartMapMusic
.end
	end

NewBarkTownTeacherScript:
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .CallMom
	checkevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	iftrue .TellMomYoureLeaving
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .MonIsAdorable
	jumptextfaceplayer Text_GearIsImpressive

.MonIsAdorable:
	jumptextfaceplayer Text_YourMonIsAdorable

.TellMomYoureLeaving:
	jumptextfaceplayer Text_TellMomIfLeaving

.CallMom:
	jumptextfaceplayer Text_CallMomOnGear

NewBarkTownFisherScript:
	jumptextfaceplayer Text_ElmDiscoveredNewMon

NewBarkTownSilverScript:
	opentext
	writetext NewBarkTownRivalText1
	waitbutton
	closetext
	turnobject NEWBARKTOWN_SILVER, LEFT
	opentext
	writetext NewBarkTownRivalText2
	waitbutton
	closetext
	follow PLAYER, NEWBARKTOWN_SILVER
	applymovement PLAYER, NewBarkTown_SilverPushesYouAwayMovement
	stopfollow
	pause 5
	turnobject NEWBARKTOWN_SILVER, DOWN
	pause 5
	playsound SFX_TACKLE
	applymovement PLAYER, NewBarkTown_SilverShovesYouOutMovement
	applymovement NEWBARKTOWN_SILVER, NewBarkTown_SilverReturnsToTheShadowsMovement
	end

NewBarkTownSign:
	jumptext NewBarkTownSignText

NewBarkTownPlayersHouseSign:
	jumptext NewBarkTownPlayersHouseSignText

NewBarkTownElmsLabSign:
	jumptext NewBarkTownElmsLabSignText

NewBarkTownElmsHouseSign:
	jumptext NewBarkTownElmsHouseSignText

if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
; TO DELETE!
CheatGuyScript: 
	checkmoney YOUR_MONEY, 100000
	iffalse .skip_money ; Prevents overflow.
	givemoney YOUR_MONEY, 200000
.skip_money 
	setval $ff
	writemem wVisitedSpawns
	writemem wVisitedSpawns + 1
	writemem wVisitedSpawns + 2
	writemem wVisitedSpawns + 3
	writemem wTMsHMs
	writemem wTMsHMs + 1
	writemem wTMsHMs + 2
	writemem wTMsHMs + 3
	writemem wTMsHMs + 4
	writemem wTMsHMs + 5
	writemem wTMsHMs + 6
	setval $7 ; We don't want to overflow.
	writemem wTMsHMs + 7

	giveitem MAX_REPEL, 99
	giveitem ESCAPE_ROPE, 99
	giveitem MAX_REVIVE, 99
	giveitem FULL_RESTORE, 99
	giveitem MAX_ELIXER, 99
	giveitem GOLD_BERRY, 99
	giveitem MASTER_BALL, 99
	giveitem POKE_BALL, 99
	giveitem GREAT_BALL, 99
	giveitem ULTRA_BALL, 99
	giveitem HEAVY_BALL, 99
	giveitem LOVE_BALL, 99
	giveitem RARE_CANDY, 99
	giveitem RARE_CANDY, 99
	giveitem RARE_CANDY, 99
	giveitem SURF_MAIL, 10
	giveitem BICYCLE, 1
	giveitem SUPER_ROD, 1
	giveitem GOOD_ROD, 1
	giveitem OLD_ROD, 1
	giveitem SQUIRTBOTTLE, 1
	giveitem ITEMFINDER, 1
	giveitem EXP_SHARE, 10
	giveitem HELIX_FOSSIL, 3
	giveitem MOON_STONE, 9
	giveitem FIRE_STONE, 9
	giveitem THUNDERSTONE, 9
	giveitem WATER_STONE, 9
	giveitem LEAF_STONE, 9
	giveitem SUN_STONE, 9

	opentext
	readvar VAR_PARTYCOUNT
	ifequal 6, .done
	givepoke CHARIZARD, 100

	readvar VAR_PARTYCOUNT
	ifequal 6, .done
	givepoke KINGDRA, 100

	readvar VAR_PARTYCOUNT
	ifequal 6, .done
	givepoke MISDREAVUS, 100

	readvar VAR_PARTYCOUNT
	ifequal 6, .done
	givepoke MACHAMP, 100

	readvar VAR_PARTYCOUNT
	ifequal 6, .done
	givepoke SLOWBRO, 100

	loadmem wPartyMon1Moves, FLY
	loadmem wPartyMon2Moves, SURF

	setflag ENGINE_RADIO_CARD
	setflag ENGINE_MAP_CARD
	setflag ENGINE_PHONE_CARD
	setflag ENGINE_EXPN_CARD
	setflag ENGINE_POKEGEAR

	;clearevent EVENT_RED_BEATEN
	clearevent EVENT_REDS_PIKACHU_AVAILABLE

.done
	closetext
	jumptextfaceplayer LetsCheatText

LetsCheatText:
if DEF(_FR_FR)
	text "C'est parti pour"
	line "la TRICHE!"
else
	text "Let's CHEAT!"
endc
	done
endc

NewBarkTown_TeacherRunsToYouMovement1:
	step LEFT
	step LEFT
	step LEFT
	step_end

NewBarkTown_TeacherRunsToYouMovement2:
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	turn_head LEFT
	step_end

NewBarkTown_TeacherBringsYouBackMovement1:
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head LEFT
	step_end

NewBarkTown_TeacherBringsYouBackMovement2:
	step UP
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head LEFT
	step_end

NewBarkTown_SilverPushesYouAwayMovement:
	turn_head UP
	step DOWN
	step_end

NewBarkTown_SilverShovesYouOutMovement:
	turn_head UP
	fix_facing
	jump_step DOWN
	remove_fixed_facing
	step_end

NewBarkTown_SilverReturnsToTheShadowsMovement:
	step RIGHT
	step_end

Text_GearIsImpressive: 
if DEF(_FR_FR)
	text "Oh! Ton #MATOS"
	line "est balèze!"

	para "C'est ta mère qui"
	line "l'a acheté?"
else
	text "Wow, your #GEAR"
	line "is impressive!"

	para "Did your mom get"
	line "it for you?"
endc

	done

Text_WaitPlayer: 
if DEF(_FR_FR)
	text "Attends, <PLAY_G>!"
else
	text "Wait, <PLAY_G>!"
endc

	done

Text_WhatDoYouThinkYoureDoing: 
if DEF(_FR_FR)
	text "On peut savoir ce"
	line "que tu fabriques?"
else
	text "What do you think"
	line "you're doing?"
endc

	done

Text_ItsDangerousToGoAlone: 
if DEF(_FR_FR)
	text "C'est dangereux de"
	line "sortir sans un"
	cont "#MON!"

	para "Des #MON sauva-"
	line "ges sortent des"

	para "herbes sur la rou-"
	line "te de la prochaine"
	cont "ville."
else
	text "It's dangerous to"
	line "go out without a"
	cont "#MON!"

	para "Wild #MON"
	line "jump out of the"

	para "grass on the way"
	line "to the next town."
endc

	done

Text_YourMonIsAdorable: 
if DEF(_FR_FR)
	text "Oh! Ton #MON"
	line "est adorable!"
	cont "Je veux le même!"
else
	text "Oh! Your #MON"
	line "is adorable!"
	cont "I wish I had one!"
endc

	done

Text_TellMomIfLeaving: 
if DEF(_FR_FR)
	text "Salut <PLAY_G>!"
	line "Tu pars déjà?"

	para "Tu devrais préve-"
	line "nir ta petite"
	cont "maman."
else
	text "Hi, <PLAY_G>!"
	line "Leaving again?"

	para "You should tell"
	line "your mom if you"
	cont "are leaving."
endc

	done

Text_CallMomOnGear: 
if DEF(_FR_FR)
	text "Appelle ta maman"
	line "avec ton #-"
	cont "MATOS et donne-lui"

	para "de tes nouvelles."
else
	text "Call your mom on"
	line "your #GEAR to"

	para "let her know how"
	line "you're doing."
endc

	done

Text_ElmDiscoveredNewMon:
if DEF(_FR_FR)
	text "Yo, <PLAYER>!"

	para "Il paraît que le"
	line "PROF.ORME bosse"
	cont "sur quelque chose"
	cont "d'important."
else
	text "Yo, <PLAYER>!"

	para "I hear PROF.ELM"
	line "is doing some"
	cont "important work."
endc
	done

NewBarkTownRivalText1:
if DEF(_FR_FR)
	text "................"

	para "Voici donc le cé-"
	line "lèbre LABO #MON"
	cont "du PROF.ORME..."
else
	text "<……>"

	para "So this is the"
	line "famous ELM'S LAB…"
endc
	done

NewBarkTownRivalText2: 
if DEF(_FR_FR)
	text "...Mais kess-tu"
	line "mates?"
else
	text "…What are you"
	line "staring at?"
endc

	done

FootstepsText:
if DEF(_FR_FR)
	text "Des empreintes de"
	line "pas dans la boue."
else
	text "Footsteps in the"
	line "dirt."
endc
	done

NewBarkTownSignText: 
if DEF(_FR_FR)
	text "BOURG GEON"

	para "La ville où"
	line "souffle le vent"
	cont "d'une nouvelle vie"
else
	text "NEW BARK TOWN"

	para "The Town Where the"
	line "Winds of a New"
	cont "Beginning Blow"
endc

	done

NewBarkTownPlayersHouseSignText: 
if DEF(_FR_FR)
	text "MAISON DE <PLAYER>"
else
	text "<PLAYER>'s House"
endc

	done

NewBarkTownElmsLabSignText:
if DEF(_FR_FR)
	text "LABO du PROF.ORME"
else
	text "ELM'S LAB"
endc
	done

NewBarkTownElmsHouseSignText: 
if DEF(_FR_FR)
	text "MAISON DU"
	line "PROF.ORME"
else
	text "ELM'S HOUSE"
endc

	done

NewBarkTown_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  3, ELMS_LAB, 1
	warp_event 13,  5, PLAYERS_HOUSE_1F, 1
	warp_event  3, 11, PLAYERS_NEIGHBORS_HOUSE, 1
	warp_event 11, 13, ELMS_HOUSE, 1

	def_coord_events
	coord_event  1,  8, CE_EVENT_FLAG_CLEARED, EVENT_GOT_A_POKEMON_FROM_ELM, NewBarkTown_TeacherStopsYouScene1
	coord_event  1,  9, CE_EVENT_FLAG_CLEARED, EVENT_GOT_A_POKEMON_FROM_ELM, NewBarkTown_TeacherStopsYouScene2

	def_bg_events
	bg_event  8,  8, BGEVENT_READ, NewBarkTownSign
	bg_event 11,  5, BGEVENT_READ, NewBarkTownPlayersHouseSign
	bg_event  3,  3, BGEVENT_READ, NewBarkTownElmsLabSign
	bg_event  9, 13, BGEVENT_READ, NewBarkTownElmsHouseSign
	bg_event  3,  2, BGEVENT_READ, FakeSilverScript

	def_object_events
	object_event  6,  8, SPRITE_TEACHER, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownTeacherScript, -1
	object_event 12,  9, SPRITE_FISHER, CLAP_F | SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NewBarkTownFisherScript, -1
	object_event  3,  2, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, NewBarkTownSilverScript, EVENT_RIVAL_NEW_BARK_TOWN
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	object_event 16,  6, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_SILVER, OBJECTTYPE_SCRIPT, 0, CheatGuyScript, -1
endc
