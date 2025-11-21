	object_const_def
	const ROUTE37_POLICE_1_1
	const ROUTE37_POLICE_2_1
	const ROUTE37_POLICE_2_2
	const ROUTE37_POLICE_2_3
	const ROUTE37_POLICE_3_1
	const ROUTE37_POLICE_3_2
	const ROUTE37_POLICE_4_1
	const ROUTE37_POLICE_4_2
	const ROUTE37_POLICE_4_3
	
	const ROUTE37_WEIRD_TREE1
	const ROUTE37_WEIRD_TREE2
	const ROUTE37_YOUNGSTER
	const ROUTE37_FRUIT_TREE1
	const ROUTE37_SUNNY
	const ROUTE37_FRUIT_TREE2
	const ROUTE37_FRUIT_TREE3

Route37_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Sunny

.Sunny:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .SunnyAppears
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; ROUTE37_SUNNY
	endcallback

.SunnyAppears:
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; ROUTE37_SUNNY
	endcallback

TrainerTwinsAnnandanne1:
	trainer TWINS, ANNANDANNE1, EVENT_BEAT_TWINS_ANN_AND_ANNE, TwinsAnnandanne1SeenText, TwinsAnnandanne1BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TwinsAnnandanne1AfterBattleText

TrainerTwinsAnnandanne2:
	trainer TWINS, ANNANDANNE2, EVENT_BEAT_TWINS_ANN_AND_ANNE, TwinsAnnandanne2SeenText, TwinsAnnandanne2BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TwinsAnnandanne2AfterBattleText

TrainerPsychicGreg:
	trainer PSYCHIC_T, GREG, EVENT_BEAT_PSYCHIC_GREG, PsychicGregSeenText, PsychicGregBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PsychicGregAfterBattleText

SunnyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_MAGNET_FROM_SUNNY
	iftrue SunnySundayScript
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, SunnyNotSundayScript
	checkevent EVENT_MET_SUNNY_OF_SUNDAY
	iftrue .MetSunny
	writetext MeetSunnyText
	promptbutton
	setevent EVENT_MET_SUNNY_OF_SUNDAY
.MetSunny:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Kris
	writetext SunnyGivesGiftText1
	promptbutton
	sjump .next
.Kris:
	writetext SunnyGivesGiftText2
	promptbutton
.next
	verbosegiveitem MAGNET
	iffalse SunnyDoneScript
	setevent EVENT_GOT_MAGNET_FROM_SUNNY
	writetext SunnyGaveGiftText
	waitbutton
	closetext
	end

SunnySundayScript:
	writetext SunnySundayText
	waitbutton
SunnyDoneScript:
	closetext
	end

SunnyNotSundayScript:
	writetext SunnyNotSundayText
	waitbutton
	closetext
	end

Route37Sign:
	jumptext Route37SignText

Route37FruitTree1:
	fruittree FRUITTREE_ROUTE_37_1

Route37FruitTree2:
	fruittree FRUITTREE_ROUTE_37_2

Route37FruitTree3:
	fruittree FRUITTREE_ROUTE_37_3

Route37HiddenEther:
	hiddenitem ETHER, EVENT_ROUTE_37_HIDDEN_ETHER

TwinsAnnandanne1SeenText: 
if DEF(_FR_FR)
	text "TEA: LEA et moi"
	line "sommes insépara-"
	cont "bles!"
else
	text "ANN: ANNE and I"
	line "are in this to-"
	cont "gether!"
endc

	done

TwinsAnnandanne1BeatenText: 
if DEF(_FR_FR)
	text "TEA&LEA: ..."
	line "Pas possible."
else
	text "ANN & ANNE: Nnn… A"
	line "little too strong."
endc

	done

TwinsAnnandanne1AfterBattleText: 
if DEF(_FR_FR)
	text "TEA: Je pense"
	line "comme ma soeur et"

	para "comme mes #MON."
else
	text "ANN: I can tell"
	line "what my sister and"

	para "my #MON are"
	line "thinking."
endc

	done

TwinsAnnandanne2SeenText: 
if DEF(_FR_FR)
	text "LEA: TEA et moi"
	line "sommes insépara-"
	cont "bles!"
else
	text "ANNE: ANN and I"
	line "are in this to-"
	cont "gether!"
endc

	done

TwinsAnnandanne2BeatenText:
if DEF(_FR_FR)
	text "LEA&TEA: ..."
	line "Pas possible."
else
	text "ANNE & ANN: Nnn… A"
	line "little too strong."
endc
	done

TwinsAnnandanne2AfterBattleText: 
if DEF(_FR_FR)
	text "LEA: Nous ressen-"
	line "tons les mêmes"
	cont "choses que nos"
	cont "#MON."
else
	text "ANNE: We share the"
	line "same feelings as"
	cont "our #MON."
endc

	done

PsychicGregSeenText: 
if DEF(_FR_FR)
	text "Les #MON ne"
	line "peuvent rien faire"
	cont "s'ils dorment."

	para "Tu vas voir quel"
	line "effet ça fait!"
else
	text "#MON can't do a"
	line "thing if they are"
	cont "asleep."

	para "I'll show you how"
	line "scary that is!"
endc

	done

PsychicGregBeatenText: 
if DEF(_FR_FR)
	text "Perdu. C'est"
	line "pas cool, ça..."
else
	text "I lost. That's"
	line "pretty sad…"
endc

	done

PsychicGregAfterBattleText: 
if DEF(_FR_FR)
	text "Endormir ou para-"
	line "lyser les #MON"
	cont "est super utile"
	cont "en combat."
else
	text "Putting #MON to"
	line "sleep or paralyz-"
	cont "ing them are good"
	cont "battle techniques."
endc

	done

MeetSunnyText: 
if DEF(_FR_FR)
	text "DIMITRI: Salut!"

	para "Moi c'est DIMITRI"
	line "du dimanche. Et on"
	cont "est dimanche!"
else
	text "SUNNY: Hi!"

	para "I'm SUNNY of Sun-"
	line "day, meaning it's"
	cont "Sunday today!"
endc

	done

SunnyGivesGiftText1: 
if DEF(_FR_FR)
	text "On m'a dit de te"
	line "donner ça!"
else
	text "I was told to give"
	line "you this if I saw"
	cont "you!"
endc

	done

SunnyGivesGiftText2: 
if DEF(_FR_FR)
	text "On m'a dit de te"
	line "donner ça!"
else
	text "I was told to give"
	line "you this if I saw"
	cont "you!"
endc

	done

SunnyGaveGiftText: 
if DEF(_FR_FR)
	text "DIMITRI: Ca..."

	para "Heu..."

	para "...C'est..."

	para "..."

	para "Oh! Je me "
	line "souviens!"

	para "C'est pour un"
	line "#MON à capaci-"
	cont "tés électriques."

	para "Ma soeur LUCIE"
	line "dit que ça les"
	cont "améliore!"
else
	text "SUNNY: That thing…"

	para "Um…"

	para "… What was it now…"

	para "…"

	para "Oh! I remember"
	line "now!"

	para "A #MON that"
	line "knows electric"

	para "moves should hold"
	line "it."

	para "My sis MONICA said"
	line "it powers up"
	cont "electric moves!"
endc

	done

SunnySundayText: 
if DEF(_FR_FR)
	text "DIMITRI: Mes frè-"
	line "res et soeurs sont"
	cont "LUCIE, MARIE,"
	cont "HOMER, JEROME,"
	cont "VANESSA et SAMUEL."

	para "Ils sont tous plus"
	line "vieux que moi!"
else
	text "SUNNY: My sisters"
	line "and brothers are"
	cont "MONICA, TUSCANY,"
	cont "WESLEY, ARTHUR,"
	cont "FRIEDA and SANTOS."

	para "They're all older"
	line "than me!"
endc

	done

SunnyNotSundayText: 
if DEF(_FR_FR)
	text "DIMITRI: On est"
	line "pas dimanche?"
	cont "Heu! Je sais plus!"
else
	text "SUNNY: Isn't today"
	line "Sunday?"
	cont "Um… I forgot!"
endc

	done

Route37SignText: 
if DEF(_FR_FR)
	text "ROUTE 37"
else
	text "ROUTE 37"
endc

	done

Route37_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  5,  3, BGEVENT_READ, Route37Sign
	bg_event  4,  2, BGEVENT_ITEM, Route37HiddenEther

	def_object_events
	object_event  7,  8, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event 17, 11, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  5,  5, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event  6,  6, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event  8, 12, SPRITE_OFFICER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 15, 12, SPRITE_OFFICER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event 15,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  6, 11, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 2, 2, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 1, PoliceTrainer, -1

	object_event  6, 12, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerTwinsAnnandanne1, -1
	object_event  7, 12, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerTwinsAnnandanne2, -1
	object_event  6,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerPsychicGreg, -1
	object_event 13,  5, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route37FruitTree1, -1
	object_event 16,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, SunnyScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 16,  5, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route37FruitTree2, -1
	object_event 15,  7, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route37FruitTree3, -1
