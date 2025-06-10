	object_const_def
	const VIRIDIANCITY_GRAMPS1
	const VIRIDIANCITY_GRAMPS2
	const VIRIDIANCITY_FISHER
	const VIRIDIANCITY_YOUNGSTER

ViridianCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_VIRIDIAN
	endcallback

ViridianCityCoffeeGramps:
	faceplayer
	opentext
	writetext ViridianCityCoffeeGrampsQuestionText
	yesorno
	iffalse .no
	writetext ViridianCityCoffeeGrampsBelievedText
	waitbutton
	closetext
	end

.no:
	writetext ViridianCityCoffeeGrampsDoubtedText
	waitbutton
	closetext
	end

ViridianCityGrampsNearGym:
	faceplayer
	opentext
	checkevent EVENT_BLUE_IN_CINNABAR
	iftrue .BlueReturned
	writetext ViridianCityGrampsNearGymText
	waitbutton
	closetext
	end

.BlueReturned:
	writetext ViridianCityGrampsNearGymBlueReturnedText
	waitbutton
	closetext
	end

ViridianCityDreamEaterFisher:
	faceplayer
	opentext
	checkitem TM_DREAM_EATER
	iftrue .GotDreamEater
	writetext ViridianCityDreamEaterFisherText
	promptbutton
	verbosegiveitem TM_DREAM_EATER
	iffalse .NoRoomForDreamEater
.GotDreamEater:
	writetext ViridianCityDreamEaterFisherGotDreamEaterText
	waitbutton
.NoRoomForDreamEater:
	closetext
	end

ViridianCityYoungsterScript:
	jumptextfaceplayer ViridianCityYoungsterText

ViridianCitySign:
	jumptext ViridianCitySignText

ViridianGymSign:
	jumptext ViridianGymSignText

ViridianCityWelcomeSign:
	jumptext ViridianCityWelcomeSignText

TrainerHouseSign:
	jumptext TrainerHouseSignText

ViridianCityPokecenterSign:
	jumpstd PokecenterSignScript

ViridianCityMartSign:
	jumpstd MartSignScript

ViridianCityCoffeeGrampsQuestionText: 
if DEF(_FR_FR)
	text "Hé, toi! Je"
	line "viens de m'enfiler"

	para "un double café et"
	line "j'ai la patate!"

	para "Faut qu'je parle à"
	line "quelqu'un alors..."
	cont "Ecoute-moi!"

	para "J'ai pas l'air"
	line "mais je suis un"

	para "expert en capture"
	line "de #MON."

	para "Tu me crois, hein?"
else
	text "Hey, kid! I just"
	line "had a double shot"

	para "of espresso, and"
	line "I am wired!"

	para "I need to talk to"
	line "someone, so you'll"
	cont "have to do!"

	para "I might not look"
	line "like much now, but"

	para "I was an expert at"
	line "catching #MON."

	para "Do you believe me?"
endc

	done

ViridianCityCoffeeGrampsBelievedText: 
if DEF(_FR_FR)
	text "Tant mieux."
	line "J'étais un crack!"

	para "Un balèze! J'avais"
	line "la classe!"
else
	text "Good, good. Yes, I"
	line "was something out"

	para "of the ordinary,"
	line "let me tell you!"
endc

	done

ViridianCityCoffeeGrampsDoubtedText: 
if DEF(_FR_FR)
	text "Quoi? Sale peste!"

	para "Si j'étais plus"
	line "jeune, j't'en"

	para "ferais baver, moi!"
	line "Oh que oui!"
else
	text "What? You little"
	line "whelp!"

	para "If I were just a"
	line "bit younger, I'd"

	para "show you a thing"
	line "or two. Humph!"
endc

	done

ViridianCityGrampsNearGymText: 
if DEF(_FR_FR)
	text "Cette ARENE vient"
	line "juste d'avoir un"
	cont "CHAMPION officiel."

	para "Un jeune homme de"
	line "PALETTE est devenu"

	para "le CHAMPION mais"
	line "il se balade"
	cont "beaucoup."
else
	text "This GYM didn't"
	line "have a LEADER"
	cont "until recently."

	para "A young man from"
	line "PALLET became the"

	para "LEADER, but he's"
	line "often away."
endc

	done

ViridianCityGrampsNearGymBlueReturnedText: 
if DEF(_FR_FR)
	text "Vas-tu affronter"
	line "le CHAMPION?"

	para "Bonne chance."
	line "T'en auras besoin."
else
	text "Are you going to"
	line "battle the LEADER?"

	para "Good luck to you."
	line "You'll need it."
endc

	done

ViridianCityDreamEaterFisherText: 
if DEF(_FR_FR)
	text "(baille)!"

	para "J'ai dormi sous"
	line "le soleil."

	para "...J'ai rêvé d'un"
	line "SOPORIFIK en train"

	para "de manger mes"
	line "songes. Bizarre!"

	para "Hein?"
	line "C'est quoi?"

	para "D'où vient cette"
	line "CT?"

	para "C'est louche!"
	line "Tiens, je te la"
	cont "donne."
else
	text "Yawn!"

	para "I must have dozed"
	line "off in the sun."

	para "…I had this dream"
	line "about a DROWZEE"

	para "eating my dream."
	line "Weird, huh?"

	para "Huh?"
	line "What's this?"

	para "Where did this TM"
	line "come from?"

	para "This is spooky!"
	line "Here, you can have"
	cont "this TM."
endc

	done

ViridianCityDreamEaterFisherGotDreamEaterText: 
if DEF(_FR_FR)
	text "CT42 contient"
	line "DEVOREVE..."

	para "...Zzzzz..."
else
	text "TM42 contains"
	line "DREAM EATER…"

	para "…Zzzzz…"
endc

	done

ViridianCityYoungsterText: 
if DEF(_FR_FR)
	text "On dit qu'il y a"
	line "plein d'objets sur"

	para "le sol de la FORET"
	line "DE JADE."
else
	text "I heard that there"
	line "are many items on"

	para "the ground in"
	line "VIRIDIAN FOREST."
endc

	done

ViridianCitySignText: 
if DEF(_FR_FR)
	text "JADIELLE"

	para "Le paradis vert"
	line "éternel"
else
	text "VIRIDIAN CITY"

	para "The Eternally"
	line "Green Paradise"
endc

	done

ViridianGymSignText: 
if DEF(_FR_FR)
	text "CHAMPION d'ARENE"
	line "de JADIELLE:"
	cont "..."

	para "Le reste est"
	line "illisible..."
else
	text "VIRIDIAN CITY"
	line "#MON GYM"
	cont "LEADER: …"

	para "The rest of the"
	line "text is illegible…"
endc

	done

ViridianCityWelcomeSignText: 
if DEF(_FR_FR)
	text "Bienvenue à"
	line "JADIELLE, la porte"

	para "vers le PLATEAU"
	line "INDIGO"
else
	text "WELCOME TO"
	line "VIRIDIAN CITY,"

	para "THE GATEWAY TO"
	line "INDIGO PLATEAU"
endc

	done

TrainerHouseSignText: 
if DEF(_FR_FR)
	text "CLUB des DRESSEURS"

	para "Réservé aux"
	line "meilleurs"
else
	text "TRAINER HOUSE"

	para "The Club for Top"
	line "Trainer Battles"
endc

	done

ViridianCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 32,  7, VIRIDIAN_GYM, 1
	warp_event 21,  9, VIRIDIAN_NICKNAME_SPEECH_HOUSE, 1
	warp_event 23, 15, TRAINER_HOUSE_1F, 1
	warp_event 29, 19, VIRIDIAN_MART, 2
	warp_event 23, 25, VIRIDIAN_POKECENTER_1F, 1

	def_coord_events

	def_bg_events
	bg_event 17, 17, BGEVENT_READ, ViridianCitySign
	bg_event 27,  7, BGEVENT_READ, ViridianGymSign
	bg_event 19,  1, BGEVENT_READ, ViridianCityWelcomeSign
	bg_event 21, 15, BGEVENT_READ, TrainerHouseSign
	bg_event 24, 25, BGEVENT_READ, ViridianCityPokecenterSign
	bg_event 30, 19, BGEVENT_READ, ViridianCityMartSign

	def_object_events
	object_event 18,  5, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianCityCoffeeGramps, -1
	object_event 30,  8, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ViridianCityGrampsNearGym, -1
	object_event  6, 23, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ViridianCityDreamEaterFisher, -1
	object_event 17, 21, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ViridianCityYoungsterScript, -1
