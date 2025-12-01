	object_const_def
	const SAFFRONCITY_LASS1
	const SAFFRONCITY_POKEFAN_M
	const SAFFRONCITY_COOLTRAINER_M
	const SAFFRONCITY_COOLTRAINER_F
	const SAFFRONCITY_FISHER
	const SAFFRONCITY_YOUNGSTER1
	const SAFFRONCITY_YOUNGSTER2
	const SAFFRONCITY_LASS2

SaffronCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_SAFFRON
	endcallback

SaffronCityLass1Script:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext SaffronCityLass1Text
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext SaffronCityLass1Text_ReturnedMachinePart
	waitbutton
	closetext
	end

SaffronCityPokefanMScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext SaffronCityPokefanMText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext SaffronCityPokefanMText_ReturnedMachinePart
	waitbutton
	closetext
	end

SaffronCityCooltrainerMScript:
	jumptextfaceplayer SaffronCityCooltrainerMText

SaffronCityCooltrainerFScript:
	jumptextfaceplayer SaffronCityCooltrainerFText

SaffronCityFisherScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext SaffronCityFisherText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext SaffronCityFisherText_ReturnedMachinePart
	waitbutton
	closetext
	end

SaffronCityYoungster1Script:
	jumptextfaceplayer SaffronCityYoungster1Text

SaffronCityYoungster2Script:
	jumptextfaceplayer SaffronCityYoungster2Text

SaffronCityLass2Script:
	jumptextfaceplayer SaffronCityLass2Text

SaffronCitySign:
	jumptext SaffronCitySignText

SaffronGymSign:
	jumptext SaffronGymSignText

FightingDojoSign:
	jumptext FightingDojoSignText

SilphCoSign:
if !DEF(_CRYSTAL_BETA) && !DEF(_CRYSTAL_RELEASE)
	clearevent EVENT_CROWD_IN_VACCINATION_CENTER
endc
	jumptext SilphCoSignText

MrPsychicsHouseSign:
	jumptext MrPsychicsHouseSignText

MrAntonsHouseSign:
	jumptext MrAntonsHouseSignText

VaccinationCenterSign:
	jumptext VaccinationCenterSignText

SaffronCityMagnetTrainStationSign:
	jumptext SaffronCityMagnetTrainStationSignText

SaffronCityPokecenterSign:
	jumpstd PokecenterSignScript

SaffronCityMartSign:
	jumpstd MartSignScript

SaffronCityNeonTownSign:
	jumptext NeonTownSignText

SaffronCity_DoorScript:
	jumptext SaffronCity_DojoDoorText

SaffronCityLass1Text: 
if DEF(_FR_FR)
	text "Une fille experte"
	line "en imitation vit"
	cont "ici."

	para "Elle imite même"
	line "les gens avec qui"

	para "elle parle. C'est"
	line "un peu lourd."
else
	text "A little girl who"
	line "is an expert at"

	para "mimicking people"
	line "lives here."

	para "She even mimics"
	line "the people she's"

	para "conversing with."
	line "It's confusing."
endc

	done

SaffronCityLass1Text_ReturnedMachinePart: 
if DEF(_FR_FR)
	text "La COPIEUSE semble"
	line "malheureuse. Elle"

	para "dit avoir perdu sa"
	line "# POUPEE pré-"
	cont "férée: MELOFEE."
else
	text "The COPYCAT girl"
	line "looked unhappy."

	para "She said she lost"
	line "her favorite #"
	cont "DOLL--CLEFAIRY."
endc

	done

SaffronCityPokefanMText: 
if DEF(_FR_FR)
	text "Tu viens de JOHTO?"

	para "Tu peux retourner"
	line "chez toi en une"
	cont "seconde si le"
	cont "TRAIN MAGNET"
	cont "fonctionne."
else
	text "You came out from"
	line "JOHTO?"

	para "You can zip back"
	line "home if the MAGNET"
	cont "TRAIN's running."
endc

	done

SaffronCityPokefanMText_ReturnedMachinePart: 
if DEF(_FR_FR)
	text "Tu viens de JOHTO?"

	para "Tu peux retourner"
	line "chez toi en une"
	cont "seconde avec le"
	cont "TRAIN MAGNET."
else
	text "You came out from"
	line "JOHTO?"

	para "You can zip back"
	line "home by hopping on"
	cont "the MAGNET TRAIN."
endc

	done

SaffronCityCooltrainerMText:
if DEF(_FR_FR)
	text "La quarantaine"
	line "dans une grande"
	cont "ville comme celle-"
	cont "ci, c'est l'enfer."
	
	para "Les gens vivent"
	line "majoritairement"
	cont "dans de petits"
	cont "appartements."
	
	para "Par conséquent,"
	line "beaucoup ont émi-"
	cont "gré de SAFRANIA"
	cont "pour s'installer"
	cont "à la campagne."
	
	para "Avec la montée du"
	line "télétravail, c'est"
	cont "plus simple que"
	cont "jamais."
	
	para "Et grâce au TRAIN"
	line "MAGNET, on peut"
	cont "venir au bureau"
	cont "rapidement."
else
	text "The quarantine in"
	line "a big city like"
	cont "this one was"
	cont "the worst."

	para "People mostly live"
	line "in small flats."
	
	para "As a result, many"
	line "people moved out"
	
	para "from SAFFRON CITY"
	line "to settle in the"
	cont "countryside."

	para "With the rise of"
	line "remote work, it's"
	cont "easier than ever."

	para "It's also quick to"
	line "come to the office"
	cont "thanks to the"
	cont "MAGNET TRAIN."
endc
	done

SaffronCityCooltrainerFText: 
if DEF(_FR_FR)
	text "La SYLPHE SARL est"
	line "célèbre pour ses"
	cont "produits #MON."

	para "C'est pour ça que"
	line "la TEAM ROCKET"

	para "voulait la contrô-"
	line "ler..."
else
	text "This is SILPH CO.,"
	line "famous for #MON"
	cont "merchandise."

	para "In the past, TEAM"
	line "ROCKET wanted the"

	para "company because of"
	line "that."
endc

	done

SaffronCityFisherText: 
if DEF(_FR_FR)
	text "(bouffe)(mâche)"

	para "On dit qu'il y a"
	line "du tintouin à la"
	cont "CENTRALE."

	para "(bouffe)(mâche)"
else
	text "Chew… Chew…"

	para "I hear there's big"
	line "trouble brewing at"
	cont "the POWER PLANT."

	para "Chew… Chew…"
endc

	done

SaffronCityFisherText_ReturnedMachinePart: 
if DEF(_FR_FR)
	text "(bouffe)(mâche)"

	para "On dit qu'il y a-"
	line "vait du tintouin à"
	cont "la CENTRALE."

	para "(bouffe)(mâche)"
	line "J'ai plus faim!"
else
	text "Chew… Chew…"

	para "I hear there was"
	line "big trouble at the"
	cont "POWER PLANT."

	para "Chew… Chew…"
	line "Haaah, I'm full!"
endc

	done

SaffronCityYoungster1Text: 
if DEF(_FR_FR)
	text "Se balader dans"
	line "une ruelle pour la"

	para "première fois fait"
	line "peur, non?"
else
	text "Going into an"
	line "alley for the"

	para "first time makes"
	line "me sorta anxious."
endc

	done

SaffronCityYoungster2Text: 
if DEF(_FR_FR)
	text "On dit que les"
	line "dresseurs se ren-"

	para "contrent au CLUB"
	line "des DRESSEURS à"
	cont "JADIELLE."
else
	text "There's a place"
	line "called TRAINER"

	para "HOUSE in VIRIDIAN"
	line "where trainers"

	para "gather from all"
	line "over the place."
endc

	done

SaffronCityLass2Text: 
if DEF(_FR_FR)
	text "On a parlé de"
	line "notre ville à la"
	cont "radio."

	para "Ca fait plaisir."
	line "C'est pas tous les"
	cont "jours."
else
	text "Our city was"
	line "featured on a"
	cont "radio program."

	para "It's nice to hear"
	line "praise for your"

	para "city, but it's a"
	line "bit embarrassing"
	cont "too."
endc

	done

SaffronCitySignText: 
if DEF(_FR_FR)
	text "SAFRANIA"

	para "Le berceau doré"
	line "du commerce"
else
	text "SAFFRON CITY"

	para "Shining, Golden"
	line "Land of Commerce"
endc

	done

SaffronGymSignText: 
if DEF(_FR_FR)
	text "CHAMPION d'ARENE"
	line "de SAFRANIA:"
	cont "MORGANE"

	para "La maîtresse des"
	line "#MON PSY!"
else
	text "SAFFRON CITY"
	line "#MON GYM"
	cont "LEADER: SABRINA"

	para "The Master of"
	line "Psychic #MON!"
endc

	done

FightingDojoSignText: 
if DEF(_FR_FR)
	text "DOJO"
	line "Bienvenue à tous!"
else
	text "Everyone Welcome!"
	line "FIGHTING DOJO"
endc

	done

SilphCoSignText: 
if DEF(_FR_FR)
	text "BUREAUX de la"
	line "SYLPHE SARL"
else
	text "SILPH CO."
	line "OFFICE BUILDING"
endc

	done

MrPsychicsHouseSignText: 
if DEF(_FR_FR)
	text "MAISON DE"
	line "M.PSY"
else
	text "MR.PSYCHIC'S"
	line "HOUSE"
endc

	done

MrAntonsHouseSignText:
if DEF(_FR_FR)
	text "MAISON DE M.ANTON"
else
	text "MR.ANTON'S"
	line "HOUSE"
endc
	done

SaffronCityMagnetTrainStationSignText: 
if DEF(_FR_FR)
	text "STATION du"
	line "TRAIN MAGNET"
	cont "de SAFRANIA"
else
	text "SAFFRON CITY"
	line "MAGNET TRAIN"
	cont "STATION"
endc

	done

VaccinationCenterSignText:
if DEF(_FR_FR)
	text "CENTRE DE"
	line "VACCINATION de"
	cont "la SYLPHE SARL"
else
	text "SILPH CO."
	line "VACCINATION CENTER"
endc
	done

SaffronCity_DojoDoorText:
if DEF(_FR_FR)
	text "Encore un avis"
	line "sur une porte..."
	
	para "Le DOJO a stoppé"
	line "son activité à"
	cont "cause de la"
	cont "pandémie."
else
	text "Yet another notice"
	line "on the door…"

	para "The FIGHTING DOJO"
	line "has shutdown its"
	cont "activity because"
	cont "of the pandemic."
endc
	done

NeonTownSignText:
if DEF(_FR_FR)
	text "Paradis des nerds"

	para "NEONVILLE"
else
	text "Nerds' Paradise"
	
	para "NEON TOWN"
endc
	done

SaffronCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0, 41, SAFFRON_GYM, 1
	warp_event 34,  3, SAFFRON_GYM, 1
	warp_event 25, 11, SAFFRON_MART, 2
	warp_event  9, 29, SAFFRON_POKECENTER_1F, 1
	warp_event 27, 29, MR_PSYCHICS_HOUSE, 1
	warp_event  8,  3, SAFFRON_MAGNET_TRAIN_STATION, 2
	warp_event 18, 21, SILPH_CO_1F, 1
	warp_event  9, 11, COPYCATS_HOUSE_1F, 1
	warp_event 18,  3, ROUTE_5_SAFFRON_GATE, 3
	warp_event  0, 24, ROUTE_7_SAFFRON_GATE, 3
	warp_event  0, 25, ROUTE_7_SAFFRON_GATE, 4
	warp_event 16, 33, ROUTE_6_SAFFRON_GATE, 1
	warp_event 17, 33, ROUTE_6_SAFFRON_GATE, 2
	warp_event 39, 22, ROUTE_8_SAFFRON_GATE, 1
	warp_event 39, 23, ROUTE_8_SAFFRON_GATE, 2
	warp_event 37,  3, MR_ANTONS_HOUSE, 1
	warp_event 27, 21, VACCINATION_CENTER_1F, 1
	warp_event 31, 21, AKIBA_1F, 1

	def_coord_events

	def_bg_events
	bg_event 21,  5, BGEVENT_READ, SaffronCitySign
	bg_event 33,  5, BGEVENT_READ, SaffronGymSign
	bg_event 25,  5, BGEVENT_READ, FightingDojoSign
	bg_event 15, 21, BGEVENT_READ, SilphCoSign
	bg_event 25, 29, BGEVENT_READ, MrPsychicsHouseSign
	bg_event 11,  5, BGEVENT_READ, SaffronCityMagnetTrainStationSign
	bg_event 10, 29, BGEVENT_READ, SaffronCityPokecenterSign
	bg_event 26, 11, BGEVENT_READ, SaffronCityMartSign
	bg_event 37,  5, BGEVENT_READ, MrAntonsHouseSign
	bg_event 25, 21, BGEVENT_READ, VaccinationCenterSign
	bg_event 26,  3, BGEVENT_READ, SaffronCity_DoorScript
	bg_event 32, 21, BGEVENT_READ, SaffronCityNeonTownSign

	def_object_events
	object_event  7, 14, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SaffronCityLass1Script, -1
	object_event 19, 30, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, SaffronCityPokefanMScript, -1
	object_event 32,  7, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SaffronCityCooltrainerMScript, -1
	object_event 20, 24, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SaffronCityCooltrainerFScript, -1
	object_event 27, 12, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SaffronCityFisherScript, -1
	object_event 15, 19, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SaffronCityYoungster1Script, -1
	object_event 35, 22, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SaffronCityYoungster2Script, -1
	object_event 19,  8, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SaffronCityLass2Script, -1
