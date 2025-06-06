	object_const_def
	const CELADONCAFE_SUPER_NERD
	const CELADONCAFE_VP_CONTROLLER
	const CELADONCAFE_FISHER2
	const CELADONCAFE_FISHER3
	const CELADONCAFE_YOUAK
	const CELADONCAFE_TEACHER

CeladonCafe_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

CeladonCafeChef:
	faceplayer
	opentext
	writetext ChefText_Eatathon
	waitbutton
	closetext
	end

CeladonCafeFisher3:
	opentext
	writetext Fisher1Text_Snarfle
	waitbutton
	closetext
	faceplayer
	opentext
	writetext Fisher1Text_Concentration
	waitbutton
	closetext
	turnobject CELADONCAFE_FISHER3, RIGHT
	end

CeladonCafeYouakScript:
	opentext
	writetext Fisher2Text_GulpChew
	waitbutton
	closetext
	faceplayer

	checkevent EVENT_BEAT_YOUAK
	iftrue .afterbattletext

	opentext
	writetext Fisher2Text_Eating
	waitbutton
	closetext

	winlosstext Fisher2Text_Loss, 0
	loadtrainer BLACKBELT_T, YOUAK
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_YOUAK
	pause 3
	turnobject CELADONCAFE_YOUAK, RIGHT
	end

.afterbattletext
	opentext
	writetext Fisher2Text_Quantity
	waitbutton
	closetext
	turnobject CELADONCAFE_YOUAK, RIGHT
	end

CeladonCafeFisher2:
	opentext
	writetext Fisher3Text_MunchMunch
	waitbutton
	closetext
	faceplayer
	opentext
	writetext Fisher3Text_GoldenrodIsBest
	waitbutton
	closetext
	turnobject CELADONCAFE_FISHER2, LEFT
	end

CeladonCafeTeacher:
	checkitem COIN_CASE
	iftrue .HasCoinCase
	opentext
	writetext TeacherText_CrunchCrunch
	waitbutton
	closetext
	faceplayer
	opentext
	writetext TeacherText_NoCoinCase
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, LEFT
	end

.HasCoinCase:
	opentext
	writetext TeacherText_KeepEating
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, RIGHT
	opentext
	writetext TeacherText_MoreChef
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, LEFT
	end

EatathonContestPoster:
	jumptext EatathonContestPosterText

CeladonCafeTrashcan:
	jumptext FoundLeftoversText

ChefText_Eatathon: ; TO TRANSLATE
	text "Hi!"

	para "We're full at the"
	line "moment, please"
	cont "wait outside."

	done

Fisher1Text_Snarfle: 
if DEF(_FR_FR)
	text "...(tousse)..."
	line "...(crache)..."
else
	text "…Snarfle, chew…"
endc

	done

Fisher1Text_Concentration: ; TO TRANSLATE
	text "I can't cook so"
	line "I've been eating"
	cont "frozen meals dur-"
	cont "ing the several"
	cont "months of the"
	cont "lockdown."
	
	para "I've been missing"
	line "restaurants so"
	cont "much!"

	done

Fisher2Text_GulpChew: 
if DEF(_FR_FR)
	text "...(tousse)..."
	line "...(mâche)..."
else
	text "…Gulp… Chew…"
endc

	done

Fisher2Text_Eating: ; TO TRANSLATE
	text "CAN'T YOU SEE"
	line "I'M BUSY EATING?"
	done

Fisher2Text_Loss: ; TO TRANSLATE
	text "I'll get one more"
	line "dessert please."
	done

Fisher2Text_Quantity: ; TO TRANSLATE
	text "Don't talk to me,"
	line "I'm not wearing"
	cont "my face mask!"
	done

Fisher3Text_MunchMunch: 
if DEF(_FR_FR)
	text "Miam...(bouffe)..."
else
	text "Munch, munch…"
endc

	done

Fisher3Text_GoldenrodIsBest: ; TO TRANSLATE
	text "I forgot that I"
	line "lost the sense of"
	cont "taste and smell…"

	para "This is so"
	line "frustrating!"

	para "Eating was every-"
	line "thing to me…"
	done

TeacherText_CrunchCrunch: 
if DEF(_FR_FR)
	text "(mâche), (croque)."
else
	text "Crunch… Crunch…"
endc

	done

TeacherText_NoCoinCase: 
if DEF(_FR_FR)
	text "Personne ne te"
	line "donnera de BOITE"

	para "JETON, ici. Va"
	line "voir à JOHTO."
else
	text "Nobody here will"
	line "give you a COIN"

	para "CASE. You should"
	line "look in JOHTO."
endc

	done

TeacherText_KeepEating: 
if DEF(_FR_FR)
	text "Ouuaiiiiis!"

	para "Manger c'est bon!"
else
	text "Crunch… Crunch…"

	para "I can keep eating!"
endc

	done

TeacherText_MoreChef: 
if DEF(_FR_FR)
	text "Et la sauce?"
else
	text "More, CHEF!"
endc

	done

EatathonContestPosterText: ; TO TRANSLATE
	text "SANITARY RULES:"

	para "- Line up outside"
	line "and wait for your"
	cont "vaccination pass"
	cont "to be checked."

	para "- Wear your face"
	line "mask at all times"
	cont "unless you are"
	cont "seated."

	para "- Wash your hands"
	line "when entering."

	para "- Tables have been"
	line "spaced out. Do"
	cont "not move them."

	para "- We are allowed"
	line "a fourth of our"
	cont "maximum capacity."
	cont "Sorry for the"
	cont "inconvenience."

	para "- Leave one seat"
	line "free between you"
	cont "and the next"
	cont "person, and don't"
	cont "seat in front of"
	cont "someone else."
	
	para "- No paper menu:"
	line "scan the code with" 
	cont "your #GEAR to"
	cont "access the digital"
	cont "menu."

	para "- After using the"
	line "toilets, clean"
	cont "everything with"
	cont "the provided"
	cont "cleaning wipes."

	para "- Cash payment"
	line "prohibited. Only"
	cont "contactless pay-"
	cont "ments accepted."

	done

FoundLeftoversText: ; TO TRANSLATE
	text "<PLAYER> found"
	line "NOTHING!"

	para "This trashcan is"
	line "super duper clean."

	para "This restaurant"
	line "looks to be very"
	cont "serious about the"
	cont "sanitary protocol."
	done

CeladonCafe_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  7, CELADON_CITY, 9
	warp_event  7,  7, CELADON_CITY, 9

	def_coord_events

	def_bg_events
	bg_event  5,  0, BGEVENT_READ, EatathonContestPoster
	bg_event  7,  1, BGEVENT_READ, CeladonCafeTrashcan

	def_object_events
	object_event  9,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CeladonCafeChef, -1
	object_event  8,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  4,  6, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCafeFisher2, -1
	object_event  1,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCafeFisher3, -1
	object_event  1,  2, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonCafeYouakScript, -1
	object_event  4,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCafeTeacher, -1
