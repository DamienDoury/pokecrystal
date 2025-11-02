	object_const_def
	const MAHOGANYREDGYARADOSSPEECHHOUSE_BLACK_BELT
	const MAHOGANYREDGYARADOSSPEECHHOUSE_TEACHER

MahoganyRedGyaradosSpeechHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject MAHOGANYREDGYARADOSSPEECHHOUSE_BLACK_BELT, 0, 3
	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT
.end
	endcallback

MahoganyRedGyaradosSpeechHouseBlackBeltScript:
	jumptextfaceplayer MahoganyRedGyaradosSpeechHouseBlackBeltText

MahoganyRedGyaradosSpeechHouseTeacherScript:
	faceplayer
	opentext

	checkevent EVENT_SCALPER_MET
	iftrue .already_met

	writetext MahoganyRedGyaradosSpeechHouseTeacherText
	promptbutton
	setevent EVENT_SCALPER_MET
	sjump .give

.already_met
	checkflag ENGINE_SCALPER
	iffalse .giveaway_available

	writetext MahoganyRedGyaradosSpeechHouse_ScalperNotTodayText
	waitbutton
	closetext
	end

.giveaway_available
	checkevent EVENT_RED_BEATEN
	iftrue .red_not_beaten

	checkevent EVENT_SCALPER_GAVE_GPU
	iftrue .red_not_beaten ; The GPU can be obtained only once.

	writetext MahoganyRedGyaradosSpeechHouse_ScalperFanText
	promptbutton

	verbosegiveitem TOILET_PAPER, 24
	iffalse .full

	writetext MahoganyRedGyaradosSpeechHouse_ScalperPackText
	waitbutton

	closetext

	setevent EVENT_SCALPER_GAVE_GPU
	setflag ENGINE_SCALPER
	end

.red_not_beaten
	writetext MahoganyRedGyaradosSpeechHouse_ScalperGiveText
	promptbutton

.give
	verbosegiveitem GREAT_BALL
	iffalse .full

	closetext

	setflag ENGINE_SCALPER
	end

.full
	writetext MahoganyRedGyaradosSpeechHouse_ScalperFullText
	waitbutton
	closetext
	end

MahoganyRedGyaradosSpeechHouse_Radio:
	jumpstd Radio3Script

MahoganyRedGyaradosSpeechHouseBlackBeltText: 
if DEF(_FR_FR)
	text "J'ai entendu dire"
	line "qu'un LEVIATOR"
	cont "rouge est apparu"
	cont "au LAC."

	para "C'est bizarre..."
	line "Même un LEVIATOR"

	para "ordinaire est très"
	line "rare dans ce LAC!"
else
	text "I heard that a red"
	line "GYARADOS appeared"
	cont "at the LAKE."

	para "That's odd, since"
	line "even ordinary"

	para "GYARADOS are rare"
	line "in that lake…"
endc

	done

MahoganyRedGyaradosSpeechHouseTeacherText:
if DEF(_FR_FR)
	text "Quand le COVID-19"
	line "a été annoncé,"

	para "je me suis ruée au"
	line "magasin avant tout"
	cont "le monde et j'ai"

	para "acheté tout ce"
	line "que je pouvais."

	para "L'idée c'était de"
	line "revendre avec du"
	cont "bénéfice."

	para "Et au final..."

	para "...j'ai gagné pas"
	line "mal d'argent, je"
	cont "te le cache pas!"

	para "Mais je me sens"
	line "coupable."

	para "Je me vois comme"
	line "une ninja, mais"

	para "les jeunes m'appe-"
	line "lent la scalpeuse."

	para "Alors j'ai décidé"
	line "d'offrir le reste"
	cont "de mon stock."

	para "Tiens, voici un"
	line "petit quelque"
	cont "chose pour toi."
else
	text "When COVID-19 was"
	line "first announced,"

	para "I rushed the MART"
	line "before everyone"
	cont "else and I bought"

	para "everything I could"
	line "find."

	para "I thought I would"
	line "be able to resell"
	cont "at a profit."

	para "In the end…"

	para "…I made a lot of"
	line "money, not gonna"
	cont "lie!"

	para "But now I feel"
	line "bad about it."

	para "I called myself"
	line "a ninja, but"

	para "young people call"
	line "me a scalper."

	para "So I decided to"
	line "give away the"
	cont "rest of my stock."

	para "Here's a little"
	line "something for you."
endc
	done

MahoganyRedGyaradosSpeechHouse_ScalperGiveText:
if DEF(_FR_FR)
	text "SCALPEUSE: Tiens,"
	line "voici un petit"
	cont "quelque chose."
else
	text "SCALPER: Here's a"
	line "little something."
endc
	done

MahoganyRedGyaradosSpeechHouse_ScalperNotTodayText:
if DEF(_FR_FR)
	text "SCALPEUSE: Hé! Je"
	line "vais pas tout te"
	cont "donner d'un coup!"

	para "Tu en auras"
	line "davantage un autre"
	cont "jour, peut-être."
else
	text "SCALPER: Hey! I'm"
	line "not gonna give you"
	cont "everything I got!"

	para "You'll get more"
	line "another day,"
	cont "maybe."
endc
	done

MahoganyRedGyaradosSpeechHouse_ScalperFanText:
if DEF(_FR_FR)
	text "SCALPEUSE: Hé!"
	line "Je te reconnais!"

	para "T'es le MAÎTRE"
	line "POKéMON!!"

	para "Tu peux avoir un"
	line "objet de mon"
	cont "stock secret."
else
	text "SCALPER: Hey!"
	line "I know you!"

	para "You're the #MON"
	line "MASTER!!"

	para "You can have an"
	line "item from my"
	cont "secret stock."
endc
	done

MahoganyRedGyaradosSpeechHouse_ScalperPackText:
if DEF(_FR_FR)
	text "SCALPEUSE: Un lot"
	line "de 24, flambant"
	cont "neuf, rien que"
	cont "pour toi!"

	para "C'est super rare,"
	line "ça vaut de l'or."
else
	text "SCALPER: A"
	line "pristine 24-pack"
	cont "for you my friend!"

	para "Super rare,"
	line "worth gold."
endc
	done

MahoganyRedGyaradosSpeechHouse_ScalperFullText:
if DEF(_FR_FR)
	text "Je vois que mon"
	line "sac n'est pas le"
	cont "seul à être plein!"

	para "Serais-tu un"
	line "scalper toi aussi?"
else
	text "I see my bag is"
	line "not the only one"
	cont "that is full!"

	para "Are you a"
	line "scalper like me?"
endc
	done

MahoganyRedGyaradosSpeechHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, MAHOGANY_TOWN, 2
	warp_event  4,  7, MAHOGANY_TOWN, 2

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, MahoganyRedGyaradosSpeechHouse_Radio

	def_object_events
	object_event  2,  3, SPRITE_BLACK_BELT, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MahoganyRedGyaradosSpeechHouseBlackBeltScript, -1
	object_event  6,  4, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MahoganyRedGyaradosSpeechHouseTeacherScript, -1
