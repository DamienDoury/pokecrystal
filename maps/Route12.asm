	object_const_def
	const ROUTE12_FISHER1
	const ROUTE12_FISHER2
	const ROUTE12_FISHER3
	const ROUTE12_FISHER4
	const ROUTE12_POKE_BALL1
	const ROUTE12_POKE_BALL2
	const ROUTE12_TEACHER1
	const ROUTE12_YOUNGSTER1
	const ROUTE12_YOUNGSTER2
	const ROUTE12_SAILOR1
	const ROUTE12_SAILOR2
	const ROUTE12_POKEFANM1

Route12_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .CheckMomCall
	
.CheckMomCall:
	checkevent EVENT_MOM_CALLED_ABOUT_VACCINATION_PASS
	iftrue .end

	setevent EVENT_MOM_CALLED_ABOUT_VACCINATION_PASS
	specialphonecall SPECIALCALL_VACCINE_PASSPORT

.end
	endcallback

TrainerFisherKyle:
	trainer FISHER, KYLE, EVENT_BEAT_FISHER_KYLE, FisherKyleSeenText, FisherKyleBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherKyleAfterBattleText

TrainerFisherMartin:
	trainer FISHER, MARTIN, EVENT_BEAT_FISHER_MARTIN, FisherMartinSeenText, FisherMartinBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherMartinAfterBattleText

TrainerFisherStephen:
	trainer FISHER, STEPHEN, EVENT_BEAT_FISHER_STEPHEN, FisherStephenSeenText, FisherStephenBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherStephenAfterBattleText

TrainerFisherBarney:
	trainer FISHER, BARNEY, EVENT_BEAT_FISHER_BARNEY, FisherBarneySeenText, FisherBarneyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FisherBarneyAfterBattleText

TrainerTeacherCecilia:
	trainer TEACHER, CECILIA, EVENT_BEAT_TEACHER_CECILIA, TeacherCeciliaSeenText, TeacherCeciliaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TeacherCeciliaAfterBattleText

TrainerSchoolboySawara:
	trainer SCHOOLBOY, SAWARA, EVENT_BEAT_SCHOOLBOY_SAWARA, SchoolboySawaraSeenText, SchoolboySawaraBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SchoolboySawaraAfterBattleText

TrainerSchoolboyGinko:
	trainer SCHOOLBOY, GINKO, EVENT_BEAT_SCHOOLBOY_GINKO, SchoolboyGinkoSeenText, SchoolboyGinkoBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SchoolboyGinkoSeenText

TrainerSailorClovis:
	trainer SAILOR, CLOVIS, EVENT_BEAT_SAILOR_CLOVIS, SailorClovisSeenText, SailorClovisBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SailorClovisAfterBattleText

TrainerSailorStrand:
	trainer SAILOR, STRAND, EVENT_BEAT_SAILOR_STRAND, SailorStrandSeenText, SailorStrandBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SailorStrandAfterBattleText

TrainerPokefanMNovak:
	trainer POKEFANM, NOVAK, EVENT_BEAT_POKEFANM_NOVAK, PokefanMNovakSeenText, PokefanMNovakBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PokefanMNovakAfterBattleText

Route12_LockdownSpeakerScript:
	jumptextfaceplayer Route12_LockdownSpeakerText

Route12_TeacherLockdownScript:
	faceplayer
	opentext
	writetext Route12_TeacherLockdown1Text
	yesorno
	iftrue .no_1

	writetext Route12_TeacherLockdown3Text
	yesorno
	iffalse .close_text

	writetext Route12_TeacherLockdown5Text
	sjump .text_end

.no_1
	writetext Route12_TeacherLockdown2Text
.text_end
	waitbutton
.close_text
	closetext
	end

Route12Sign:
	jumptext Route12SignText

FishingSpotSign:
	jumptext FishingSpotSignText

Route12Calcium:
	itemball CALCIUM

Route12Nugget:
	itemball TOILET_PAPER

Route12FruitTree:
	fruittree FRUITTREE_ROUTE_12

Route12HiddenElixer:
	hiddenitem ELIXER, EVENT_ROUTE_12_HIDDEN_ELIXER

FisherMartinSeenText: ; AUTOTRAD
	text "Patience is the"
	line "key to both fish-"
	cont "ing and #MON."
	done

FisherMartinBeatenText: ; AUTOTRAD
	text "Gwaaah!"
	done

FisherMartinAfterBattleText: ; AUTOTRAD
	text "I'm too impatient"
	line "for fishing…"
	done

FisherStephenSeenText: ; AUTOTRAD
	text "I feel so content,"
	line "fishing while lis-"
	cont "tening to some"
	cont "tunes on my radio."
	done

FisherStephenBeatenText: ; AUTOTRAD
	text "My stupid radio"
	line "distracted me!"
	done

FisherStephenAfterBattleText: ; AUTOTRAD
	text "Have you checked"
	line "out KANTO's radio"

	para "programs? We get a"
	line "good variety here."
	done

FisherBarneySeenText: ; AUTOTRAD
	text "What's most impor-"
	line "tant in our every-"
	cont "day lives?"
	done

FisherBarneyBeatenText: ; AUTOTRAD
	text "The answer is"
	line "coming up next!"
	done

FisherBarneyAfterBattleText: ; AUTOTRAD
	text "I think electric-"
	line "ity is the most"

	para "important thing in"
	line "our daily lives."

	para "If it weren't,"
	line "people wouldn't"

	para "have made such a"
	line "fuss when the"

	para "POWER PLANT went"
	line "out of commission."
	done

FisherKyleSeenText: ; AUTOTRAD
	text "Do you remember?"
	done

FisherKyleBeatenText: ; AUTOTRAD
	text "You do remember?"
	done

FisherKyleAfterBattleText: ; AUTOTRAD
	text "The tug you feel"
	line "on the ROD when"

	para "you hook a #-"
	line "MON…"

	para "That's the best"
	line "feeling ever for"
	cont "an angler like me."
	done

TeacherCeciliaSeenText: ; TO TRANSLATE
	text "Now that the stay-"
	line "at-home order is"
	cont "gone, it's time"
	cont "for field trips!"
	done

TeacherCeciliaBeatenText: ; TO TRANSLATE
	text "… … …"
	done

TeacherCeciliaAfterBattleText: ; TO TRANSLATE
	text "I like walking"
	line "around large"
	cont "bodies of water."
	done

SchoolboySawaraSeenText: ; TO TRANSLATE
	text "I'm grateful to"
	line "my teacher for"
	cont "this trip!"
	done

SchoolboySawaraBeatenText: ; TO TRANSLATE
	text "I'm still learning."
	done

SchoolboySawaraAfterBattleText: ; TO TRANSLATE
	text "My brother GINKO…"

	para "He's weird since"
	line "the lockdown…"
	done

SchoolboyGinkoSeenText: ; TO TRANSLATE
	text "RUN RUN RUN"
	line "RUN RUN RUN"
	done

SchoolboyGinkoBeatenText: ; TO TRANSLATE
	text "*derp*"
	done

SailorClovisSeenText: ; TO TRANSLATE
	text "I'm stuck here with"
	line "the S.S.AQUA."

	para "It's like a new"
	line "lockdown…"
	done

SailorClovisBeatenText: ; TO TRANSLATE
	text "I just want to go"
	line "back to JOHTO…"
	done

SailorClovisAfterBattleText: ; TO TRANSLATE
	text "Wait… Did I miss"
	line "the S.S.AQUA"
	cont "departure?"
	done

SailorStrandSeenText: ; TO TRANSLATE
	text "Aaah, the horizon…"
	done

SailorStrandBeatenText: ; TO TRANSLATE
	text "You're breaking my"
	line "peacefulness."
	done

SailorStrandAfterBattleText: ; TO TRANSLATE
	text "I've visited many"
	line "places."

	para "Did you know the"
	line "pandemic barely"
	cont "hit the ONWA"
	cont "region?"
	done

PokefanMNovakSeenText: ; TO TRANSLATE
	text "So you're vacci-"
	line "nated, uh?"
	done

PokefanMNovakBeatenText: ; TO TRANSLATE
	text "How could I lose"
	line "to a pharma shill?"
	done

PokefanMNovakAfterBattleText: ; TO TRANSLATE
	text "What's the point of"
	line "getting injected"
	cont "some chemicals,"

	para "when instead, you"
	line "can use proven"
	cont "naturals methods"

	para "like breathing"
	line "salty sea air,"
	cont "and eating well?"
	done

Route12_TeacherLockdown1Text: ; TO TRANSLATE
	text "Do you know what"
	line "the worst aspect"
	cont "of the lockdown"
	cont "was?"
	done
	
Route12_TeacherLockdown2Text: ; TO TRANSLATE
	text "You've lived"
	line "through it,"
	cont "haven't you?"
	done

Route12_TeacherLockdown3Text: ; TO TRANSLATE
	text "Do you want"
	line "to know?"
	done

Route12_TeacherLockdown5Text: ; TO TRANSLATE
	text "It's not being"
	line "emprisoned in an"
	cont "enclosed space."
	
	para "After all, we can"
	line "all spend a week-"
	cont "end at home"
	cont "without going out."

	para "The worst aspect"
	line "was being trapped"
	cont "in time."

	para "At first, the"
	line "authorithies said"
	cont "the lockdown was"
	cont "going to last for"
	cont "2 weeks."

	para "It may not seem"
	line "like a lot."
	
	para "But with the panic"
	line "that was already"
	cont "settling, it felt"
	cont "like forever."

	para "And it's not just"
	line "you who's trapped"
	cont "home. The whole"
	cont "world stopped for"
	cont "2 weeks."

	para "I remember looking"
	line "through the"
	cont "windows of my"
	cont "apartment and"
	cont "seeing absolutely"
	cont "no one outside."

	para "Just like in a"
	line "dystopian movie."

	para "So you turn on"
	line "your TV or your"
	cont "computer to get"
	cont "a some comfort."
	
	para "And all you find"
	line "there is alarming"
	cont "news."

	para "After the initial"
	line "period, they"
	
	para "prolonged it for"
	line "2 more weeks."
	
	para "Imagine the amount"
	line "of stress it"
	cont "caused."

	para "And then after"
	line "that, they said"
	cont "they'll prolong it"
	cont "“until necessary”…"

	para "It lasted for"
	line "about 2 months."

	para "Stuck between"
	line "four walls."
	
	para "Many people went"
	line "into depression."

	para "After finally"
	line "being released,"
	cont "socializing wasn't"
	cont "natural anymore."

	para "We had lost"
	line "this skill!"

	para "Seeing relatives"
	line "felt weird, as"
	cont "everyone had"
	cont "changed in their"
	cont "own way."
	
	para "Crazy times."
	done

Route12_LockdownSpeakerText: ; TO TRANSLATE
	text "I remember the"
	line "first lockdown"
	cont "declaration was"
	cont "a shock. We went"
	
	para "from “everything's"
	line "gonna be alright”"
	
	para "to “stay home or"
	line "perish”."
	done

Route12SignText: ; AUTOTRAD
	text "ROUTE 12"

	para "NORTH TO LAVENDER"
	line "TOWN"
	done

FishingSpotSignText: ; AUTOTRAD
	text "FISHING SPOT"
	done

Route12_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11, 65, ROUTE_12_SUPER_ROD_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 11, 51, BGEVENT_READ, Route12Sign
	bg_event 13,  9, BGEVENT_READ, FishingSpotSign
	bg_event 14, 23, BGEVENT_ITEM, Route12HiddenElixer

	def_object_events
	object_event  5, 23, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherMartin, -1
	object_event 14, 45, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherStephen, -1
	object_event  9, 70, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 5, TrainerFisherBarney, -1
	object_event  6,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerFisherKyle, -1
	object_event  5, 77, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route12Calcium, EVENT_ROUTE_12_CALCIUM
	object_event  4, 86, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route12Nugget, EVENT_ROUTE_12_NUGGET
	object_event  5, 87, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route12FruitTree, -1
	object_event 12, 40, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerTeacherCecilia, -1
	object_event 15, 38, SPRITE_YOUNGSTER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 1, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSchoolboyGinko, -1
	object_event 15, 41, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerSchoolboySawara, -1
	object_event 10, 48, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSailorClovis, -1
	object_event 17,  9, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSailorStrand, -1
	object_event 15, 79, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 4, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerPokefanMNovak, -1
	object_event 11, 29, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route12_LockdownSpeakerScript, -1
	object_event 13, 29, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route12_TeacherLockdownScript, -1
