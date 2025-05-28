	object_const_def
	const ROUTE35GOLDENRODGATE_RANDY
	const ROUTE35GOLDENRODGATE_POKEFAN_F
	const ROUTE35GOLDENRODGATE_FISHER

Route35GoldenrodGate_MapScripts:
	def_scene_scripts

	def_callbacks

RandyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HP_UP_FROM_RANDY
	iftrue .gothpup
	checkevent EVENT_GAVE_KENYA
	iftrue .questcomplete
	checkevent EVENT_GOT_KENYA
	iftrue .alreadyhavekenya
	writetext Route35GoldenrodGateRandyAskTakeThisMonToMyFriendText
	yesorno
	iffalse .refused
	writetext Route35GoldenrodGateRandyThanksText
	promptbutton
	waitsfx
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .partyfull
	writetext Route35GoldenrodGatePlayerReceivedAMonWithMailText
	playsound SFX_KEY_ITEM
	waitsfx
	givepoke SPEAROW, 10, NO_ITEM, TRUE, GiftSpearowName, GiftSpearowOTName
	setval 0	; See next comment.
	writemem wTempByteValue ; This has been added (along with the prev line) to prevent the OT name written on the mail to be "DAMIAN".
	givepokemail GiftSpearowMail
	setevent EVENT_GOT_KENYA
.alreadyhavekenya
	writetext Route35GoldenrodGateRandyWeirdTreeBlockingRoadText
	waitbutton
	closetext
	end

.partyfull
	writetext Route35GoldenrodGateRandyCantCarryAnotherMonText
	waitbutton
	closetext
	end

.refused
	writetext Route35GoldenrodGateRandyOhNeverMindThenText
	waitbutton
	closetext
	end

.questcomplete
	writetext Route35GoldenrodGateRandySomethingForYourTroubleText
	promptbutton
	verbosegiveitem HP_UP
	iffalse .bagfull
	setevent EVENT_GOT_HP_UP_FROM_RANDY
.gothpup
	writetext Route35GoldenrodGateRandyMyPalWasSnoozingRightText
	waitbutton
.bagfull
	closetext
	end

GiftSpearowMail: 
if DEF(_FR_FR)
	db FLOWER_MAIL
	db   "ANTRE NOIRE    "
	next "mène autre part@"

else
	db FLOWER_MAIL
	db   "DARK CAVE leads"
	next "to another road@"

endc

GiftSpearowName: 
if DEF(_FR_FR)
	db "ALFRED@"

else
	db "KENYA@"

endc

GiftSpearowOTName: 
if DEF(_FR_FR)
	db "BOBBY@"

	db 0 ; unused

else
	db "RANDY@"

	db 0 ; unused

endc

Route35GoldenrodGatePokefanFScript:
	faceplayer
	opentext
	checkevent EVENT_ROUTE_36_SUDOWOODO
	iftrue .FoughtSudowoodo
	writetext Route35GoldenrodGatePokefanFText
	waitbutton
	closetext
	end

.FoughtSudowoodo
	writetext Route35GoldenrodGatePokefanFText_FoughtSudowoodo
	waitbutton
	closetext
	end

Route35GoldenrodGateFisherScript:
	jumptextfaceplayer Route35GoldenrodGateFisherText

Route35GoldenrodGateRandyAskTakeThisMonToMyFriendText: 
if DEF(_FR_FR)
	text "Minute papillon!"
	line "Tu peux me rendre"
	cont "service?"

	para "Tu peux apporter"
	line "ce #MON et sa"
	cont "LETTRE à mon pote?"

	para "Il est sur la"
	line "ROUTE 31."
else
	text "Excuse me, kid!"
	line "Can you do a guy"
	cont "a favor?"

	para "Can you take this"
	line "#MON with MAIL"
	cont "to my friend?"

	para "He's on ROUTE 31."
endc

	done

Route35GoldenrodGateRandyThanksText: 
if DEF(_FR_FR)
	text "Tu veux bien?"
	line "Merci!"

	para "Mon pote est gras"
	line "et il pionce tout"
	cont "le temps."

	para "Tu vas le recon-"
	line "naître, c'est sûr!"
else
	text "You will? Perfect!"
	line "Thanks, kid!"

	para "My pal's a chubby"
	line "guy who snoozes"
	cont "all the time."

	para "You'll recognize"
	line "him right away!"
endc

	done

Route35GoldenrodGatePlayerReceivedAMonWithMailText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "un #MON avec"
	cont "une LETTRE."
else
	text "<PLAYER> received a"
	line "#MON with MAIL."
endc

	done

Route35GoldenrodGateRandyWeirdTreeBlockingRoadText: 
if DEF(_FR_FR)
	text "Tu peux la lire"
	line "mais ne la perds"
	cont "pas, OK? Et sou-"
	cont "viens-toi: la"
	cont "ROUTE 31!"

	para "Au fait, il y a un"
	line "arbre bizarre qui"
	cont "bloque le chemin."

	para "Il est parti, tu"
	line "crois?"
else
	text "You can read it,"
	line "but don't lose it!"
	cont "ROUTE 31!"

	para "Oh, yeah. There"
	line "was a weird tree"
	cont "blocking the road."

	para "I wonder if it's"
	line "been cleared?"
endc

	done

Route35GoldenrodGateRandyCantCarryAnotherMonText: 
if DEF(_FR_FR)
	text "Tu ne peux plus"
	line "porter de #MON!"
else
	text "You can't carry"
	line "another #MON…"
endc

	done

Route35GoldenrodGateRandyOhNeverMindThenText: 
if DEF(_FR_FR)
	text "Bon. Laisse tomber"
	line "alors..."
else
	text "Oh… Never mind,"
	line "then…"
endc

	done

Route35GoldenrodGateRandySomethingForYourTroubleText: 
if DEF(_FR_FR)
	text "Merci bien! Tu"
	line "as bien fait la"
	cont "livraison!"

	para "Voilà pour toi!"
else
	text "Thanks, kid! You"
	line "made the delivery"
	cont "for me!"

	para "Here's something"
	line "for your trouble!"
endc

	done

Route35GoldenrodGateRandyMyPalWasSnoozingRightText: 
if DEF(_FR_FR)
	text "Mon pote pionce"
	line "comme un fou, non?"
	cont "Quelle classe!"
else
	text "My pal was snooz-"
	line "ing, right? Heh,"
	cont "what'd I say?"
endc

	done

Route35GoldenrodGatePokefanFText: 
if DEF(_FR_FR)
	text "Un arbre bizarre"
	line "bloque le chemin."

	para "Il gigote si on"
	line "s'en approche."

	para "Il paraît qu'il"
	line "devient dingue si"

	para "on l'asperge avec"
	line "une CARAPUCE A O."
else
	text "A strange tree is"
	line "blocking the road."

	para "It wriggles around"
	line "if you talk to it."

	para "I heard it became"
	line "wild when someone"

	para "watered it with a"
	line "SQUIRTBOTTLE."
endc

	done

Route35GoldenrodGatePokefanFText_FoughtSudowoodo: 
if DEF(_FR_FR)
	text "J'aime la berceuse"
	line "#MON qui passe"
	cont "à la radio."
else
	text "I like the #MON"
	line "Lullaby they play"
	cont "on the radio."
endc

	done

Route35GoldenrodGateFisherText: 
if DEF(_FR_FR)
	text "Je me demande"
	line "combien de types"

	para "de #MON il y a"
	line "dans le monde."

	para "Il y a trois ans,"
	line "le PROF.CHEN"

	para "disait qu'il y"
	line "avait 150 types"
	cont "différents."
else
	text "I wonder how many"
	line "kinds of #MON"

	para "there are in the"
	line "world."

	para "Three years ago,"
	line "PROF.OAK said that"

	para "there were 150"
	line "different kinds."
endc

	done

Route35GoldenrodGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  0, ROUTE_35, 1
	warp_event  5,  0, ROUTE_35, 2
	warp_event  4,  7, GOLDENROD_CITY, 12
	warp_event  5,  7, GOLDENROD_CITY, 12

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RandyScript, -1
	object_event  6,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route35GoldenrodGatePokefanFScript, -1
	object_event  3,  2, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route35GoldenrodGateFisherScript, -1
