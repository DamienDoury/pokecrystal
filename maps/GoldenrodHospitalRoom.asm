	object_const_def
	const GOLDENROD_HOSPITAL_ROOM_SICK_PKMN
	const GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT
	const GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT
	const GOLDENROD_HOSPITAL_ROOM_VISITOR1

	; Trainers.
	const GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_1
	const GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_3
	const GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_8
	const GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_17
	const GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_26
	const GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_30
	const GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_31
	const GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_32
	const GOLDENROD_HOSPITAL_ROOM_TRAINER_CHIEF_NURSE
	const GOLDENROD_HOSPITAL_ROOM_LORELEI

GoldenrodHospitalRoom_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
	special GetHospitalRoomNumber
	readmem wSickMonIsInThisRoom
	iffalse .HideSickMon
	;special GetHospitalRoomNumber ; Do we need to recall this? Perhaps wScriptVar needs to be set again to the room number for proper display of the sick mon?
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT
	sjump .FillRoom

.HideSickMon:
	disappear GOLDENROD_HOSPITAL_ROOM_SICK_PKMN

.FillRoom:
	special GetHospitalRoomNumber
	ifequal  1,  .room1
	ifequal  2,  .room2
	ifequal  3,  .room3
	ifequal  4,  .room4
	ifequal  5,  .room5
	ifequal  6,  .room6
	ifequal  7,  .room7
	ifequal  8,  .room8
	ifequal 10, .room10
	ifequal 13, .room13
	ifequal 17, .room17
	ifequal 18, .room18
	ifequal 21, .room21
	ifequal 23, .room23
	ifequal 25, .room25
	ifequal 26, .room26
	ifequal 28, .room28
	ifequal 29, .room29
	ifequal 30, .room30
	ifequal 31, .room31
	ifequal 32, .room32

; Default room : Unless we are in one of the player's sick pokemon rooms, there's only a random human patient, and no one else. 
;	readmem wSickMonIsInThisRoom
;	iffalse .default_room
;	endcallback
;	
.default_room:
	special GetHospitalRoomNumber
	scall Mod25
	addval SPRITE_COOLTRAINER_M
	writemem wMap3ObjectSprite ; Set sprite of GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT.

	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT

	random 8
	ifless 2, .side_sleeper_left
	ifequal 5, .side_sleeper_right
	; default case: back sleeper.
	endcallback

.side_sleeper_left:
	setval SPRITEMOVEDATA_STANDING_LEFT
	sjump .apply_sleeping_position

.side_sleeper_right:
	setval SPRITEMOVEDATA_STANDING_RIGHT
.apply_sleeping_position
	writemem wMap3ObjectMovement
	endcallback





.room1:
	checkevent EVENT_SICK_CATERPIE
	iftrue .caterpie_room1

	variablesprite SPRITE_DOLL_1, SPRITE_ODDISH
	setval PAL_NPC_BROWN << 4
	writemem wMap2ObjectColor
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT
	
	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	moveobject GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_1, 1, 3
	sjump .SetSickMonID

.caterpie_room1:
	variablesprite SPRITE_DOLL_1, SPRITE_CATERPIE
	setval PAL_NPC_GREEN << 4
	writemem wMap2ObjectColor
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT
	
	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_OFFICER
	setval PAL_NPC_GREEN << 4
	writemem wMap4ObjectColor
	setval SPRITEMOVEDATA_STANDING_LEFT
	writemem wMap4ObjectMovement
	sjump .SetSickMonID

.room2:
	variablesprite SPRITE_DOLL_1, SPRITE_DROWZEE
	setval PAL_NPC_BROWN << 4
	writemem wMap2ObjectColor
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT

	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_SCIENTIST
	sjump .SetSickMonID

.room3:
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_TWIN
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT

	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	moveobject GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_3, 1, 6
	sjump .SetSickMonID

.room4:
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_NURSE
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT
	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_SCIENTIST
	moveobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, 2, 4
	setval SPRITEMOVEDATA_STANDING_UP
	writemem wMap4ObjectMovement
	sjump .SetSickMonID

.room5:
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_YOUNGSTER
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT

	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_NURSE
	moveobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, 0, 4
	sjump .SetSickMonID

.room6:
	variablesprite SPRITE_DOLL_1, SPRITE_POLIWAG
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT
	setval PAL_NPC_BLUE << 4
	writemem wMap2ObjectColor
	
	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_SCIENTIST
	setval SPRITEMOVEDATA_STANDING_LEFT
	writemem wMap4ObjectMovement
	special GetHospitalRoomNumber
	sjump .SetSickMonID

.room7:	
	readmem wSickMonIsInThisRoom
	iffalse .do_room6
	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	special GetHospitalRoomNumber
	sjump .SetSickMonID
.do_room6:
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_NURSE
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT
	moveobject GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT, 1, 6
	setval SPRITEMOVEDATA_STANDING_LEFT
	writemem wMap3ObjectMovement

	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_NURSE
	moveobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, 2, 7
	setval SPRITEMOVEDATA_STANDING_RIGHT
	writemem wMap4ObjectMovement
	special GetHospitalRoomNumber
	sjump .SetSickMonID

.room8:
	variablesprite SPRITE_DOLL_1, SPRITE_JIGGLYPUFF
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT
	setval PAL_NPC_PINK << 4
	writemem wMap2ObjectColor
	
	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	moveobject GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_8, 2, 6
	sjump .SetSickMonID

.room10:
	variablesprite SPRITE_DOLL_1, SPRITE_ABRA
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT

	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_SCIENTIST
	moveobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, 3, 4
	setval SPRITEMOVEDATA_STANDING_UP
	writemem wMap4ObjectMovement
	sjump .SetSickMonID

.room13:
	variablesprite SPRITE_DOLL_1, SPRITE_MEOWTH
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT
	setval PAL_NPC_BROWN << 4
	writemem wMap2ObjectColor
	setval SPRITEMOVEDATA_POKEMON
	writemem wMap2ObjectMovement

	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_NURSE
	moveobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, 2, 5
	sjump .SetSickMonID

.room17:
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_BUG_CATCHER
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT

	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	moveobject GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_17, 1, 5
	sjump .SetSickMonID

.room18:
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_BUG_CATCHER
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT

	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_SCIENTIST
	setval SPRITEMOVEDATA_STANDING_UP
	writemem wMap4ObjectMovement

	moveobject GOLDENROD_HOSPITAL_ROOM_TRAINER_CHIEF_NURSE, 2, 5
	sjump .SetSickMonID

.room21:
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_GRAMPS
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT

	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_SCIENTIST
	setval SPRITEMOVEDATA_STANDING_RIGHT
	writemem wMap4ObjectMovement

	moveobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, 2, 7
	sjump .SetSickMonID

.room23:
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_BEAUTY
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT
	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	sjump .SetSickMonID

.room25:
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_GENTLEMAN
	setval PAL_NPC_RED << 4
	writemem wMap3ObjectColor

	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT
	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	sjump .SetSickMonID

.room26:
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_TWIN
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT

	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	moveobject GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_26, 2, 6
	sjump .SetSickMonID

.room28:
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT
	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	sjump .SetSickMonID

.room29:
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftrue .default_room ; Once the player reaches Mahogany, Agatha dies. TV announces it once the player acquires its 7th badge, which can only happen AFTER you reach Mahogany.
	
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_AGATHA
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT

	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_LANCE
	moveobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, 1, 9
	setval SPRITEMOVEDATA_STANDING_RIGHT
	writemem wMap4ObjectMovement

	moveobject GOLDENROD_HOSPITAL_ROOM_LORELEI, 2, 8
	sjump .SetSickMonID

.room30:
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT

	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	moveobject GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_30, 0, 6
	sjump .SetSickMonID

.room31:
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT

	variablesprite SPRITE_HOSPITAL_VISITOR, SPRITE_RECEPTIONIST
	moveobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, 0, 5

	moveobject GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_31, 0, 6
	sjump .SetSickMonID

.room32:
	variablesprite SPRITE_DOLL_1, SPRITE_MURKROW
	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT
	setval PAL_NPC_BLUE << 4
	writemem wMap2ObjectColor

	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	moveobject GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_32, 1, 8

.SetSickMonID:
	special GetHospitalRoomNumber
	endcallback

Mod25:
	ifgreater 24, .loop
	sjump .add_gap

.loop
	addval 256 - 25
	ifgreater 24, .loop

.add_gap
	ifless 14, .done
	addval 8
.done
	end

	
GoldenrodHospitalRoomMedicineScript:
	jumptext GoldenrodHospitalRoomMedicineText

GoldenrodHospitalRoomSickPkmnScript:
	opentext
	special HospitalVisitHappinessGain
	waitbutton
	closetext
	end

GoldenrodHospitalRoomHumanPatientScript:
	special GetHospitalRoomNumber
	ifequal  3,  .room3
	ifequal  4,  .room4
	ifequal  5,  .room5
	ifequal  7,  .room7
	ifequal 14, .room14
	ifequal 17, .room17
	ifequal 23, .room23
	ifequal 24, .room24
	ifequal 26, .room26
	ifequal 29, .room29

	sjump GoldenrodHospitalRoomDefaultPatientScript

.room3:
	jumptext GoldenrodHospitalRoom3PatientText

.room4:
	opentext
	writetext GoldenrodHospitalRoom4PatientPart1Text
	waitbutton
	closetext
	pause 60
	jumptext GoldenrodHospitalRoom4PatientPart2Text

.room5:
	jumptextfaceplayer GoldenrodHospitalRoom5PatientText

.room7:
	faceplayer
	opentext 
	writetext GoldenrodHospitalRoom7PatientText
	waitbutton
	closetext
	turnobject GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT, LEFT
	end

.room14:
	jumptext GoldenrodHospitalRoom14PatientText

.room17:
	jumptext GoldenrodHospitalRoom17PatientText

.room23:
	jumptext GoldenrodHospitalRoom23PatientText

.room24:
	jumptext GoldenrodHospitalRoom24PatientText

.room26:
	jumptext GoldenrodHospitalRoom26PatientText

.room29:
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iffalse .agatha
	jumptext GoldenrodHospitalRoom29PatientText

.agatha
	jumptext GoldenrodHospitalLoreleiText

GoldenrodHospitalRoomPokemonPatientScript:
	special GetHospitalRoomNumber
	ifequal  1, .room1
	ifequal  2, .room2
	ifequal  6, .room6
	ifequal  8, .room8
	ifequal 10, .room10
	ifequal 13, .room13
	ifequal 32, .room32

	sjump GoldenrodHospitalRoomDefaultPatientScript

.room1:
	checkevent EVENT_SICK_CATERPIE
	iftrue .caterpie

	setval ODDISH
	special PlaySlowCry
	waitsfx
	jumptext GoldenrodHospitalRoom1PokemonPatientText

.caterpie
	setval CATERPIE
	special PlaySlowCry
	waitsfx
	jumptext GoldenrodHospitalRoom1CaterpiePatientText

.room2:
	setval DROWZEE
	special PlaySlowCry
	waitsfx
	jumptext GoldenrodHospitalRoom2PokemonPatientText

.room6:
	setval POLIWAG
	special PlaySlowCry
	waitsfx
	jumptext GoldenrodHospitalRoom6PokemonPatientText

.room8:
	showemote EMOTE_SLEEP, GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT, 15
	pause 15
	jumptext GoldenrodHospitalRoom8PokemonPatientText
	
.room10:
	setval ABRA
	special PlaySlowCry
	waitsfx
	jumptext GoldenrodHospitalRoom10PokemonPatientText

.room13:
	setval MEOWTH
	special PlaySlowCry
	waitsfx
	jumptext GoldenrodHospitalRoom13PokemonPatientText

.room32:
	setval MURKROW
	special PlaySlowCry
	waitsfx
	jumptext GoldenrodHospitalRoom32PokemonPatientText

GoldenrodHospitalRoomDefaultPatientScript:
	showemote EMOTE_SLEEP, GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT, 15
	showemote EMOTE_SLEEP, GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT, 15 ; One of those sprites has disappear, so one of the showemotes will behave as a "pause 15".
	jumptext GoldenrodHospitalPatientDefaultText

GoldenrodHospitalRoomVisitor1Script:
	special GetHospitalRoomNumber
	ifequal  1, .room1
	ifequal  2, .room2
	ifequal  4, .room4
	ifequal  5, .room5
	ifequal  6, .room6
	ifequal  7, .room7
	ifequal 10, .room10
	ifequal 13, .room13
	ifequal 18, .room18
	ifequal 21, .room21
	ifequal 31, .room31
	ifequal 29, .room29

	end
	
.room1:
	jumptextfaceplayer GoldenrodHospitalRoom1BisVisitorText

.room2:
	jumptextfaceplayer GoldenrodHospitalRoom2VisitorText
	
.room4:
	jumptextfaceplayer GoldenrodHospitalRoom4VisitorText

.room5:
	jumptextfaceplayer GoldenrodHospitalRoom5VisitorText

.room6:
	jumptextfaceplayer GoldenrodHospitalRoom6VisitorText

.room7:
	faceplayer
	opentext
	writetext GoldenrodHospitalRoom7VisitorText
	waitbutton
	closetext
	turnobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, RIGHT
	end

.room10:
	faceplayer
	opentext
	writetext GoldenrodHospitalRoom10VisitorText
	yesorno
	iftrue .yes
	jumptext GoldenrodHospitalRoom10VisitorNoText
	
.yes 
	jumptext GoldenrodHospitalRoom10VisitorYesText
	
.room13:
	jumptextfaceplayer GoldenrodHospitalRoom13VisitorText

.room18:
	jumptextfaceplayer GoldenrodHospitalRoom18VisitorText

.room21:
	jumptext GoldenrodHospitalRoom21VisitorText

.room29:
	jumptextfaceplayer GoldenrodHospitalRoom29VisitorText

.room31:
	faceplayer
	opentext
	writetext GoldenrodHospitalRoom31VisitorText
	waitbutton
	closetext
	turnobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, DOWN
	end



; Trainers.
GoldenrodHospitalRoomTrainerRoom1Script:
	trainer PICNICKER, KIM, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_1, GoldenrodHospitalTrainerRoom1SeenText, GoldenrodHospitalTrainerRoom1BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom1AfterBattleText

GoldenrodHospitalRoomTrainerRoom3Script:
	trainer PICNICKER, KIM, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_3, GoldenrodHospitalTrainerRoom3SeenText, GoldenrodHospitalTrainerRoom3BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom3AfterBattleText

GoldenrodHospitalRoomTrainerRoom8Script:
	trainer PICNICKER, KIM, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_8, GoldenrodHospitalTrainerRoom8SeenText, GoldenrodHospitalTrainerRoom8BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom8AfterBattleText

GoldenrodHospitalRoomTrainerRoom17Script:
	trainer PICNICKER, KIM, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_17, GoldenrodHospitalTrainerRoom17SeenText, GoldenrodHospitalTrainerRoom17BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom17AfterBattleText

GoldenrodHospitalRoomTrainerRoom26Script:
	trainer PICNICKER, KIM, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_26, GoldenrodHospitalTrainerRoom26SeenText, GoldenrodHospitalTrainerRoom26BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom26AfterBattleText

GoldenrodHospitalRoomTrainerRoom30Script:
	trainer PICNICKER, KIM, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_30, GoldenrodHospitalTrainerRoom30SeenText, GoldenrodHospitalTrainerRoom30BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom30AfterBattleText

GoldenrodHospitalRoomTrainerRoom31Script:
	trainer PICNICKER, KIM, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_31, GoldenrodHospitalTrainerRoom31SeenText, GoldenrodHospitalTrainerRoom31BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom31AfterBattleText

GoldenrodHospitalRoomTrainerRoom32Script:
	trainer PICNICKER, KIM, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_32, GoldenrodHospitalTrainerRoom32SeenText, GoldenrodHospitalTrainerRoom32BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom32AfterBattleText

GoldenrodHospitalRoomTrainerChiefNurseScript:
	trainer PICNICKER, KIM, EVENT_BEAT_HOSPITAL_CHIEF_NURSE, GoldenrodHospitalTrainerRoom1SeenText, GoldenrodHospitalTrainerRoom1BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom1AfterBattleText

GoldenrodHospitalRoomLoreleiScript:
	jumptext GoldenrodHospitalLoreleiText







GoldenrodHospitalTrainerRoom1SeenText:
	text "I'm on my break."

	para "Let's have a"
	line "battle!"
	done

GoldenrodHospitalTrainerRoom1BeatenText:
	text "I better get back"
	line "to work."
	done

GoldenrodHospitalTrainerRoom1AfterBattleText:	
	text "We are bearing"
	line "hundreds of lives"
	cont "on our shoulders."

	para "It's a lot of"
	line "stress."
	done

GoldenrodHospitalTrainerRoom3SeenText:
	text "A good battle"
	line "should entertain"
	cont "my daughter."
	done

GoldenrodHospitalTrainerRoom3BeatenText:
	text "Was it"
	line "entertaining?"
	done

GoldenrodHospitalTrainerRoom3AfterBattleText:	
	text "I've been in my"
	line "daughter's shoes."

	para "I know it's hard"
	line "to keep up morale."
	done

GoldenrodHospitalTrainerRoom8SeenText:
	text "Let me check"
	line "your #MON."
	done

GoldenrodHospitalTrainerRoom8BeatenText:
	text "I admit I baited"
	line "you into a battle."
	done

GoldenrodHospitalTrainerRoom8AfterBattleText:	
	text "Don't worry about"
	line "this #MON, it's"
	cont "out of the danger"
	cont "zone!"
	done

	GoldenrodHospitalTrainerRoom17SeenText:
	text "I'm doing a show"
	line "for the sick kids."
	done

GoldenrodHospitalTrainerRoom17BeatenText:
	text "Stop it, you"
	line "ruined the show!"
	done

GoldenrodHospitalTrainerRoom17AfterBattleText:	
	text "My juggling balls"
	line "fell on the floor,"
	cont "I look ridiculous"
	cont "now!"
	done

	GoldenrodHospitalTrainerRoom26SeenText:
	text "Don't you dare"
	line "approaching my"
	cont "poor daughter!"
	done

GoldenrodHospitalTrainerRoom26BeatenText:
	text "Sorry I need to"
	line "calm down."
	done

GoldenrodHospitalTrainerRoom26AfterBattleText:	
	text "I just want to"
	line "help my daughter"
	cont "but I'm powerless."
	done

	GoldenrodHospitalTrainerRoom30SeenText:
	text "I'm not allowed to"
	line "leave this room,"
	
	para "I'm missing #MON"
	line "battles so much!"
	done

GoldenrodHospitalTrainerRoom30BeatenText:
	text "Couldn't you let a"
	line "sick person win?"
	done

GoldenrodHospitalTrainerRoom30AfterBattleText:	
	text "Once I'll have left"
	line "this hospital, I"
	cont "think I'll go"
	cont "challenge GYM"
	cont "LEADERS."
	done

GoldenrodHospitalTrainerRoom31SeenText:
	text "Welcome to my"
	line "humble house."
	
	para "Please be my"
	line "guest."
	done

GoldenrodHospitalTrainerRoom31BeatenText:
	text "Be nice to your"
	line "uncle, RILEY!"
	done

GoldenrodHospitalTrainerRoom31AfterBattleText:	
	text "I have baked some"
	line "delicious cookies"
	cont "for you!"
	done

GoldenrodHospitalTrainerRoom32SeenText:
	text "You have nothing"
	line "to do in this"
	cont "room, GET OUT!"
	done

GoldenrodHospitalTrainerRoom32BeatenText:
	text "Ok, I'll cool it."
	done

GoldenrodHospitalTrainerRoom32AfterBattleText:	
	text "Please don't bother"
	line "my MURKROW."
	done






GoldenrodHospitalRoom3PatientText:
	text "Dad would do any-"
	line "thing to make me"
	cont "feel better."
	
	para "I'm glad."
	done

GoldenrodHospitalRoom4PatientPart1Text:
	text "I'm tired, so I'm"
	line "taking a nap in"
	cont "this bed."
	done

GoldenrodHospitalRoom4PatientPart2Text:
	text "Of course not,"
	line "what did you"
	cont "think?"
	
	para "I'm severely ill."
	
	para "Yeah, nurses aren't"
	line "immune to COVID."

	para "(COUGH)"
	line "(COUGH)"
	done

GoldenrodHospitalRoom5PatientText:
	text "I am thankful to"
	line "everyone in this"
	cont "hospital for"
	cont "saving my life."
	
	para "I hope I can free"
	line "this bed quickly,"
	cont "so a person or"
	cont "#MON that needs"
	cont "it more than I do"
	cont "can have it."
	done

GoldenrodHospitalRoom7PatientText:
	text "Those bed sheets"
	line "must be full of"
	cont "viruses."

	para "They will be"
	line "washed at 100"
	cont "degrees Celsius."
	done   

GoldenrodHospitalRoom14PatientText:
	text "My business isn't"
	line "gonna run itself."

	para "(cough) (cough)"

	para "I need to go out"
	line "of here as soon as"
	cont "possible or I will"
	cont "be ruined."
	done

GoldenrodHospitalRoom17PatientText:
	text "Don't tell the man,"
	line "but I think"
	cont "juggling's lame."
	
	para "Though his"
	line "presence helps"
	cont "relieve my"
	cont "loneliness."
	done

GoldenrodHospitalRoom23PatientText:
	text "(COUGH)"

	para "Am I…"

	para "(COUGH)(COUGH)"
	
	para "(COUGH)(COUGH)"
	line "(COUGH)(COUGH)"

	para "…"

	para "Am I gonna"
	line "make it, doctor"

	para "(COUGH)(COUGH)"

	para "?"
	done
	
GoldenrodHospitalRoom24PatientText:
	text "My job is to"
	line "protect the"
	cont "population by"
	cont "arresting people"
	cont "that do not wear"
	cont "a facemask."

	para "In the end…"

	para "(cough)"

	para "…In the end I must"
	line "have caught the"
	cont "virus from the"
	cont "people I arrested."

	para "I am furious."
	done

GoldenrodHospitalRoom25Patient_FirstMeetingText:
	text "My family lives in"
	line "KANTO so I don't"
	cont "get any visitors."
	
	para "It warms my heart"
	line "that a young"
	cont "person like you"
	cont "takes the time to"
	cont "visit an old"
	cont "person."
	
GoldenrodHospitalRoom25Patient_AlreadyMetText:
	text "I am happy to see"
	line "you again!"
	
	para "You are such a"
	line "compassionnate"
	cont "person!"
	done

GoldenrodHospitalRoom25Patient_TakeThisText:
	text "Take this as a"
	line "sign of my"
	cont "gratitude."
	done

GoldenrodHospitalRoom25Patient_BagFullText:
	text "Your bag is full."
	line "That a good reason"
	cont "to come visit me"
	cont "again!"
	done

GoldenrodHospitalRoom25Patient_ComeBackText:
	text "Come back anytime!"
	done

GoldenrodHospitalRoom26PatientText:
	text "Daddy is over-"
	line "protective."

	para "I think he's"
	line "scared."
	done

GoldenrodHospitalRoom29PatientText:
	text "(cough)"

	para "I've heard a famous"
	line "#MON trainer"
	cont "died in this ER."

	para "This gives me"
	line "chills despite"
	cont "the fever."
	done
	
GoldenrodHospitalRoom1PokemonPatientText:
	text "The leaves of the"
	line "ODDISH are looking"
	cont "dry."

	para "That's a sign it"
	line "is not healthy."
	done

GoldenrodHospitalRoom1CaterpiePatientText:
	text "Hopefully CATERPIE"
	line "can be saved…"
	done

GoldenrodHospitalRoom2PokemonPatientText:
	text "The DROWZEE doesn't"
	line "even have enough"
	cont "strength to wiggle"
	cont "its arms."

	para "It must be in"
	line "very bad shape."
	done

GoldenrodHospitalRoom6PokemonPatientText:
	text "Poor POLIWAG seems"
	line "to suffer…"
	done

GoldenrodHospitalRoom8PokemonPatientText:
	text "For once, it's the"
	line "JIGGLYPUFF that's"
	cont "sleeping."
	
	para "How ironic."
	done

GoldenrodHospitalRoom10PokemonPatientText:
	text "The ABRA could"
	line "easily TELEPORT"
	cont "away."
	
	para "But it doesn't."

	para "Perhaps it knows"
	line "that it's better"
	cont "to stay in here."
	done 

GoldenrodHospitalRoom13PokemonPatientText:
	text "We can tell this"
	line "MEOWTH is sick"
	cont "but it still"
	cont "seems jolly."
	done 

GoldenrodHospitalRoom32PokemonPatientText:
	text "Not looking good…"
	done

	
	
	
GoldenrodHospitalRoom1BisVisitorText:
	text "I was the one who"
	line "found this sick"
	cont "CATERPIE."
	
	para "I hope it will go"
	line "through this."

	para "CHIEF NURSE JOY"
	line "told me it should"
	cont "be fine."
	done

GoldenrodHospitalRoom2VisitorText:
	text "When an infected"
	line "person is talking"
	cont "to a healthy"
	cont "person, the odds"
	cont "of transmitting"
	cont "the virus are"
	cont "above 90<PERCENT>."
	
	para "That's when the"
	line "facemask shows"
	cont "its strength."

	para "If the healthy"
	line "person wears one,"
	cont "the odds of trans-"
	cont "mission are down"
	cont "to 70<PERCENT>."

	para "Even better: if"
	line "it's the infected"
	cont "person that wears"
	cont "it, the odds are"
	cont "5<PERCENT>."

	para "In the best case"
	line "scenario, both"
	cont "persons wear it,"
	cont "which lowers the"
	cont "odds to only 1.5<PERCENT>."

	para "The virus cannot"
	line "be transmitted"
	cont "from a human to a"
	cont "#MON though."
	done

GoldenrodHospitalRoom4VisitorText:
	text "Viruses normally"
	line "don't transmit from"
	cont "#MON to Human."
	
	para "However, as COVID's"
	line "virus is infecting"
	cont "humans as well,"
	
	para "it must have"
	line "mutated inside a"
	cont "#MON in very"
	cont "unique circum-"
	cont "stances, then"
	cont "jumped into a"
	cont "human."
	
	para "That person would"
	line "be our patient"
	cont "zero."
	done

GoldenrodHospitalRoom5VisitorText:
	text "We are taking"
	line "good care of"
	cont "this patient."
	done

GoldenrodHospitalRoom6VisitorText:
	text "This #MON"
	line "should survive."
	
	para "I'm watching"
	line "over it."
	done 
	
GoldenrodHospitalRoom7VisitorText:
	text "I got to sanitize"
	line "this room quickly"
	cont "before the next"
	cont "patient comes in."
	done

GoldenrodHospitalRoom10VisitorText:
	text "I'm studying the"
	line "effects of COVID."
	
	para "In the process,"
	line "I learned a lot"
	cont "about #MON"
	cont "types."
	
	para "Would like to"
	line "know?"
	done

GoldenrodHospitalRoom10VisitorYesText:
	text "Insert text here." ; TODO.
	done

GoldenrodHospitalRoom10VisitorNoText:
	text "Nevermind, you"
	line "wouldn't understand"
	cont "anyway."
	done

GoldenrodHospitalRoom13VisitorText:
	text "I just love this"
	line "#MON!"
	
	para "We are becoming"
	line "friends!"
	done

GoldenrodHospitalRoom18VisitorText:
	text "The virus cannot"
	line "move through the"
	cont "shell of a #-"
	cont "BALL."
	
	para "It is a safe way"
	line "of quarantine for"
	cont "a #MON."
	
	para "I wish I could fit"
	line "into a #BALL."
	done

GoldenrodHospitalRoom21VisitorText:
	text "Checking on this"
	line "patient…"

	para "…"
	
	para "Vitals are OK."

	para "…"
	
	para "… All good!"
	done

GoldenrodHospitalRoom31VisitorText:
	text "My husband is"
	line "delirious because"
	cont "of the fever."
	done

GoldenrodHospitalRoom29VisitorText:
	text "You are not part"
	line "of the family."

	para "Please leave."
	done










	

GoldenrodHospitalLoreleiText:
	text "Shush!"

	para "I'm not supposed"
	line "to exist in this"
	cont "game, I can't"
	cont "talk to you."
	done

GoldenrodHospitalPatientDefaultText:
	text "Looking dizzy."
	line "Must be drugged."
	done
	
GoldenrodHospitalRoomMedicineText:
	text "Lots of different"
	line "medications."
	done

GoldenrodHospitalRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  9, DYNAMIC_WARP_PREVIOUS ; Sends back into the corridor, where we entered.
	warp_event  3,  9, DYNAMIC_WARP_PREVIOUS ; Sends back into the corridor, where we entered.

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_READ, GoldenrodHospitalRoomMedicineScript
	bg_event  3,  3, BGEVENT_READ, GoldenrodHospitalRoomMedicineScript

	def_object_events
	object_event  0,  6, SPRITE_HOSPITAL_MON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 6, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRoomSickPkmnScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

	; Note: use a variable sprite for the patient, as we can have many different patients, and there should always be a patient in a bed. Change the text within the script.
	object_event  0,  6, SPRITE_DOLL_1, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRoomPokemonPatientScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  0,  6, SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRoomHumanPatientScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3

	; The visitors should usually be either a scientist or a nurse. Sometimes, rooms don't have visitors.
	; We can also have trainers, but they'll be different objects (1 per trainer).
	object_event  2,  6, SPRITE_HOSPITAL_VISITOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRoomVisitor1Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4

	; Trainers.
	object_event 12, 12, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerRoom1Script, -1
	object_event 12, 12, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerRoom3Script, -1
	object_event 12, 12, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerRoom8Script, -1
	object_event 12, 12, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerRoom17Script, -1
	object_event 12, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 1, GoldenrodHospitalRoomTrainerRoom26Script, -1
	object_event 12, 12, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerRoom30Script, -1
	object_event 12, 12, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerRoom31Script, -1
	object_event 12, 12, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, GoldenrodHospitalRoomTrainerRoom32Script, -1
	object_event 12, 12, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerChiefNurseScript, -1
	object_event 12, 12, SPRITE_LORELEI, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRoomLoreleiScript, -1

; 0: talk to guy on route 35 -> 1
; "This #MON is really sick and needs immediate care. Go find the CHIEF NURSE and bring her here now! At this time, she must be at the HOSPITAL."
; 1: accueil -> 2
; "Chief Nurse? I haven't seen her in a while, she must be into her office. That's the door behind me, next to the waiting room."
; 2: check office -> 3
; 3: accueil -> 4
; "If she isn't in her office, she must be doing her round in the patients rooms. Good luck finding her."
; 1 to 4: room 18 -> 5
; 1 to 4: room 2 -> 5
; "I saw her move to the next corridor on the right."
; 5: top rooms -> 6
; "I just crossed her in the corridor when coming from room 11."
; 6: room 10 -> 7
; "She told me she had to go urgently in room 30-something."
; 7: room 31 -> 8
; "She left like 10 seconds ago."
; 8: man in the corridor next to room 31 -> 9
; "I just saw the CHIEF NURSE! She was going straight towards the Reception."
; 9: man in the south of corridor 1 -> 10
; "CHIEF NURSE? She's here, she just stopped into room 18".
; 10: Nurse battle.
; Movement: nurse comes out of Room 18.
; "I'm sooo stressed! I can't take it, there's too much work on my plate. I'm about to burn out! I need to relax. I know, YOU trainer, come here."
; "Woooo. (deep breath). Thanks for the battle, I'm feeling better now."
; "What are you telling me? This person is on ROUTE 35? I need to hurry now! Please come back later, if you want to talk."

; "I'm on break. Let's have a battle! Scientist."		"I better get back to work."
; "I'm not allowed to leave this room, I'm missing #MON battles so much! Pokefan_F" 		"Couldn't you let a sick person win?"
; "You have nothing to do in this room, GET OUT! Rocker" 		"Ok, I'll cool it."
; "I've been waiting here forever... PSYCHIC_T" "Waiting felt better."
; "Welcome to my humble house. Please be my guest. GENTLEMAN" 	"Be nice to your uncle, RILEY!" 		"My husband is delirious because of the fever."
; "Let me check your Pokémon."		"I admit I baited you into a battle."
; "I'm doing a show for the sick kids. JUGGLER"		"You ruined the show!"
; "A good battle should entertain my daugther. MONTAGNARD" 		"Was it entertaining?"
