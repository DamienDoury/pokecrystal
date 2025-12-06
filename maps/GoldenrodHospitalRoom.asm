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

	; Items.
	const GOLDENROD_HOSPITAL_ROOM_7_ITEM
	const GOLDENROD_HOSPITAL_ROOM_15_ITEM

GoldenrodHospitalRoom_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
	special GetHospitalRoomNumber
	ifequal 7, .display_item_room_7
	ifequal 15, .display_item_room_15
	sjump .check_sick_mon

.display_item_room_7:
	moveobject GOLDENROD_HOSPITAL_ROOM_7_ITEM, 1, 3
	sjump .check_sick_mon

.display_item_room_15:
	moveobject GOLDENROD_HOSPITAL_ROOM_15_ITEM, 3, 4

.check_sick_mon:
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
	readmem wSickMonIsInThisRoom
	iffalse .default_room

	disappear GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT
	special GetHospitalRoomNumber
	sjump .SetSickMonID	
	
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
	iffalse .do_room7
	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	special GetHospitalRoomNumber
	sjump .SetSickMonID
.do_room7:
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
	setval PAL_NPC_BLUE << 4
	writemem wMap2ObjectColor
	
	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	moveobject GOLDENROD_HOSPITAL_ROOM_TRAINER_ROOM_8, 2, 6
	sjump .SetSickMonID

.room10:
	variablesprite SPRITE_DOLL_1, SPRITE_ABRA
	setval PAL_NPC_ROCK << 4
	writemem wMap2ObjectColor
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
	checkscene
	ifequal 10, .room18_quest
	setval SPRITEMOVEDATA_STANDING_RIGHT
	writemem wMap4ObjectMovement
	sjump .SetSickMonID

.room18_quest:
	setval SPRITEMOVEDATA_STANDING_UP
	writemem wMap4ObjectMovement

	moveobject GOLDENROD_HOSPITAL_ROOM_TRAINER_CHIEF_NURSE, 2, 4
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
	disappear GOLDENROD_HOSPITAL_ROOM_POKEMON_PATIENT
	disappear GOLDENROD_HOSPITAL_ROOM_VISITOR1
	
	checkevent EVENT_SICK_GENTLEMAN_DIED
	iffalse .room25_anton_alive

	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_YOUNGSTER
	sjump .SetSickMonID

.room25_anton_alive:
	variablesprite SPRITE_HOSPITAL_HUMAN_PATIENT, SPRITE_GENTLEMAN
	setval PAL_NPC_RED << 4
	writemem wMap3ObjectColor
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
	ifequal  9,  .room9
	ifequal 11, .room11
	ifequal 12, .room12
	ifequal 14, .room14
	ifequal 17, .room17
	ifequal 19, .room19
	ifequal 23, .room23
	ifequal 25, .room25
	ifequal 24, .room24
	ifequal 27, .room27
	ifequal 26, .room26
	ifequal 29, .room29
	
	sjump GoldenrodHospitalRoomDefaultPatientScript

.room3:
	jumptext GoldenrodHospitalRoom3PatientText

.room4: ; Medical staff don't clap.
	opentext
	writetext GoldenrodHospitalRoom4PatientPart1Text
	waitbutton
	closetext
	pause 60
	jumptext GoldenrodHospitalRoom4PatientPart2Text

.room5: ; Patients are too exhausted to clap.
	jumptext GoldenrodHospitalRoom5PatientText

.room7: ; Medical staff don't clap.
	faceplayer
	opentext 
	callasm HasPlayerClappedALotInThisRoom
	iffalse .room7_no_clapping

	farwritetext GoldenrodHospitalRoom7PatientClapText
	checkevent EVENT_GOT_STUFF_FROM_CLAPPING_AT_NURSE
	iffalse .room7_text_end

	callasm ResetClapInThisRoom
	sjump .room7_text_end

.room7_no_clapping:
	writetext GoldenrodHospitalRoom7PatientText
	
.room7_text_end
	waitbutton
	closetext
	turnobject GOLDENROD_HOSPITAL_ROOM_HUMAN_PATIENT, LEFT
	end

.room9:
	checkscene
	ifequal 0, GoldenrodHospitalRoomDefaultPatientScript
	jumptext GoldenrodHospitalRoom_Quest9Text

.room11:
	checkscene
	ifequal 0, GoldenrodHospitalRoomDefaultPatientScript
	jumptext GoldenrodHospitalRoom_Quest11Text

.room12:
	checkscene
	ifnotequal 7, GoldenrodHospitalRoomDefaultPatientScript
	jumptext GoldenrodHospitalRoom_Quest12Text

.room14:
	jumptext GoldenrodHospitalRoom14PatientText

.room17:
	jumptext GoldenrodHospitalRoom17PatientText

.room19:
	checkscene
	ifequal 0, GoldenrodHospitalRoomDefaultPatientScript
	jumptext GoldenrodHospitalRoom_Quest19Text

.room23:
	jumptext GoldenrodHospitalRoom23PatientText

.room25:
	checkevent EVENT_SICK_GENTLEMAN_DIED
	iftrue .room25_iz_ded
	checkevent EVENT_SICK_GENTLEMAN_QUEST_ONGOING
	iftrue .room25_quest_ongoing

	checkevent EVENT_SICK_GENTLEMAN_FIRST_MEETING
	iffalse .room25_first_meeting

	readmem wEventFlags + 199 ;(199 * 8 = 1592)
	ifequal -1, .room25_start_quest ; If all flags have been set, then the player has visited the man every days of a week.

; Happy to see you again!
	opentext
	writetext GoldenrodHospitalRoom25Patient_AlreadyMetText
	promptbutton
	sjump .room25_check_day

.room25_first_meeting:
	opentext
	writetext GoldenrodHospitalRoom25Patient_FirstMeetingText
	promptbutton
	setevent EVENT_SICK_GENTLEMAN_FIRST_MEETING

.room25_check_day:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .room25_sunday
	ifequal MONDAY, .room25_monday
	ifequal TUESDAY, .room25_tuesday
	ifequal WEDNESDAY, .room25_wednesday
	ifequal THURSDAY, .room25_thursday
	ifequal FRIDAY, .room25_friday

;.room25_saturday:
	checkevent EVENT_SICK_GENTLEMAN_WATER_STONE
	iftrue .room25_nothing_today
	writetext GoldenrodHospitalRoom25Patient_TakeThisText
	promptbutton
	verbosegiveitem WATER_STONE
	iffalse .room25_bag_full
	setevent EVENT_SICK_GENTLEMAN_WATER_STONE
	sjump .room25_come_back

.room25_sunday:
	checkevent EVENT_SICK_GENTLEMAN_THUNDER_STONE
	iftrue .room25_nothing_today
	writetext GoldenrodHospitalRoom25Patient_TakeThisText
	promptbutton
	verbosegiveitem THUNDERSTONE
	iffalse .room25_bag_full
	setevent EVENT_SICK_GENTLEMAN_THUNDER_STONE
	sjump .room25_come_back

.room25_monday:
	checkevent EVENT_SICK_GENTLEMAN_RARE_CANDY
	iftrue .room25_nothing_today
	writetext GoldenrodHospitalRoom25Patient_TakeThisText
	promptbutton
	verbosegiveitem RARE_CANDY
	iffalse .room25_bag_full
	setevent EVENT_SICK_GENTLEMAN_RARE_CANDY
	sjump .room25_come_back

.room25_tuesday:
	checkevent EVENT_SICK_GENTLEMAN_MAX_REVIVE
	iftrue .room25_nothing_today
	writetext GoldenrodHospitalRoom25Patient_TakeThisText
	promptbutton
	verbosegiveitem MAX_REVIVE
	iffalse .room25_bag_full
	setevent EVENT_SICK_GENTLEMAN_MAX_REVIVE
	sjump .room25_come_back

.room25_wednesday:
	checkevent EVENT_SICK_GENTLEMAN_MAX_ETHER
	iftrue .room25_nothing_today
	writetext GoldenrodHospitalRoom25Patient_TakeThisText
	promptbutton
	verbosegiveitem MAX_ETHER
	iffalse .room25_bag_full
	setevent EVENT_SICK_GENTLEMAN_MAX_ETHER
	sjump .room25_come_back

.room25_thursday:
	checkevent EVENT_SICK_GENTLEMAN_FIRE_STONE
	iftrue .room25_nothing_today
	writetext GoldenrodHospitalRoom25Patient_TakeThisText
	promptbutton
	verbosegiveitem FIRE_STONE
	iffalse .room25_bag_full
	setevent EVENT_SICK_GENTLEMAN_FIRE_STONE
	sjump .room25_come_back

.room25_friday:
	checkevent EVENT_SICK_GENTLEMAN_LEAF_STONE
	iftrue .room25_nothing_today
	writetext GoldenrodHospitalRoom25Patient_TakeThisText
	promptbutton
	verbosegiveitem LEAF_STONE
	iffalse .room25_bag_full
	setevent EVENT_SICK_GENTLEMAN_LEAF_STONE
	sjump .room25_come_back

.room25_start_quest:
	opentext 
	writetext GoldenrodHospitalRoom25Patient_AlreadyMetText
	promptbutton

	readvar VAR_PARTYCOUNT
	ifgreater PARTY_LENGTH - 1, .room25_party_full

	writetext GoldenrodHospitalRoom25Patient_QuestStartText
	promptbutton
	farwritetext Route35GoldenrodGatePlayerReceivedAMonWithMailText
	waitsfx
	playsound SFX_KEY_ITEM
	waitsfx
	promptbutton
	givepoke MEOWTH, 25, NO_ITEM, TRUE, GiftAntonMonName, GiftAntonMonOTName
	setval 0	; See next comment.
	writemem wTempByteValue ; This has been added (along with the prev line) to prevent the OT name written on the mail to be "DAMIAN".
	givepokemail GiftAntonMonMail
	setevent EVENT_SICK_GENTLEMAN_QUEST_ONGOING
	sjump .room25_quest_ongoing

.room25_nothing_today:
	writetext GoldenrodHospitalRoom25Patient_NothingTodayText
	promptbutton

.room25_come_back:
	writetext GoldenrodHospitalRoom25Patient_ComeBackText
	waitbutton
	closetext
	end

.room25_iz_ded:
	jumptext GoldenrodHospitalRoom25Patient_IzDedText

.room25_quest_ongoing:
	jumptext GoldenrodHospitalRoom25Patient_DeliverMailText

.room25_bag_full:
	jumptext GoldenrodHospitalRoom25Patient_BagFullText

.room25_party_full:
	jumptext GoldenrodHospitalRoom25Patient_PartyFullText

.room24:
	jumptext GoldenrodHospitalRoom24PatientText

.room26:
	jumptext GoldenrodHospitalRoom26PatientText

.room27:
	checkscene
	ifgreater 9, GoldenrodHospitalRoomDefaultPatientScript ; We don't want this guy to confuse us during the last quest step.
	ifequal 7, .room27_advance_quest
	ifgreater 7, .room27_quest_text

	sjump GoldenrodHospitalRoomDefaultPatientScript

.room27_advance_quest:
	setscene SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_8
.room27_quest_text: ; This is a quest text. No clapping should prevent it from displaying.
	faceplayer
	jumptext GoldenrodHospitalRoom_Quest27Text

.room29:
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iffalse .agatha
	jumptext GoldenrodHospitalRoom29PatientText

.agatha
	jumptext GoldenrodHospitalLoreleiText

GiftAntonMonName:
if DEF(_FR_FR)
	db "NYAN@"
else
	db "NYAN@"
endc

GiftAntonMonOTName:
if DEF(_FR_FR)
	db "ANTON@"
else
	db "ANTON@"
endc

GiftAntonMonMail::
	db BLUESKY_MAIL
if DEF(_FR_FR)
	db   "Je t'aime pour"
	next "toujours chérie@"
else
	db   "I will always"
	next "love you darling@"
endc



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
	ifequal 29, .room29
	ifequal 31, .room31
	end
	
.room1:
	jumptextfaceplayer GoldenrodHospitalRoom1BisVisitorText

.room2:
	checkscene
	ifgreater 0, .room2_quest
	faceplayer ; Medical staff don't clap at themselves.
	jumptext GoldenrodHospitalRoom2VisitorText

.room2_quest: ; This is a quest text. No clapping should prevent it from displaying.
	ifgreater 4, .room2_quest_text
	setscene SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_5
.room2_quest_text:
	faceplayer
	jumptext GoldenrodHospitalRoom_Quest2And18Text
	
.room4:
	faceplayer ; Medical staff don't clap.
	jumptext GoldenrodHospitalRoom4VisitorText

.room5:
	faceplayer ; Medical staff don't clap.
	checkscene
	ifequal 5, .room5_quest

	callasm HasPlayerClappedALotInThisRoom_WithReset
	iftrue .room5_clap
	jumptext GoldenrodHospitalRoom5VisitorText
	
.room5_clap:
	farjumptext GoldenrodHospitalRoom13VisitorClapText

.room5_quest:
	jumptext GoldenrodHospitalRoom_Quest5Text

.room6:
	faceplayer
	jumptext GoldenrodHospitalRoom6VisitorText ; Medical staff don't clap.

.room7: ; Medical staff don't clap.
	faceplayer
	opentext
	callasm HasPlayerClappedALotInThisRoom
	iffalse .room7_no_clapping

	farwritetext GoldenrodHospitalRoom7VisitorClapText
	checkevent EVENT_GOT_STUFF_FROM_CLAPPING_AT_NURSE
	iftrue .room7_reset_clap_then_quit

	promptbutton
	farwritetext GoldenrodHospitalRoom7VisitorClap2Text
	promptbutton
	verbosegiveitem MAX_ELIXER, 10
	iffalse .room7_closetext
	
	callasm ResetClapInThisRoom
	setevent EVENT_GOT_STUFF_FROM_CLAPPING_AT_NURSE
	sjump .room7_closetext

.room7_no_clapping:
	writetext GoldenrodHospitalRoom7VisitorText
	
.room7_text_end:
	waitbutton
.room7_closetext:
	closetext
	turnobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, RIGHT
	end

.room7_reset_clap_then_quit:
	callasm ResetClapInThisRoom
	sjump .room7_text_end

.room10:
	faceplayer
	opentext
	writetext GoldenrodHospitalRoom10VisitorText
	yesorno
	iftrue .room10_yes

.room_10_no
	; Player chose "No".
	checkscene
	ifequal 6, .room10_advance_quest
	ifgreater 6, .room10_quest_text

	jumptext GoldenrodHospitalRoom10VisitorNoText

.room10_advance_quest:
	setscene SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_7

.room10_quest_text:
	jumptext GoldenrodHospitalRoom_Quest10Text	
	
.room10_yes:
	writetext GoldenrodHospitalRoom10VisitorText2
	yesorno
	iffalse .room_10_no
	; Player chose yes... twice.
	jumptext GoldenrodHospitalRoom10VisitorYesText
	
.room13: ; Medical staff don't clap.
	faceplayer
	checkscene
	ifless 1, .default_room13
	jumptext GoldenrodHospitalRoom_Quest13Text

.default_room13:
	callasm HasPlayerClappedALotInThisRoom_WithReset
	iffalse .room13_no_clapping

	farjumptext GoldenrodHospitalRoom13VisitorClapText

.room13_no_clapping
	jumptext GoldenrodHospitalRoom13VisitorText

.room18: ; Medical staff won't clap at themselves.
	faceplayer
	checkscene
	ifequal 0, .default_room18
	ifgreater 9, .default_room18
	ifgreater 4, .room18_quest_text
	setscene SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_5
.room18_quest_text:
	jumptext GoldenrodHospitalRoom_Quest2And18Text

.default_room18:
	jumptext GoldenrodHospitalRoom18VisitorText

.room21:
	jumptext GoldenrodHospitalRoom21VisitorText

.room29: ; No clapping animation for Lance.
	jumptext GoldenrodHospitalRoom29VisitorText

.room31:
	faceplayer
	opentext
	writetext GoldenrodHospitalRoom31VisitorText

	checkscene
	ifequal 8, .room31_advance_quest
	ifgreater 8, .room31_quest
	sjump .room31_default

.room31_advance_quest:
	setscene SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_9
.room31_quest:
	promptbutton
	writetext GoldenrodHospitalRoom_Quest31Text

.room31_default:
	waitbutton
	closetext
	turnobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, DOWN
	end





; Trainers.
GoldenrodHospitalRoomTrainerRoom1Script:
	trainer SCIENTIST, EROID, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_1, GoldenrodHospitalTrainerRoom1SeenText, GoldenrodHospitalTrainerRoom1BeatenText, 0, .Script

.Script:
	endifjustbattled
	faceplayer ; Medical staff can't clap at themselves.
	jumptext GoldenrodHospitalTrainerRoom1AfterBattleText

GoldenrodHospitalRoomTrainerRoom3Script:
	trainer FIREBREATHER, HUGO, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_3, GoldenrodHospitalTrainerRoom3SeenText, GoldenrodHospitalTrainerRoom3BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom3AfterBattleText

GoldenrodHospitalRoomTrainerRoom8Script:
	trainer SCIENTIST, ADRIAN, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_8, GoldenrodHospitalTrainerRoom8SeenText, GoldenrodHospitalTrainerRoom8BeatenText, 0, .Script

.Script:
	checkscene 
	ifequal 5, .advance_quest
	endifjustbattled

	ifgreater 5, .quest_afterbattle_text
	faceplayer ; Medical staff can't clap at themselves.
	jumptext GoldenrodHospitalTrainerRoom8AfterBattleText

.advance_quest:
	setscene SCENE_GOLDENROD_HOSPITAL_NURSE_SEARCH_STEP_6
.quest_afterbattle_text:
	faceplayer ; Medical staff can't clap at themselves.
	jumptext GoldenrodHospitalRoom_Quest8Text	

GoldenrodHospitalRoomTrainerRoom17Script:
	trainer JUGGLER, BOZO, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_17, GoldenrodHospitalTrainerRoom17SeenText, GoldenrodHospitalTrainerRoom17BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom17AfterBattleText

GoldenrodHospitalRoomTrainerRoom26Script:
	trainer BLACKBELT_T, STRIK, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_26, GoldenrodHospitalTrainerRoom26SeenText, GoldenrodHospitalTrainerRoom26BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom26AfterBattleText

GoldenrodHospitalRoomTrainerRoom30Script:
	trainer POKEFANF, BERTHA, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_30, GoldenrodHospitalTrainerRoom30SeenText, GoldenrodHospitalTrainerRoom30BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GoldenrodHospitalTrainerRoom30AfterBattleText

GoldenrodHospitalRoomTrainerRoom31Script:
	trainer GENTLEMAN, SUM_TING, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_31, GoldenrodHospitalTrainerRoom31SeenText, GoldenrodHospitalTrainerRoom31BeatenText, 0, .Script

.Script:
	endifjustbattled ; Patients are too exhausted to clap.
	faceplayer
	jumptext GoldenrodHospitalTrainerRoom31AfterBattleText

GoldenrodHospitalRoomTrainerRoom32Script:
	trainer GUITARIST, JIMI, EVENT_BEAT_HOSPITAL_TRAINER_ROOM_32, GoldenrodHospitalTrainerRoom32SeenText, GoldenrodHospitalTrainerRoom32BeatenText, 0, .Script

.Script:
	endifjustbattled
	faceplayer
	jumptext GoldenrodHospitalTrainerRoom32AfterBattleText ; Rocker's don't have a clapping animation.

GoldenrodHospitalRoomTrainerChiefNurseScript:
	showemote EMOTE_QUESTION, GOLDENROD_HOSPITAL_ROOM_TRAINER_CHIEF_NURSE, 15
	pause 5
	faceplayer

	opentext 
	writetext GoldenrodHospitalRoomChiefNurseSeenText
	waitbutton
	closetext

	winlosstext GoldenrodHospitalRoomChiefNurseBeatenText, GoldenrodHospitalRoomChiefNurseLoseText
	loadtrainer NURSE, CHIEF
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle

	reloadmap
	setevent EVENT_BEAT_HOSPITAL_CHIEF_NURSE
	pause 3

	opentext
	writetext GoldenrodHospitalRoomChiefNurseAfterBattleText
	waitbutton
	closetext

	farscall FadeBlackAndHealParty

	opentext
	writetext GoldenrodHospitalRoomChiefNurseAfterBattleText2
	waitbutton
	closetext

	;special FadeBlackQuickly
	special FadeOutPalettes
	disappear GOLDENROD_HOSPITAL_ROOM_TRAINER_CHIEF_NURSE
	pause 5
	playsound SFX_EXIT_BUILDING
	waitsfx
	loadmem wYearMonth, 3
	setevent EVENT_SICK_CATERPIE
	setevent EVENT_LOCKDOWN_MART_RUSH ; Stops the rush.
	setevent EVENT_FIRST_LOCKDOWN_STARTED
	clearevent EVENT_TRAVEL_CONTROL
	clearevent EVENT_MART_CHERRYGROVE_MISSED
	clearevent EVENT_MART_VIOLET_MISSED
	clearevent EVENT_MART_AZALEA_MISSED
	clearevent EVENT_CHARCOAL_KILN_APPRENTICE
	clearevent EVENT_GOLDENROD_BEATER
	loadmem wCurFreedomState, 1 << LOCKDOWN
	setscene SCENE_GOLDENROD_HOSPITAL_NO_SEARCH
	pause 5
	;special FadeInQuickly
	special FadeInPalettes

	pause 5

	turnobject GOLDENROD_HOSPITAL_ROOM_VISITOR1, UP

	opentext
	writetext GoldenrodHospitalAnnounceLockdownText
	waitbutton
	closetext

	showemote EMOTE_QUESTION, PLAYER, 15

	applymovement PLAYER, GoldenrodHospitalRoom_AnnounceLockdownMovement
	pause 5

	opentext
	writetext GoldenrodHospitalAnnounceLockdown2Text
	waitbutton
	closetext
	end

GoldenrodHospitalRoomLoreleiScript:
	jumptext GoldenrodHospitalLoreleiText

GoldenrodHospitalRoom_ItemBall7Script:
	itemball MAX_REVIVE

GoldenrodHospitalRoom_ItemBall15Script:
	itemball MAX_REVIVE

GoldenrodHospitalRoomSuperPotion:
	hiddenitem SUPER_POTION, EVENT_GOLDENROD_HOSPITAL_ROOM_SUPER_POTION

GoldenrodHospitalRoom_AnnounceLockdownMovement:
	step RIGHT
	step RIGHT
	turn_head DOWN
	step_end

GoldenrodHospitalTrainerRoom1SeenText:
if DEF(_FR_FR)
	text "Je suis en pause."

	para "Un petit combat?"
else
	text "I'm on my break."

	para "Let's have a"
	line "battle!"
endc
	done

GoldenrodHospitalTrainerRoom1BeatenText:
if DEF(_FR_FR)
	text "Je ferais mieux de"
	line "retourner bosser."
else
	text "I better get back"
	line "to work."
endc
	done

GoldenrodHospitalTrainerRoom1AfterBattleText:
if DEF(_FR_FR)
	text "On porte le poids"
	line "de centaines de"
	cont "vies sur nos"
	cont "épaules."

	para "C'est beaucoup de"
	line "stress."
else
	text "We are bearing"
	line "hundreds of lives"
	cont "on our shoulders."

	para "It's a lot of"
	line "stress."
endc
	done

GoldenrodHospitalTrainerRoom3SeenText:
if DEF(_FR_FR)
	text "Un bon combat"
	line "devrait divertir"
	cont "ma fille."
else
	text "A good battle"
	line "should entertain"
	cont "my daughter."
endc
	done

GoldenrodHospitalTrainerRoom3BeatenText:
if DEF(_FR_FR)
	text "C'était"
	line "distrayant?"
else
	text "Was it"
	line "entertaining?"
endc
	done

GoldenrodHospitalTrainerRoom3AfterBattleText:
if DEF(_FR_FR)
	text "J'ai été à la"
	line "place de ma fille."

	para "Je sais qu'il est"
	line "difficile de"
	cont "garder le moral."
else
	text "I've been in my"
	line "daughter's shoes."

	para "I know it's hard"
	line "to keep up morale."
endc
	done

GoldenrodHospitalTrainerRoom8SeenText:
if DEF(_FR_FR)
	text "Laisse-moi voir"
	line "tes #MON."
else
	text "Let me check"
	line "your #MON."
endc
	done

GoldenrodHospitalTrainerRoom8BeatenText:
if DEF(_FR_FR)
	text "J'admets t'avoir"
	line "piégé."
else
	text "I admit I baited"
	line "you into a battle."
endc
	done

GoldenrodHospitalTrainerRoom8AfterBattleText:
if DEF(_FR_FR)
	text "Ne t'en fais pas,"
	line "ce #MON est"
	cont "hors de danger!"
else
	text "Don't worry about"
	line "this #MON, it's"
	cont "out of the danger"
	cont "zone!"
endc
	done

GoldenrodHospitalTrainerRoom17SeenText:
if DEF(_FR_FR)
	text "Je fais un"
	line "spectacle pour"
	cont "les malades."
else
	text "I'm doing a show"
	line "for the sick."
endc
	done

GoldenrodHospitalTrainerRoom17BeatenText:
if DEF(_FR_FR)
	text "Arrête! T'as ruiné"
	line "le spectable!"
else
	text "Stop it, you"
	line "ruined the show!"
endc
	done

GoldenrodHospitalTrainerRoom17AfterBattleText:
if DEF(_FR_FR)
	text "Mes balles de"
	line "jonglage sont"
	cont "tombées au sol,"
	cont "j'ai l'air ridicule"
	cont "maintenant!"
else
	text "My juggling balls"
	line "fell on the floor,"
	cont "I look ridiculous"
	cont "now!"
endc
	done

GoldenrodHospitalTrainerRoom26SeenText:
if DEF(_FR_FR)
	text "N'approche pas de"
	line "ma pauvre fille!"
else
	text "Don't you dare"
	line "approaching my"
	cont "poor daughter!"
endc
	done

GoldenrodHospitalTrainerRoom26BeatenText:
if DEF(_FR_FR)
	text "Désolé. Faut que"
	line "j'me calme."
else
	text "Sorry I need to"
	line "calm down."
endc
	done

GoldenrodHospitalTrainerRoom26AfterBattleText:
if DEF(_FR_FR)
	text "J'veux juste aider"
	line "ma fille mais j'me"
	cont "sens impuissant."
else
	text "I just want to"
	line "help my daughter"
	cont "but I'm powerless."
endc
	done

GoldenrodHospitalTrainerRoom30SeenText:
if DEF(_FR_FR)
	text "Il m'est interdit"
	line "de quitter cette"
	cont "chambre."

	para "Les combats #-"
	line "MON me manquent"
	cont "tellement!"
else
	text "I'm not allowed to"
	line "leave this room."
	
	para "I'm missing #MON"
	line "battles so much!"
endc
	done

GoldenrodHospitalTrainerRoom30BeatenText:
if DEF(_FR_FR)
	text "Tu laisses pas la"
	line "malade gagner?"
else
	text "Couldn't you let a"
	line "sick person win?"
endc
	done

GoldenrodHospitalTrainerRoom30AfterBattleText:
if DEF(_FR_FR)
	text "Une fois sorti de"
	line "cet hôpital, je"
	cont "pense aller défier"
	cont "les CHAMPIONS"
	cont "d'ARENE!"
else
	text "Once I'll have left"
	line "this hospital, I"
	cont "think I'll go"
	cont "challenge GYM"
	cont "LEADERS."
endc
	done

GoldenrodHospitalTrainerRoom31SeenText:
if DEF(_FR_FR)
	text "Bienvenue dans ma"
	line "modeste demeure."

	para "Sois mon invité."
else
	text "Welcome to my"
	line "humble house."
	
	para "Please be my"
	line "guest."
endc
	done

GoldenrodHospitalTrainerRoom31BeatenText:
if DEF(_FR_FR)
	text "Sois gentil avec"
	line "ton oncle, RILEY!"
else
	text "Be nice to your"
	line "uncle, RILEY!"
endc
	done

GoldenrodHospitalTrainerRoom31AfterBattleText:
if DEF(_FR_FR)
	text "J'ai préparé de"
	line "délicieux cookies"
	cont "pour toi!"
else
	text "I have baked some"
	line "delicious cookies"
	cont "for you!"
endc
	done

GoldenrodHospitalTrainerRoom32SeenText:
if DEF(_FR_FR)
	text "T'as rien à faire"
	line "dans cette chambre"
	cont "alors DEGAGES!"
else
	text "You have nothing"
	line "to do in this"
	cont "room, GET OUT!"
endc
	done

GoldenrodHospitalTrainerRoom32BeatenText:
if DEF(_FR_FR)
	text "Relax max!"
else
	text "Ok, I'll cool it."
endc
	done

GoldenrodHospitalTrainerRoom32AfterBattleText:
if DEF(_FR_FR)
	text "S'il te plaît, ne"
	line "dérange pas mon"
	cont "CORNEBRE."
else
	text "Please don't bother"
	line "my MURKROW."
endc
	done

GoldenrodHospitalRoomChiefNurseSeenText:
if DEF(_FR_FR)
	text "QUOI ENCORE?"

	para "Qu'est-ce que"
	line "tu veux?"

	para "Je suis pressée,"
	line "abrège."

	para "..."

	para "..."
	
	para "Oh purée, je suis"
	line "tellement stres-"
	cont "sée! Je n'en peux"
	cont "plus ..."
	
	para "J'ai trop de"
	line "travail sur les"
	cont "bras."
	
	para "Je vais finir en"
	line "burn-out!!"
	
	para "Il faut que je me"
	line "détende."
	
	para "J'ai une idée!"
	line "Viens là."
else
	text "WHAT?"

	para "What do you want?"

	para "I'm busy, talk"
	line "quickly."

	para "…"

	para "…"
	
	para "Oh my word, I'm so"
	line "stressed! I can't"
	cont "take it anymore…"
	
	para "There's too much"
	line "work on my plate."
	
	para "I'm about to"
	line "burn out!!"
	
	para "I need to relax."
	
	para "I have an idea!"
	line "Come here."
endc
	done

GoldenrodHospitalRoomChiefNurseBeatenText:
if DEF(_FR_FR)
	text "Woooooo!"
else
	text "Woooooo!"
endc
	done

GoldenrodHospitalRoomChiefNurseLoseText:
if DEF(_FR_FR)
	text "Désolée d'avoir"
	line "blessé ton équipe."
else
	text "Sorry for hurting"
	line "your #MON…"
endc
	done

GoldenrodHospitalRoomChiefNurseAfterBattleText:
if DEF(_FR_FR)
	text "(inspiration"
	line "profonde)"
	
	para "Merci pour ce"
	line "combat."
	
	para "Tu m'as calmée et"
	line "j'en avais besoin."

	para "Laisse-moi soigner"
	line "tes #MON."
else
	text "(deep breath)"
	
	para "Thanks for the"
	line "battle."
	
	para "You calmed me"
	line "down and I needed"
	cont "it."

	para "Allow me to heal"
	line "your #MON."
endc
	done

GoldenrodHospitalRoomChiefNurseAfterBattleText2:
if DEF(_FR_FR)
	text "Pourquoi tu"
	line "voulais me voir?"

	para "..."

	para "Un CHENIPAN en"
	line "état critique sur"
	cont "la ROUTE 35?"

	para "Il faut que je"
	line "me dépêche!"

	para "Donne-moi ton"
	line "numéro de tel."

	para "Repasses plus tard"
	line "si tu veux"
	cont "discuter."
else
	text "Why did you want"
	line "to see me?"

	para "…"

	para "A critically ill"
	line "CATERPIE on"
	cont "ROUTE 35?"

	para "I need to hurry!"

	para "Give me your"
	line "phone number."

	para "Please come back"
	line "later, if you"
	cont "want to talk."
endc
	done

GoldenrodHospitalRoom3PatientText:
if DEF(_FR_FR)
	text "Papa ferait tout"
	line "pour que j'aille"
	cont "mieux."

	para "Ca me touche."
else
	text "Dad would do any-"
	line "thing to make me"
	cont "feel better."
	
	para "I'm glad."
endc
	done

GoldenrodHospitalRoom4PatientPart1Text:
if DEF(_FR_FR)
	text "Je suis fatiguée,"
	line "alors je fais une"
	cont "sieste dans ce"
	cont "lit."
else
	text "I'm tired, so I'm"
	line "taking a nap in"
	cont "this bed."
endc
	done

GoldenrodHospitalRoom4PatientPart2Text:
if DEF(_FR_FR)
	text "Mais bien sûr que"
	line "c'est faux, tu"
	cont "croyais quoi?"
	
	para "Je suis gravement"
	line "malade."
	
	para "Les INFIRMIERES ne"
	line "sont pas immu-"
	cont "nisées contre"
	cont "le COVID."

	para "(TOUSSE)"
	line "(TOUSSE)"
else
	text "Of course not,"
	line "what did you"
	cont "think?"
	
	para "I'm severely ill."
	
	para "Yeah, nurses aren't"
	line "immune to COVID."

	para "(COUGH)"
	line "(COUGH)"
endc
	done

GoldenrodHospitalRoom5PatientText:
if DEF(_FR_FR)
	text "Je suis reconnais-"
	line "sant envers tout"
	cont "le personnel de"
	cont "cet hôpital pour"
	cont "m'avoir sauvé."
	
	para "J'espère pouvoir"
	line "vite libérer ce"
	cont "lit, afin qu'une"
	cont "personne ou un"
	cont "#MON qui en a"
	cont "plus besoin que"
	cont "moi puisse"
	cont "l'avoir."
else
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
endc
	done

GoldenrodHospitalRoom7PatientText:
if DEF(_FR_FR)
	text "Ces draps doivent"
	line "être pleins de"
	cont "virus."

	para "Ils seront lavés"
	line "à 100 degrés."
else
	text "Those bed sheets"
	line "must be full of"
	cont "viruses."

	para "They will be"
	line "washed at 100"
	cont "degrees Celsius."
endc
	done

GoldenrodHospitalRoom14PatientText:
if DEF(_FR_FR)
	text "Mon entreprise ne"
	line "va pas tourner"
	cont "sans moi."

	para "(toux) (toux)"

	para "Je dois sortir"
	line "d'ici au plus vite"
	cont "ou je vais être"
	cont "ruiné."
else
	text "My business isn't"
	line "gonna run itself."

	para "(cough) (cough)"

	para "I need to go out"
	line "of here as soon as"
	cont "possible or I will"
	cont "be ruined."
endc
	done

GoldenrodHospitalRoom17PatientText:
if DEF(_FR_FR)
	text "Ne le dis pas au"
	line "monsieur, mais je"
	cont "trouve que le"
	cont "jonglage c'est"
	cont "ringard."
	
	para "Mais bon, je me"
	line "sens moins seule"
	cont "avec sa présence."
else
	text "Don't tell the man,"
	line "but I think"
	cont "juggling's lame."
	
	para "Though his"
	line "presence helps"
	cont "relieve my"
	cont "loneliness."
endc
	done

GoldenrodHospitalRoom23PatientText:
if DEF(_FR_FR)
	text "(TOUSSE)"

	para "Est-ce que je..."

	para "(TOUSSE)(TOUSSE)"
	
	para "(TOUSSE)(TOUSSE)"
	line "(TOUSSE)(TOUSSE)"

	para "..."

	para "Est-ce que je vais"
	line "m'en sortir,"
	cont "docteur?"

	para "(TOUSSE)(TOUSSE)"

	para "?"
else
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
endc
	done

GoldenrodHospitalRoom24PatientText:
if DEF(_FR_FR)
	text "Mon travail, c'est"
	line "de protéger la"
	cont "population en"
	cont "arrêtant ceux qui"
	cont "ne portent pas"
	cont "de masque."

	para "Au final..."

	para "(tousse)"

	para "...Au final, j'ai"
	line "dû attraper le"
	cont "virus par ceux"
	cont "que j'ai arrêtés."

	para "Je suis furieux."
else
	text "My job is to"
	line "protect the"
	cont "population by"
	cont "arresting people"
	cont "that do not wear"
	cont "a face mask."

	para "In the end…"

	para "(cough)"

	para "…In the end I must"
	line "have caught the"
	cont "virus from the"
	cont "people I arrested."

	para "I am furious."
endc
	done

GoldenrodHospitalRoom25Patient_FirstMeetingText:
if DEF(_FR_FR)
	text "Ma famille vit à"
	line "KANTO, alors je"
	cont "n'ai aucune visite."
	
	para "Ca me réchauffe"
	line "le coeur qu'une"
	cont "jeune personne"
	cont "comme toi prenne"
	cont "de son temps pour"
	cont "rendre visite à"
	cont "un vieil homme."
else
	text "My family lives in"
	line "KANTO so I don't"
	cont "get any visitors."
	
	para "It warms my heart"
	line "that a young"
	cont "person like you"
	cont "takes the time to"
	cont "visit an old man."
endc
	done

GoldenrodHospitalRoom25Patient_AlreadyMetText:
if DEF(_FR_FR)
	text "Je suis heureux de"
	line "te revoir!"
	
	para "Tu es vraiment une"
	line "personne pleine de"
	cont "compassion!"
else
	text "I am happy to see"
	line "you again!"
	
	para "You are such a"
	line "compassionnate"
	cont "person!"
endc
	done

GoldenrodHospitalRoom25Patient_TakeThisText:
if DEF(_FR_FR)
	text "Prends ceci en"
	line "gage de ma"
	cont "gratitude."
else
	text "Take this as a"
	line "sign of my"
	cont "gratitude."
endc
	done

GoldenrodHospitalRoom25Patient_BagFullText:
if DEF(_FR_FR)
	text "Tu ne peux pas le"
	line "prendre..."
	
	para "C'est une belle"
	line "occasion de me"
	cont "repasser visite"
	cont "plus tard!"
else
	text "You can't take it…"
	line "This is a good"
	cont "reason to come"
	cont "visit me again"
	cont "later!"
endc
	done

GoldenrodHospitalRoom25Patient_PartyFullText:
if DEF(_FR_FR)
	text "J'aimerais te"
	line "confier une"
	cont "mission."
	
	para "Mais il faut que"
	line "tu fasses de la"
	cont "place dans ton"
	cont "équipe avant."
	
	para "Je t'attendrai."
else
	text "I would like to"
	line "entrust you with"
	cont "a mission."
	
	para "But you need to"
	line "make some room in"
	cont "your party first."
	
	para "I will wait for"
	line "you."
endc
	done

GoldenrodHospitalRoom25Patient_NothingTodayText:
if DEF(_FR_FR)
	text "Malheureusement,"
	line "je n'ai plus rien"
	cont "à te donner"
	cont "aujourd'hui."
else
	text "Unfortunately, I"
	line "have nothing else"
	cont "to give you today."
endc
	done

GoldenrodHospitalRoom25Patient_ComeBackText:
if DEF(_FR_FR)
	text "Reviens un autre"
	line "jour si tel est"
	cont "ton souhait!"
else
	text "Come back another"
	line "day if you will!"
endc
	done

GoldenrodHospitalRoom25Patient_QuestStartText:
if DEF(_FR_FR)
	text "Je t'apprécie."
	
	para "J'aimerais te"
	line "demander une"
	cont "faveur, si ce n'est"
	cont "pas trop te"
	cont "demander."
	
	para "Ma femme ne m'a pas"
	line "rendu la moindre"
	cont "visite depuis mon"
	cont "arrivée dans cet"
	cont "hôpital."
	
	para "Je ne suis pas en"
	line "colère, plutôt..."
	cont "inquiet."
	
	para "Prends mon #MON"
	line "avec sa LETTRE et"
	cont "apporte-la-lui."
else
	text "I appreciate you."

	para "I would like to"
	line "ask you a favor,"
	cont "if it is not"
	cont "too much."

	para "My wife hasn't"
	line "visited me once"
	cont "since I arrived"
	cont "in this hospital."

	para "I am not angry,"
	line "I am… worried."

	para "Take my #MON"
	line "with its MAIL"
	cont "to her."
endc
	done

GoldenrodHospitalRoom25Patient_DeliverMailText:
if DEF(_FR_FR)
	text "Apporte la LETTRE"
	line "à ma femme,"
	cont "je te prie."

	para "Dis-lui qu'elle"
	line "vient de son mari,"
	cont "ANTON."

	para "Elle habite à"
	line "SAFRANIA, dans la"
	cont "région de KANTO."
else
	text "Please deliver the"
	line "MAIL to my wife."

	para "Tell her it comes"
	line "from her husband,"
	cont "ANTON."

	para "She lives in"
	line "SAFFRON CITY,"
	cont "in KANTO."
endc
	done

GoldenrodHospitalRoom25Patient_IzDedText:
if DEF(_FR_FR)
	text "(TOUSSE)"
	
	para "Je suis désolé, le"
	line "patient précédent"
	cont "est décédé."
	
	para "(TOUSSE)"
	
	para "C'est triste, mais"
	line "en même temps ça"
	cont "m'a permis d'avoir"
	cont "son lit. Et ça"
	cont "va peut-être me"
	cont "sauver la vie."
	
	para "(TOUSSE)"
else
	text "(COUGH)"

	para "I am sorry, but"
	line "the previous"
	cont "patient passed"
	cont "away."

	para "(COUGH)"

	para "It is sad but at"
	line "the same time it"
	cont "allowed me to get"
	cont "his room, which"
	cont "may save my life."

	para "(COUGH)"
endc
	done

GoldenrodHospitalRoom26PatientText:
if DEF(_FR_FR)
	text "Papa est"
	line "surprotecteur."

	para "Je crois qu'au fond"
	line "il a peur."
else
	text "Daddy is over-"
	line "protective."

	para "I think he's"
	line "scared."
endc
	done

GoldenrodHospitalRoom29PatientText:
if DEF(_FR_FR)
	text "(tousse)"
	
	para "J'ai entendu dire"
	line "qu'une célèbre"
	cont "dresseuse de"
	cont "#MON est morte"
	cont "dans cette"
	cont "chambre."
	
	para "Ca me donne la"
	line "chair de poule"
	cont "malgré ma fièvre."
else
	text "(cough)"

	para "I've heard a famous"
	line "#MON trainer"
	cont "died in this ER."

	para "This gives me"
	line "chills despite"
	cont "the fever."
endc
	done
	
GoldenrodHospitalRoom1PokemonPatientText:
if DEF(_FR_FR)
	text "Les feuilles de"
	line "MYSTHERBE ont l'air"
	cont "sèches."

	para "C'est signe qu'il"
	line "n'est pas en"
	cont "bonne santé."
else
	text "The leaves of the"
	line "ODDISH are looking"
	cont "dry."

	para "That's a sign it"
	line "is not healthy."
endc
	done

GoldenrodHospitalRoom1CaterpiePatientText:
if DEF(_FR_FR)
	text "Espérons que"
	line "CHENIPAN puisse"
	cont "être sauvé..."
else
	text "Hopefully CATERPIE"
	line "can be saved…"
endc
	done

GoldenrodHospitalRoom2PokemonPatientText:
if DEF(_FR_FR)
	text "Le SOPORIFIK n'a"
	line "même plus la force"
	cont "de remuer ses"
	cont "bras."

	para "Il doit être dans"
	line "un état critique."
else
	text "The DROWZEE doesn't"
	line "even have enough"
	cont "strength to wiggle"
	cont "its arms."

	para "It must be in"
	line "very bad shape."
endc
	done

GoldenrodHospitalRoom6PokemonPatientText:
if DEF(_FR_FR)
	text "Le pauvre PTITARD"
	line "semble souffrir..."
else
	text "Poor POLIWAG seems"
	line "to suffer…"
endc
	done

GoldenrodHospitalRoom8PokemonPatientText:
if DEF(_FR_FR)
	text "Pour une fois,"
	line "c'est le RONDOUDOU"
	cont "qui dort."
	
	para "Quelle ironie."
else
	text "For once, it's the"
	line "JIGGLYPUFF that's"
	cont "sleeping."
	
	para "How ironic."
endc
	done

GoldenrodHospitalRoom10PokemonPatientText:
if DEF(_FR_FR)
	text "L'ABRA pourrait"
	line "facilement se"
	cont "TELEPORTER hors"
	cont "d'ici."
	
	para "Mais il ne le fait"
	line "pas."

	para "Peut-être sait-il"
	line "qu'il vaut mieux"
	cont "rester ici."
else
	text "The ABRA could"
	line "easily TELEPORT"
	cont "away."
	
	para "But it doesn't."

	para "Perhaps it knows"
	line "that it's better"
	cont "to stay in here."
endc
	done

GoldenrodHospitalRoom13PokemonPatientText:
if DEF(_FR_FR)
	text "On voit que ce"
	line "MIAOUSS est"
	cont "malade, mais"
	
	para "il garde un"
	line "air joyeux."
else
	text "We can tell this"
	line "MEOWTH is sick"
	cont "but it still"
	cont "seems jolly."
endc
	done

GoldenrodHospitalRoom32PokemonPatientText:
if DEF(_FR_FR)
	text "Son état n'est pas"
	line "réjouissant..."
else
	text "Not looking good…"
endc
	done

	
	
	
GoldenrodHospitalRoom1BisVisitorText:
if DEF(_FR_FR)
	text "C'est moi qui ai"
	line "trouvé ce CHENIPAN"
	cont "malade."
	
	para "J'espère qu'il va"
	line "tenir bon."

	para "L'INFIRMIERE EN"
	line "CHEF m'a dit qu'il"
	cont "devrait s'en"
	cont "sortir."
else
	text "I was the one who"
	line "found this sick"
	cont "CATERPIE."
	
	para "I hope it will go"
	line "through this."

	para "CHIEF NURSE JOY"
	line "told me it should"
	cont "be fine."
endc
	done

GoldenrodHospitalRoom2VisitorText:
if DEF(_FR_FR)
	text "Quand une personne"
	line "infectée parle à"
	cont "quelqu'un de sain,"
	cont "le risque de"
	cont "transmission est"
	cont "de plus de 90<PERCENT>."
	
	para "C'est là que le"
	line "masque montre son"
	cont "utilité."

	para "Si la personne"
	line "saine en porte un,"
	cont "le risque tombe à"
	cont "70<PERCENT>."

	para "Encore mieux: si"
	line "c'est la personne"
	cont "infectée qui porte"
	cont "le masque, le"
	cont "risque chute à 5<PERCENT>."

	para "Et si les deux en"
	line "portent un, il"
	cont "n'est plus que de"
	cont "1.5<PERCENT>."

	para "Le virus ne peut"
	line "toutefois pas se"
	cont "transmettre d'un"
	cont "humain à un"
	cont "#MON."
else
	text "When an infected"
	line "person is talking"
	cont "to a healthy"
	cont "person, the odds"
	cont "of transmitting"
	cont "the virus are"
	cont "above 90<PERCENT>."
	
	para "That's when the"
	line "face mask shows"
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
endc
	done

GoldenrodHospitalRoom4VisitorText:
if DEF(_FR_FR)
	text "Normalement, les"
	line "virus ne se"
	cont "transmettent pas"
	cont "d'un #MON à"
	cont "un humain."
	
	para "Mais comme celui"
	line "du COVID touche"
	cont "aussi les humains,"
	
	para "il a dû muter dans"
	line "un #MON, dans"
	cont "des conditions"
	cont "très spécifiques,"
	cont "puis passer à un"
	cont "humain."
	
	para "Cette personne"
	line "serait notre"
	cont "patient zéro."
else
	text "Viruses normally"
	line "don't transmit from"
	cont "#MON to human."
	
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
endc
	done

GoldenrodHospitalRoom5VisitorText:
if DEF(_FR_FR)
	text "Nous prenons grand"
	line "soin de ce"
	cont "patient."
else
	text "We are taking"
	line "good care of"
	cont "this patient."
endc
	done

GoldenrodHospitalRoom6VisitorText:
if DEF(_FR_FR)
	text "Ce #MON devrait"
	line "survivre."
	
	para "Je veille sur lui."
else
	text "This #MON"
	line "should survive."
	
	para "I'm watching"
	line "over it."
endc
	done

GoldenrodHospitalRoom7VisitorText:
if DEF(_FR_FR)
	text "Je dois désinfec-"
	line "ter cette chambre"
	cont "rapidement, avant"
	cont "l'arrivée du"
	cont "prochain patient."
else
	text "I got to sanitize"
	line "this room quickly"
	cont "before the next"
	cont "patient comes in."
endc
	done

GoldenrodHospitalRoom10VisitorText:
if DEF(_FR_FR)
	text "Si tu as beaucoup"
	line "de temps devant"
	cont "toi, j'aimerais"
	cont "tout te dire de"
	cont "mes recherches."
else
	text "If you have a lot"
	line "of time ahead of"
	cont "you, I would like"
	cont "to tell you all"
	cont "about my research."
endc
	done

GoldenrodHospitalRoom10VisitorText2:
if DEF(_FR_FR)
	text "La majorité des"
	line "gens trouvent mes"
	cont "discours longs et"
	cont "ennuyeux."
	
	para "T'as vraiment le"
	line "temps pour moi?"
else
	text "Most people find"
	line "my speeches long"
	cont "and boring."
	
	para "Are you sure you"
	line "have time for it?"
endc
	done

GoldenrodHospitalRoom10VisitorYesText:
if DEF(_FR_FR)
	text "En étudiant les"
	line "effets du COVID,"
	
	para "j'ai appris beau-"
	line "coup sur les types"
	cont "des #MON."

	para "Les types FEU ne"
	line "peuvent pas être"
	cont "brûlés."

	para "Les types POISON"
	line "et ACIER ne "
	cont "peuvent pas être"
	cont "empoisonnés."

	para "Les types ELECTRIK"
	line "ne peuvent pas"
	cont "être paralysés."

	para "Les types SPECTRE"
	line "ne peuvent pas"
	cont "être piégés au"
	cont "combat."

	para "Les types PLANTE"
	line "ne sont pas"
	cont "affectés par les"
	cont "attaques à base de"
	cont "spores comme"
	cont "POUDRE DODO."

	para "Les types GLACE ne"
	line "peuvent pas être"
	cont "gelés. Leur DEF"
	cont "augmente de 50<PERCENT>"
	cont "sous GRELE, et ils"
	cont "y sont immunisés."

	para "Les types ROCHE"
	line "ont leur DEF.SPE."
	cont "augmentée de 50<PERCENT>"
	cont "sous TEMPETESABLE."

	para "Et ils ne subis-"
	line "sent pas ses"
	cont "dégâts, tout comme"
	cont "les types SOL et"
	cont "ACIER."
	
	para "Fascinant, non?"

	para "Je continue de"
	line "faire des décou-"
	cont "vertes, alors je"
	cont "ne sais pas encore"
	cont "tout."
else
	text "While studying the"
	line "effects of COVID,"

	para "I learned a lot"
	line "about #MON"
	cont "types."

	para "FIRE types can't"
	line "be BURNT."

	para "POISON and STEEL"
	line "types can't be"
	cont "POISONED."

	para "ELECTRIC types"
	line "can't be"
	cont "PARALYZED."

	para "GHOST types can't"
	line "be trapped."

	para "GRASS types aren't"
	line "affected by spore"
	cont "based moves like"
	cont "SLEEP POWDER."

	para "ICE types can't"
	line "be FROZEN. Their"
	cont "DEF is increased"
	cont "by 50<PERCENT> under HAIL,"
	cont "and they're immune"
	cont "to its damage."

	para "ROCK types have"
	line "their SPCL.DEF"
	cont "increased by 50<PERCENT>"
	cont "under SANDSTORM."

	para "Along with GROUND"
	line "and STEEL types,"
	cont "they receive no"
	cont "damage from the"
	cont "SANDSTORM."
	
	para "Fascinating"
	line "isn't it?"

	para "I'm still making"
	line "discoveries, so I"
	cont "probably don't know"
	cont "everything yet."
endc
	done

GoldenrodHospitalRoom10VisitorNoText:
if DEF(_FR_FR)
	text "Laisse tomber, tu"
	line "ne comprendrais"
	cont "rien de toute"
	cont "façon."
else
	text "Nevermind, you"
	line "wouldn't understand"
	cont "anyway."
endc
	done

GoldenrodHospitalRoom13VisitorText:
if DEF(_FR_FR)
	text "J'adore ce"
	line "#MON!"
	
	para "On devient de"
	line "vrais amis!"
else
	text "I just love this"
	line "#MON!"
	
	para "We are becoming"
	line "friends!"
endc
	done

GoldenrodHospitalRoom18VisitorText:
if DEF(_FR_FR)
	text "Le virus ne peut"
	line "pas traverser la"
	cont "coque d'une"
	cont "# BALL."
	
	para "C'est un moyen sûr"
	line "de quarantaine"
	cont "pour un #MON."
	
	para "J'aimerais pouvoir"
	line "rentrer dans une"
	cont "# BALL."
else
	text "The virus cannot"
	line "move through the"
	cont "shell of a #-"
	cont "BALL."
	
	para "It is a safe way"
	line "of quarantine for"
	cont "a #MON."
	
	para "I wish I could fit"
	line "into a #BALL."
endc
	done

GoldenrodHospitalRoom21VisitorText:
if DEF(_FR_FR)
	text "Vérifions l'état"
	line "de ce patient..."

	para "..."
	
	para "Signes vitaux OK."

	para "..."
	
	para "... Tout est bon!"
else
	text "Checking on this"
	line "patient…"

	para "…"
	
	para "Vitals are OK."

	para "…"
	
	para "… All good!"
endc
	done

GoldenrodHospitalRoom31VisitorText:
if DEF(_FR_FR)
	text "Mon mari délire"
	line "à cause de la"
	cont "fièvre."
else
	text "My husband is"
	line "delirious because"
	cont "of the fever."
endc
	done

GoldenrodHospitalRoom29VisitorText:
if DEF(_FR_FR)
	text "Tu ne fais pas"
	line "partie de la"
	cont "famille."

	para "Je te prie de"
	line "sortir d'ici."
else
	text "You are not part"
	line "of the family."

	para "Please leave."
endc
	done










	

GoldenrodHospitalLoreleiText:
if DEF(_FR_FR)
	text "Chut!"

	para "J'suis pas censée"
	line "exister ici, j'peux"
	cont "pas t'parler."
else
	text "Shush!"

	para "I'm not supposed"
	line "to exist in this"
	cont "game, I can't"
	cont "talk to you."
endc
	done

GoldenrodHospitalPatientDefaultText:
if DEF(_FR_FR)
	text "Dans les vappes."
	line "Ca doit être"
	cont "les médocs."
else
	text "Looking dizzy."
	line "Must be drugged."
endc
	done

GoldenrodHospitalRoomMedicineText:
if DEF(_FR_FR)
	text "Plein de"
	line "médicaments."
else
	text "Lots of different"
	line "medications."
endc
	done








; Quest speeches.
GoldenrodHospitalRoom_Quest2And18Text:
if DEF(_FR_FR)
	text "La dernière fois"
	line "que j'ai vu l'"
	cont "INFIRMIERE EN CHEF"
	cont "elle partait vers"
	cont "le couloir suivant"
	cont "vers la droite."
else
	text "When I last saw"
	line "CHIEF NURSE JOY"
	cont "today, she was"
	cont "moving to the"
	cont "next corridor"
	cont "on the right."
endc
	done

GoldenrodHospitalRoom_Quest5Text:
if DEF(_FR_FR)
	text "Je ne sais pas où"
	line "est l'INFIRMIERE"
	cont "EN CHEF, mais je"
	cont "l'ai entendue"
	cont "parler dans le"
	cont "couloir il y a"
	cont "quelques minutes."

	para "Espérons qu'elle"
	line "soit encore là."
else
	text "I can't tell you"
	line "where the CHIEF"
	cont "is, but I've heard"
	cont "her talking in the"
	cont "corridor a few"
	cont "minutes ago."

	para "Hopefully she is"
	line "still around."
endc
	done

GoldenrodHospitalRoom_Quest8Text:
if DEF(_FR_FR)
	text "J'ai vu l'INFIRMI-"
	line "ERE EN CHEF il y a"
	cont "quelques minutes."
	
	para "Je l'ai croisée"
	line "dans le couloir"
	cont "en arrivant de"
	cont "la chambre 11."

	para "Pour info, les"
	line "numéros de chambre"
	cont "sont indiqués sur"
	cont "les portes."
else
	text "I saw the CHIEF a"
	line "few minutes ago."
	
	para "I crossed her in"
	line "the corridor when"
	cont "I was coming from"
	cont "room 11."
endc
	done

GoldenrodHospitalRoom_Quest9Text:
if DEF(_FR_FR)
	text "Désolé, mais j'sais"
	line "pas où s'trouve"
	cont "l'INFIRMIERE"
	cont "EN CHEF."

	para "Mais on peut"
	line "papoter si tu"
	cont "veux."

	para "..."

	para "Reste un peu,"
	line "j'me sens si"
	cont "seul..."
else
	text "I'm sorry, I don't"
	line "know where the"
	cont "CHIEF NURSE is."

	para "But we can chat"
	line "if you'd like."

	para "Please stay, I'm"
	line "feeling so lonely…"
endc
	done

GoldenrodHospitalRoom_Quest10Text:
if DEF(_FR_FR)
	text "T'as pas le temps,"
	line "c'est ça?"

	para "..."

	para "Si j'ai vu l'"
	line "INFIRMIERE EN CHEF"
	cont "aujourd'hui?"

	para "Ah oui, pardon."
	
	para "Elle est partie il"
	line "y a quelques"
	cont "minutes."

	para "Elle est allée de"
	line "l'autre côté de"
	cont "ce couloir."
else
	text "In a hurry, huh?"

	para "…"

	para "Did I see the"
	line "CHIEF NURSE today?"

	para "Oh yes, excuse-me."
	
	para "She left a few"
	line "minutes ago."

	para "She went to the"
	line "opposite side"
	cont "of the corridor."
endc
	done

GoldenrodHospitalRoom_Quest11Text:
if DEF(_FR_FR)
	text "Non, j'ai pas vu l'"
	line "INFIRMIERE EN CHEF"
	cont "aujourd'hui."
	
	para "J'étais à l'instant"
	line "avec un SCIENTIFI-"
	cont "QUE qui est parti"
	cont "s'occuper d'un"
	cont "#MON dans la"
	cont "chambre 8."
else
	text "No, I haven't seen"
	line "CHIEF NURSE JOY"
	cont "today."
	
	para "I was just with"
	line "a SCIENTIST that"
	cont "left to take care"
	cont "of a #MON in"
	cont "room 8."
endc
	done

GoldenrodHospitalRoom_Quest12Text:
if DEF(_FR_FR)
	text "(TOUSSE)"
	line "(TOUSSE)"
	
	para "L'autre côté de ce"
	line "couloir va des"
	cont "chambres 25 à 28."
else
	text "(COUGH)"
	line "(COUGH)"
	
	para "The other side of"
	line "this corridor"
	cont "would be from"
	cont "room 25 to 28."
endc
	done

GoldenrodHospitalRoom_Quest13Text:
if DEF(_FR_FR)
	text "Non, je ne suis"
	line "pas l'INFIRMIERE EN"
	cont "CHEF, bien qu'on me"
	cont "dise souvent qu'on"
	cont "se ressemble."
	
	para "Je ne sais pas où"
	line "elle est pour le"
	cont "moment."
else
	text "No I am not"
	line "CHIEF NURSE JOY"
	cont "even though I've"
	cont "been told that"
	cont "we look alike."
	
	para "I have no idea"
	line "where she is at"
	cont "the moment."
endc
	done

GoldenrodHospitalRoom_Quest19Text:
if DEF(_FR_FR)
	text "J'ai vu l'INFIRMIE-"
	line "RE EN CHEF, mais"
	cont "c'était la semaine"
	cont "dernière."

	para "(TOUSSE)"
	line "(tousse)"
else
	text "I have seen CHIEF"
	line "NURSE JOY, but it"
	cont "was last week."

	para "(COUGH)"
	line "(cough)"
endc
	done

GoldenrodHospitalRoom_Quest27Text:
if DEF(_FR_FR)
	text "L'INFIRMIERE EN"
	line "CHEF s'occupait de"
	cont "moi quand soudai-"
	cont "nement..."
	
	para "(tousse)"
	
	para "...elle a dû"
	line "partir en urgence"
	cont "dans la chambre"
	cont "30-et-quelque."
else
	text "CHIEF NURSE JOY"
	line "was taking care"
	cont "of me when"
	cont "suddenly"
	
	para "(cough)"
	
	para "…she had to go"
	line "urgently in room"
	cont "30-something."
endc
	done

GoldenrodHospitalRoom_Quest31Text:
if DEF(_FR_FR)
	text "..."
	
	para "Oh oui, tout à"
	line "fait."
	
	para "L'INFIRMIRE EN"
	line "CHEF était ici"
	cont "à l'instant!"

	para "Elle est partie"
	line "il y a quelques"
	cont "secondes."
else
	text "…"
	
	para "Oh yes indeed."
	
	para "CHIEF NURSE JOY"
	line "was just here!"

	para "She left a few"
	line "seconds ago."
endc
	done

GoldenrodHospitalAnnounceLockdownText:
if DEF(_FR_FR)
	text "Hé toi."
else
	text "Hey you."
endc
	done

GoldenrodHospitalAnnounceLockdown2Text:
if DEF(_FR_FR)
	text "Tu n'as rien à"
	line "faire ici."

	para "Le confinement"
	line "vient de débuter."

	para "Rentre chez toi"
	line "sinon j'appelle"
	cont "la sécurité."
else
	text "You have nothing"
	line "to do here."

	para "Lockdown has"
	line "started."

	para "Go home or I'll"
	line "call security."
endc
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
	bg_event  0,  8, BGEVENT_ITEM, GoldenrodHospitalRoomSuperPotion

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
	object_event 12, 12, SPRITE_FISHER, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerRoom3Script, -1 ; This trainer can't walk, so the clapping animation can't break its walking animation.
	object_event 12, 12, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerRoom8Script, -1
	object_event 12, 12, SPRITE_SUPER_NERD, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerRoom17Script, -1 ; This trainer can't walk, so the clapping animation can't break its walking animation.
	object_event 12, 12, SPRITE_BLACK_BELT, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 1, GoldenrodHospitalRoomTrainerRoom26Script, -1 ; This trainer can't walk, so the clapping animation can't break its walking animation.
	object_event 12, 12, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerRoom30Script, -1
	object_event 12, 12, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 0, GoldenrodHospitalRoomTrainerRoom31Script, -1
	object_event 12, 12, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, GoldenrodHospitalRoomTrainerRoom32Script, -1
	object_event 12, 12, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRoomTrainerChiefNurseScript, -1
	object_event 12, 12, SPRITE_LORELEI, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHospitalRoomLoreleiScript, -1

	; Items.
	object_event 12, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, GoldenrodHospitalRoom_ItemBall7Script, EVENT_GOLDENROD_HOSPITAL_ITEM_ROOM_7
	object_event 12, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, GoldenrodHospitalRoom_ItemBall15Script, EVENT_GOLDENROD_HOSPITAL_ITEM_ROOM_15

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
