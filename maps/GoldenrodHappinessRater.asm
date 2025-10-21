	object_const_def
	const GOLDENRODHAPPINESSRATER_TEACHER
	const GOLDENRODHAPPINESSRATER_POKEFAN_M
	const GOLDENRODHAPPINESSRATER_TWIN

GoldenrodHappinessRater_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject GOLDENRODHAPPINESSRATER_TEACHER, 5, 1
	moveobject GOLDENRODHAPPINESSRATER_TWIN, 6, 1
	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
	loadmem wMap3ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
	endcallback

.TilesLoad
	readmem wCurFreedomState
	ifequal 1 << FREE, .end
	ifequal 1 << VACCINE_PASSPORT, .end

	changeblock  4,  2, $35
.end
	endcallback

GoldenrodHappinessRaterTeacherScript:
	faceplayer
	opentext
	special GetFirstPokemonHappiness
	writetext GoldenrodHappinessRaterTeacherText
	promptbutton
	ifgreater 250 - 1, .LovesYouALot
	ifgreater 200 - 1, .ReallyTrustsYou
	ifgreater 150 - 1, .SortOfHappy
	ifgreater 100 - 1, .QuiteCute
	ifgreater  50 - 1, .NotUsedToYou
	sjump .LooksMean

.LovesYouALot:
	writetext GoldenrodHappinessRatingText_LovesYouALot
	waitbutton
	closetext
	end

.ReallyTrustsYou:
	writetext GoldenrodHappinessRatingText_ReallyTrustsYou
	waitbutton
	closetext
	end

.SortOfHappy:
	writetext GoldenrodHappinessRatingText_SortOfHappy
	waitbutton
	closetext
	end

.QuiteCute:
	writetext GoldenrodHappinessRatingText_QuiteCute
	waitbutton
	closetext
	end

.NotUsedToYou:
	writetext GoldenrodHappinessRatingText_NotUsedToYou
	waitbutton
	closetext
	end

.LooksMean:
	writetext GoldenrodHappinessRatingText_LooksMean
	waitbutton
	closetext
	end

GoldenrodHappinessRaterPokefanMScript:
	faceplayer
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .lockdown

	jumptext GoldenrodHappinessRaterPokefanMText
.lockdown
	opentext
	writetext GoldenrodHappinessRaterPokefanMCatFilterText
	waitbutton
	closetext
	turnobject GOLDENRODHAPPINESSRATER_POKEFAN_M, LEFT
	end

GoldenrodHappinessRaterTwinScript:
	jumptextfaceplayer GoldenrodHappinessRaterTwinText

GoldenrodHappinessRaterComputer1Script:
	jumptext GoldenrodHappinessRaterComputer1Text

HappinessRatersHouseBookshelf:
	jumpstd DifficultBookshelfScript

HappinessRatersHouseRadio:
	jumpstd Radio2Script

GoldenrodHappinessRaterTeacherText: 
if DEF(_FR_FR)
	text "Si tu traites tes"
	line "#MON avec"

	para "amour, ils te le"
	line "rendront bien."

	para "Oh? Montre-moi"
	line "ton @"
	text_ram wStringBuffer3
	text "."
else
	text "If you treat your"
	line "#MON nicely,"

	para "they will love you"
	line "in return."

	para "Oh? Let me see"
	line "your @"
	text_ram wStringBuffer3
	text "…"
endc

	done

GoldenrodHappinessRatingText_LovesYouALot: 
if DEF(_FR_FR)
	text "Il a l'air très"
	line "content! Il doit"
	cont "t'aimer énormé-"
	cont "ment."
else
	text "It looks really"
	line "happy! It must"
	cont "love you a lot."
endc

	done

GoldenrodHappinessRatingText_ReallyTrustsYou: 
if DEF(_FR_FR)
	text "J'ai le sentiment"
	line "qu'il te fait"
	cont "vraiment, vraiment"
	cont "confiance."
else
	text "I get the feeling"
	line "that it really"
	cont "trusts you."
endc

	done

GoldenrodHappinessRatingText_SortOfHappy: 
if DEF(_FR_FR)
	text "Tu es vraiment un"
	line "amour..."
	cont "Un nuage de"
	cont "bonne humeur et"
	cont "de gentillesse"
	cont "flotte au-dessus"
	cont "de toi."
else
	text "It's friendly to-"
	line "ward you. It looks"
	cont "sort of happy."
endc

	done

GoldenrodHappinessRatingText_QuiteCute: 
if DEF(_FR_FR)
	text "C'est trop chou."
else
	text "It's quite cute."
endc

	done

GoldenrodHappinessRatingText_NotUsedToYou: 
if DEF(_FR_FR)
	text "Tu devrais mieux"
	line "le traiter. C'est"
	cont "pour ton bien."
else
	text "You should treat"
	line "it better. It's"
	cont "not used to you."
endc

	done

GoldenrodHappinessRatingText_LooksMean: 
if DEF(_FR_FR)
	text "Il n'a pas l'air"
	line "de beaucoup"
	cont "t'aimer. Il a"
	cont "l'air triste."
else
	text "It doesn't seem to"
	line "like you at all."
	cont "It looks mean."
endc

	done

GoldenrodHappinessRaterPokefanMText: 
if DEF(_FR_FR)
	text "Je ne fais que"
	line "perdre les combats"

	para "avec mes #MON,"
	line "ils sont tout le"
	cont "temps K.O..."

	para "C'est peut-être"
	line "pour ça que mes"
	cont "#MON ne"
	cont "m'aiment pas trop!"
else
	text "I keep losing in"
	line "battles, and my"

	para "#MON end up"
	line "fainting…"

	para "Maybe that's why"
	line "my #MON don't"
	cont "like me much…"
endc

	done

GoldenrodHappinessRaterPokefanMCatFilterText:
if DEF(_FR_FR)
	text "Je ne suis pas un"
	line "MIAOUSS!"
else
	text "I'm not a MEOWTH!"
endc
	done

GoldenrodHappinessRaterComputer1Text:
if DEF(_FR_FR)
	text "Cet homme est en"
	line "audience virtuelle"
	cont "avec un juge."

	para "Il a... un filtre"
	line "MIAOUSS activé."
else
	text "This man is on a"
	line "virtual hearing"
	cont "with a judge."

	para "He has… a MEOWTH"
	line "filter turned on."
endc
	done

GoldenrodHappinessRaterTwinText: 
if DEF(_FR_FR)
	text "Lorsque j'utilise"
	line "un objet sur mes"
	cont "#MON, ça"
	cont "fait des trucs"
	cont "cool!"
else
	text "When I use an item"
	line "on my #MON, it"
	cont "acts really glad!"
endc

	done

GoldenrodHappinessRater_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 3
	warp_event  3,  7, GOLDENROD_CITY, 3

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, HappinessRatersHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, HappinessRatersHouseBookshelf
	bg_event  7,  1, BGEVENT_READ, HappinessRatersHouseRadio

	def_object_events
	object_event  2,  4, SPRITE_TEACHER, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodHappinessRaterTeacherScript, -1
	object_event  5,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHappinessRaterPokefanMScript, -1
	object_event  5,  6, SPRITE_TWIN, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodHappinessRaterTwinScript, -1
	object_event  4,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHappinessRaterComputer1Script, -1
	
