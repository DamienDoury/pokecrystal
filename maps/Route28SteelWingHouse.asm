	object_const_def
	const ROUTE28STEELWINGHOUSE_CELEBRITY
	const ROUTE28STEELWINGHOUSE_FEAROW

Route28SteelWingHouse_MapScripts:
	def_scene_scripts
	scene_script .DummyScene

	def_callbacks

.DummyScene:
	end

Celebrity:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; True if the player refused to learn Sky Attack.
	iftrue .covid_chat

	writetext CelebrityText1
	promptbutton
	writetext CelebrityBegging
	promptbutton
	writetext CelebrityAskTeach
	yesorno
	iffalse .refused

	farwritetext GoldenrodCityMoveTutorMoveText
	callasm TopCelebrityMoveTutor
	ifequal -1, .cancelled
	
.covid_chat
	writetext CelebrityText2
	sjump .text_end

.cancelled
	farwritetext GoldenrodCityMoveTutorBButText
	promptbutton
	sjump .refused_2

.refused
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
.refused_2
	writetext CelebrityBegging
.text_end
	waitbutton
	closetext
	end

CelebritysFearow:
	opentext
	writetext CelebritysFearowText
	cry FEAROW
	waitbutton
	closetext
	end

CelebrityHouseBookshelf:
	jumpstd MagazineBookshelfScript

CelebrityText1:
if DEF(_FR_FR)
	text "Oh ben mince."
	line "Tu m'as trouvée."
else
	text "Oh, dear."
	line "You've found me."
endc
	done

CelebrityAskTeach:
if DEF(_FR_FR)
	text "Si tu acceptes de"
	line "garder mon secret,"
	cont "j'apprendrai à ton"
	cont "#MON la plus"
	cont "puissante attaque"
	cont "de type VOL:"
	cont "PIQUE."
else
	text "For keeping my"
	line "secret, I'll teach"
	cont "your #MON the"
	cont "strongest FLYING-"
	cont "type move there"
	cont "is: SKY ATTACK."
endc
	done

CelebrityBegging:
if DEF(_FR_FR)
	text "Ne parle de moi à"
	line "personne."
else
	text "Please don't tell"
	line "anyone about me."
endc
	done

CelebrityText2:
if DEF(_FR_FR)
	text "Partir vivre dans"
	line "un endroit aussi"
	cont "reculé était une"
	cont "bonne décision."
	
	para "J'ai passé un"
	line "confinement"
	cont "confortable,"
	
	para "et je n'ai pas"
	line "attrapé le COVID"
	cont "une seule fois,"
	
	para "puisque je suis"
	line "la seule personne"
	cont "vivant dans les"
	cont "environs!"
	
	para "En ville, mes fans"
	line "me poursuivaient"
	cont "partout où"
	cont "j'allais."
	
	para "Pas facile d'être"
	line "une célébrité."
else
	text "Moving to such a"
	line "far away place was"
	cont "a good decision."
	
	para "I spent a comfor-"
	line "table lockdown,"
	
	para "and I didn't catch"
	line "COVID even once as"
	
	para "I'm the only one"
	line "living around!"

	para "In the city, fans"
	line "chased me every-"
	cont "where I went."

	para "It's tough being a"
	line "top celebrity."
endc
	done

CelebritysFearowText: 
if DEF(_FR_FR)
	text "RAPASDEPIC: Piiic!"
else
	text "FEAROW: Feero!"
endc

	done

Route28SteelWingHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_28, 1
	warp_event  3,  7, ROUTE_28, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, CelebrityHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, CelebrityHouseBookshelf

	def_object_events
	object_event  2,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Celebrity, -1
	object_event  6,  5, SPRITE_FEAROW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CelebritysFearow, -1
