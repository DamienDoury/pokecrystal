	object_const_def
	const BLUESHOUSE_DAISY

BluesHouse_MapScripts:
	def_scene_scripts

	def_callbacks

DaisyScript:
	faceplayer
	opentext
	readvar VAR_HOUR
	ifequal 15, .ThreePM
	writetext DaisyHelloText
	waitbutton
	closetext
	end

.ThreePM:
	checkflag ENGINE_DAISYS_GROOMING
	iftrue .AlreadyGroomedMon
	writetext DaisyOfferGroomingText
	yesorno
	iffalse .Refused
	writetext DaisyWhichMonText
	waitbutton
	special DaisysGrooming
	ifequal $0, .Refused
	ifequal $1, .CantGroomEgg
	setflag ENGINE_DAISYS_GROOMING
	writetext DaisyAlrightText
	waitbutton
	closetext
	special FadeOutPalettes
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes
	special RestartMapMusic
	opentext
	writetext GroomedMonLooksContentText
	special PlayCurMonCry
	promptbutton
	writetext DaisyAllDoneText
	waitbutton
	closetext
	end

.AlreadyGroomedMon:
	writetext DaisyAlreadyGroomedText
	waitbutton
	closetext
	end

.Refused:
	writetext DaisyRefusedText
	waitbutton
	closetext
	end

.CantGroomEgg:
	writetext DaisyCantGroomEggText
	waitbutton
	closetext
	end

DaisyHelloText: 
if DEF(_FR_FR)
	text "NINA: Salut! Mon"
	line "petit frère est le"

	para "CHAMPION de l'ARE-"
	line "NE de JADIELLE."

	para "Mais il se balade"
	line "beaucoup, ce qui"

	para "embête pas mal de"
	line "dresseurs."
else
	text "DAISY: Hi! My kid"
	line "brother is the GYM"

	para "LEADER in VIRIDIAN"
	line "CITY."

	para "But he goes out"
	line "of town so often,"

	para "it causes problems"
	line "for the trainers."
endc

	done

DaisyOfferGroomingText: 
if DEF(_FR_FR)
	text "NINA: Salut! Ca"
	line "tombe bien, j'al-"
	cont "lais faire du thé."

	para "En veux-tu?"

	para "Oh, tes #MON"
	line "sont sales."

	para "Tu veux que j'en"
	line "bichonne un?"
else
	text "DAISY: Hi! Good"
	line "timing. I'm about"
	cont "to have some tea."

	para "Would you like to"
	line "join me?"

	para "Oh, your #MON"
	line "are a bit dirty."

	para "Would you like me"
	line "to groom one?"
endc

	done

DaisyWhichMonText: 
if DEF(_FR_FR)
	text "NINA: Lequel dois-"
	line "je bichonner?"
else
	text "DAISY: Which one"
	line "should I groom?"
endc

	done

DaisyAlrightText: 
if DEF(_FR_FR)
	text "NINA: OK, je vais"
	line "le faire beau en"
	cont "deux secondes."
else
	text "DAISY: OK, I'll"
	line "get it looking"
	cont "nice in no time."
endc

	done

GroomedMonLooksContentText: 
if DEF(_FR_FR)
	text_ram wStringBuffer3
	text " a l'air"
	line "heureux."
else
	text_ram wStringBuffer3
	text " looks"
	line "content."
endc

	done

DaisyAllDoneText: 
if DEF(_FR_FR)
	text "NINA: Voilààà!"
	line "C'est fini!"

	para "Alors? Il est pas"
	line "trop beau, hein?"

	para "Un joli petit"
	line "#MON."
else
	text "DAISY: There you"
	line "go! All done."

	para "See? Doesn't it"
	line "look nice?"

	para "It's such a cute"
	line "#MON."
endc

	done

DaisyAlreadyGroomedText: 
if DEF(_FR_FR)
	text "NINA: Je me fais"
	line "du thé toujours à"

	para "cette heure. Tu"
	line "peux rester."
else
	text "DAISY: I always"
	line "have tea around"

	para "this time. Come"
	line "join me."
endc

	done

DaisyRefusedText: 
if DEF(_FR_FR)
	text "NINA: Tu ne veux"
	line "pas que je m'en"

	para "occupe? OK. Un peu"
	line "de thé, alors..."
else
	text "DAISY: You don't"
	line "want to have one"

	para "groomed? OK, we'll"
	line "just have tea."
endc

	done

DaisyCantGroomEggText: 
if DEF(_FR_FR)
	text "NINA: Oh, désolée."
	line "Je ne peux pas"
	cont "m'occuper d'un"
	cont "OEUF."
else
	text "DAISY: Oh, sorry."
	line "I honestly can't"
	cont "groom an EGG."
endc

	done

BluesHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, PALLET_TOWN, 2
	warp_event  3,  7, PALLET_TOWN, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_DAISY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DaisyScript, -1
