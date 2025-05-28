	object_const_def
	const OAKSLAB_OAK
	const OAKSLAB_SCIENTIST1
	const OAKSLAB_SCIENTIST2
	const OAKSLAB_SCIENTIST3

OaksLab_MapScripts:
	def_scene_scripts

	def_callbacks

.DummyScene: ; unreferenced
	end

Oak:
	faceplayer
	opentext
	checkevent EVENT_REDS_PIKACHU_AVAILABLE
	iffalse .GetPikachu
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .CheckPokedex
	checkevent EVENT_TALKED_TO_OAK_IN_KANTO
	iftrue .CheckBadges
	writetext OakWelcomeKantoText
	promptbutton
	setevent EVENT_TALKED_TO_OAK_IN_KANTO
.CheckBadges:
	readvar VAR_BADGES
	ifequal NUM_BADGES, .OpenMtSilver
	ifequal NUM_JOHTO_BADGES, .Complain
	sjump .AhGood

.CheckPokedex:
	writetext OakLabDexCheckText
	waitbutton
	special ProfOaksPCBoot
	writetext OakLabGoodbyeText
	waitbutton
	closetext
	end

.GetPikachu:
	writetext OakLabPikachuText
	waitbutton
	closetext
	end

.OpenMtSilver:
	writetext OakOpenMtSilverText
	promptbutton
	setevent EVENT_OPENED_MT_SILVER
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU ; We allow the player to fly to the Indigo Plateau once again.
	;setevent EVENT_RED_BEATEN
	;clearevent EVENT_RED_IN_MT_SILVER ; Now Red will be available only once for battle.
	sjump .CheckPokedex

.Complain:
	writetext OakNoKantoBadgesText
	promptbutton
	sjump .CheckPokedex

.AhGood:
	writetext OakYesKantoBadgesText
	promptbutton
	sjump .CheckPokedex

OaksAssistant1Script:
	jumptextfaceplayer OaksAssistant1Text

OaksAssistant2Script:
	jumptextfaceplayer OaksAssistant2Text

OaksAssistant3Script:
	jumptextfaceplayer OaksAssistant3Text

OaksLabBookshelf:
	jumpstd DifficultBookshelfScript

OaksLabPoster1:
	jumptext OaksLabPoster1Text

OaksLabPoster2:
	jumptext OaksLabPoster2Text

OaksLabTrashcan:
	jumptext OaksLabTrashcanText

OaksLabPC:
	jumptext OaksLabPCText

OakWelcomeKantoText: 
if DEF(_FR_FR)
	text "CHEN: Ah, <PLAY_G>!"
	line "Merci d'avoir vo-"

	para "yagé jusqu'à"
	line "KANTO."

	para "Que penses-tu des"
	line "dresseurs du coin?"
	cont "Plutôt forts, non?"
else
	text "OAK: Ah, <PLAY_G>!"
	line "It's good of you"

	para "to come all this"
	line "way to KANTO."

	para "What do you think"
	line "of the trainers"

	para "out here?"
	line "Pretty tough, huh?"
endc

	done

OakLabDexCheckText: 
if DEF(_FR_FR)
	text "Et ton #DEX?"
	line "Ca avance?"

	para "Voyons ça..."
else
	text "How is your #-"
	line "DEX coming?"

	para "Let's see…"
endc

	done

OakLabGoodbyeText: 
if DEF(_FR_FR)
	text "N'hésite pas à"
	line "passer si tu es"
	cont "dans la région."
else
	text "If you're in the"
	line "area, I hope you"
	cont "come visit again."
endc

	done

OakOpenMtSilverText: 
if DEF(_FR_FR)
	text "CHEN: Woah!"
	line "C'est génial, ça!"

	para "Tu as gagné les"
	line "BADGES de KANTO!"
	cont "Bravo!"

	para "J'ai bien fait de"
	line "te faire confian-"
	cont "ce."

	para "Dans ce cas,"
	line "<PLAY_G>, je vais"

	para "faire en sorte que"
	line "tu puisses aller"
	cont "au MONT ARGENT."

	para "Le MONT ARGENT est"
	line "une montagne où"

	para "vivent beaucoup de"
	line "#MON sauvages."

	para "Cet endroit est"
	line "trop dangereux"

	para "pour le dresseur"
	line "lambda, mais nous"

	para "pouvons faire une"
	line "exception pour"
	cont "toi, <PLAY_G>."

	para "Va au PLATEAU"
	line "INDIGO. Tu pourras"

	para "accéder ensuite au"
	line "MONT ARGENT."
else
	text "OAK: Wow! That's"
	line "excellent!"

	para "You collected the"
	line "BADGES of GYMS in"
	cont "KANTO. Well done!"

	para "I was right in my"
	line "assessment of you."

	para "Tell you what,"
	line "<PLAY_G>. I'll make"

	para "arrangements so"
	line "that you can go to"
	cont "MT.SILVER."

	para "MT.SILVER is a big"
	line "mountain that is"

	para "home to many wild"
	line "#MON."

	para "It's too dangerous"
	line "for your average"

	para "trainer, so it's"
	line "off limits. But"

	para "we can make an"
	line "exception in your"
	cont "case, <PLAY_G>."

	para "Go up to INDIGO"
	line "PLATEAU. You can"

	para "reach MT.SILVER"
	line "from there."
endc

	done

OakNoKantoBadgesText: 
if DEF(_FR_FR)
	text "CHEN: Hmm? Tu ne"
	line "collectionnes pas"
	cont "les BADGES des"
	cont "ARENES de KANTO?"

	para "Les CHAMPIONS"
	line "d'ARENE de KANTO"

	para "sont aussi forts"
	line "que ceux de JOHTO."

	para "Je te conseille de"
	line "les affronter."
else
	text "OAK: Hmm? You're"
	line "not collecting"
	cont "KANTO GYM BADGES?"

	para "The GYM LEADERS in"
	line "KANTO are as tough"

	para "as any you battled"
	line "in JOHTO."

	para "I recommend that"
	line "you challenge"
	cont "them."
endc

	done

OakYesKantoBadgesText: 
if DEF(_FR_FR)
	text "CHEN: Tu"
	line "collectionnes les"
	cont "BADGES de KANTO."

	para "Cela doit être"
	line "difficile, mais tu"

	para "as beaucoup"
	line "d'expérience à"
	cont "présent."

	para "Viens me voir si"
	line "tu les as tous."

	para "J'aurai un cadeau"
	line "pour toi."

	para "Bonne chance,"
	line "<PLAY_G>!"
else
	text "OAK: Ah, you're"
	line "collecting KANTO"
	cont "GYM BADGES."

	para "I imagine that"
	line "it's hard, but the"

	para "experience is sure"
	line "to help you."

	para "Come see me when"
	line "you get them all."

	para "I'll have a gift"
	line "for you."

	para "Keep trying hard,"
	line "<PLAY_G>!"
endc

	done

OakLabPikachuText: ; TO TRANSLATE
	text "OAK: Oh hi"
	line "<PLAYER>!"
	
	para "I've heard about"
	line "RED on TV. I'm so"
	cont "sad about what"
	cont "happened to him…"

	para "…"
	
	para "I've seen his mom"
	line "recently."
	
	para "I don't know if"
	line "she has heard the"
	cont "news, but she"
	cont "seemed worried."
	
	para "I don't have the"
	line "heart to go talk"
	cont "to her."

	para "Perhaps you could"
	line "do it for me."
	done

OaksAssistant1Text: 
if DEF(_FR_FR)
	text "La CHRONIQUE PKMN"
	line "du PROF à la radio"

	para "ne passe pas ici,"
	line "à KANTO."

	para "C'est bête..."
	line "Je l'aime tant."
else
	text "The PROF's #MON"
	line "TALK radio program"

	para "isn't aired here"
	line "in KANTO."

	para "It's a shame--I'd"
	line "like to hear it."
endc

	done

OaksAssistant2Text: 
if DEF(_FR_FR)
	text "Grâce à ton tra-"
	line "vail sur le #-"
	cont "DEX, les recher-"

	para "ches du PROF ont"
	line "bien progressé."
else
	text "Thanks to your"
	line "work on the #-"
	cont "DEX, the PROF's"

	para "research is coming"
	line "along great."
endc

	done

OaksAssistant3Text: 
if DEF(_FR_FR)
	text "Ne le répète pas,"
	line "mais la CHRONIQUE"

	para "#MON du PROF."
	line "CHEN n'est pas en"
	cont "direct."
else
	text "Don't tell anyone,"
	line "but PROF.OAK'S"

	para "#MON TALK isn't"
	line "a live broadcast."
endc

	done

OaksLabPoster1Text: 
if DEF(_FR_FR)
	text "Appuyer sur START"
	line "pour le MENU."
else
	text "Press START to"
	line "open the MENU."
endc

	done

OaksLabPoster2Text: 
if DEF(_FR_FR)
	text "L'option SAUVER"
	line "est sur le MENU."

	para "Utilise-la assez"
	line "souvent."
else
	text "The SAVE option is"
	line "on the MENU."

	para "Use it in a timely"
	line "manner."
endc

	done

OaksLabTrashcanText: 
if DEF(_FR_FR)
	text "Il n'y a rien ici."
else
	text "There's nothing in"
	line "here…"
endc

	done

OaksLabPCText: 
if DEF(_FR_FR)
	text "Il y a un e-mail"
	line "sur le PC."

	para "…"

	para "PROF.CHEN, comment"
	line "ça va bien?"
	cont "Ca bosse dur?"

	para "Moi je bosse comme"
	line "un barbare."

	para "On raconte que"
	line "<PLAY_G> est une"
	cont "vraie terreur..."

	para "Et dire que c'est"
	line "grâce à nous."

	para "ORME du BOURG GEON"
	line "8-)"
else
	text "There's an e-mail"
	line "message on the PC."

	para "…"

	para "PROF.OAK, how is"
	line "your research"
	cont "coming along?"

	para "I'm still plugging"
	line "away."

	para "I heard rumors"
	line "that <PLAY_G> is"

	para "getting quite a"
	line "reputation."

	para "I'm delighted to"
	line "hear that."

	para "ELM in NEW BARK"
	line "TOWN 8-)"
endc

	done

OaksLab_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 11, PALLET_TOWN, 3
	warp_event  5, 11, PALLET_TOWN, 3

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  7,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  8,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  9,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  0,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  1,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  2,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  3,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  6,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  7,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  8,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  9,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  4,  0, BGEVENT_READ, OaksLabPoster1
	bg_event  5,  0, BGEVENT_READ, OaksLabPoster2
	bg_event  9,  3, BGEVENT_READ, OaksLabTrashcan
	bg_event  0,  1, BGEVENT_READ, OaksLabPC

	def_object_events
	object_event  4,  2, SPRITE_OAK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Oak, -1
	object_event  1,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant1Script, -1
	object_event  8,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant2Script, -1
	object_event  1,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant3Script, -1
