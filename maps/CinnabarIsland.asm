	object_const_def
	const CINNABARISLAND_BLUE
	const CINNABARISLAND_LOVER_F
	const CINNABARISLAND_LOVER_M
	const CINNABARISLAND_ROOF_KID
	const CINNABARISLAND_SWIMMER_LOVER_F
	const CINNABARISLAND_SWIMMER_LOVER_M
	const CINNABARISLAND_SYNC_DANCER_LEFT
	const CINNABARISLAND_SYNC_DANCER_RIGHT
	;const CINNABARISLAND_DRUNK
	const CINNABARISLAND_VOLCANO_SWIMMER
	const CINNABARISLAND_TEACHER
	const CINNABARISLAND_KID
	const CINNABARISLAND_SHY

CinnabarIsland_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_OBJECTS, .RaveParty

.FlyPoint:
	checkflag ENGINE_FLYPOINT_CINNABAR
	iftrue .endcallback

	setflag ENGINE_FLYPOINT_CINNABAR
	readmem wKantoAddLevel
	addval 1
	writemem wKantoAddLevel
	endcallback

.RaveParty:
	disappear CINNABARISLAND_LOVER_F
	scall RavePartyFlag
	checkevent EVENT_CINNABAR_RAVE_PARTY
	iffalse .endcallback

	appear CINNABARISLAND_LOVER_F
.endcallback
	endcallback

RavePartyFlag::
	clearevent EVENT_CINNABAR_RAVE_PARTY

	readvar VAR_WEEKDAY
	ifequal THURSDAY, .if_thursday
	ifequal FRIDAY, .if_friday
	endcallback

.if_thursday:
	readvar VAR_HOUR
	ifgreater 20, .DoRaveParty
	endcallback

.if_friday:
	readvar VAR_HOUR
	ifless 4, .DoRaveParty
	endcallback

.DoRaveParty
	setevent EVENT_CINNABAR_RAVE_PARTY
	end

CinnabarIslandBlue:
	faceplayer
	opentext
	writetext CinnabarIslandBlueText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applymovement CINNABARISLAND_BLUE, CinnabarIslandBlueTeleport
	disappear CINNABARISLAND_BLUE
	clearevent EVENT_VIRIDIAN_GYM_BLUE
	end

CinnabarIslandLovers:
	pause 5
	showemote EMOTE_HEART, CINNABARISLAND_LOVER_M, 15
	pause 15
	showemote EMOTE_HEART, CINNABARISLAND_LOVER_F, 15
	end

CinnabarIslandPartyScript:
	jumptextfaceplayer CinnabarIslandPartyText

CinnabarIslandVolcanoSwimmingScript:
	checkevent EVENT_CINNABAR_SWIM_CHEAT
	iftrue .volcano_cheat
	setevent EVENT_CINNABAR_SWIM_CHEAT
	jumptextfaceplayer CinnabarIslandVolcanoSwimmingText

.volcano_cheat:
	opentext
	writetext CinnabarIslandVolcanoSwimmingSequelText
	pause 20
	closetext
	end

CinnabarIslandSickScript:
	opentext
	checkevent EVENT_PICKED_UP_FOCUS_BAND
	iftrue .ready_to_party

	checkevent EVENT_CINNABAR_MAX_REVIVE
	iftrue .buy_silence

	checkevent EVENT_CINNABAR_GAVE_WATER
	iftrue .couldnt_take_max_revive

	writetext CinnabarIslandSickText
	waitbutton
	checkitem FRESH_WATER
	iftrue .offer_water
	closetext
	end

.couldnt_take_max_revive:
	faceplayer
	writetext CinnabarIslandSickMaxReviveBisText
	promptbutton
	sjump .gave_water

.offer_water:
	writetext CinnabarIslandAskWaterText
	yesorno
	iffalse .close_text

.take_water:
	takeitem FRESH_WATER
	setevent EVENT_CINNABAR_GAVE_WATER
	writetext CinnabarIslandGiveWaterText
	promptbutton
	faceplayer
	opentext
	writetext CinnabarIslandSickWaterText
	promptbutton
.gave_water:
	verbosegiveitem MAX_REVIVE
	iffalse .make_room_max_revive
	setevent EVENT_CINNABAR_MAX_REVIVE

.buy_silence:
	faceplayer
	writetext CinnabarIslandSickBuySilenceText
	promptbutton
	verbosegiveitem FOCUS_BAND
	iffalse .make_room_amulet
	setevent EVENT_PICKED_UP_FOCUS_BAND

.ready_to_party:
	faceplayer
	writetext CinnabarIslandSickBetterText
	waitbutton
	closetext
	end

.make_room_max_revive:
	writetext CinnabarIslandSickMakeRoomText
	waitbutton
.close_text
	closetext
	end

.make_room_amulet:
	writetext CinnabarIslandSickMakeRoom2Text
	waitbutton
	closetext
	end

CinnabarBuyerScript:
	checkevent EVENT_CINNABAR_TOSSED_STUFF
	iftrue .regular_text
	checkevent EVENT_CINNABAR_DELIVERED_STUFF
	iftrue .help_get_rid
	setevent EVENT_CINNABAR_ORDERED_STUFF
	jumptextfaceplayer CinnabarGoFetchStuffText

.help_get_rid:
	opentext 
	writetext CinnabarWrongOrderText
	promptbutton
	verbosegiveitem FRESH_WATER
	iffalse .end
	setevent EVENT_CINNABAR_TOSSED_STUFF
.end:
	closetext
	end
.regular_text:
	jumptextfaceplayer CinnabarSyncText

CinnabarSellerScript:
	checkevent EVENT_CINNABAR_DELIVERED_STUFF
	iftrue CinnabarIslandLovers
	checkevent EVENT_CINNABAR_ORDERED_STUFF
	iffalse CinnabarIslandLovers
	opentext
	writetext CinnabarBusyText
	promptbutton
	closetext
	pause 10
	faceplayer
	opentext
	writetext CinnabarDeliverStuffText
	waitbutton
	closetext
	applymovement CINNABARISLAND_LOVER_M, CinnabarSellerGo_Movement
	pause 40
	applymovement CINNABARISLAND_LOVER_M, CinnabarSellerBack_Movement
	faceplayer
	opentext
	writetext CinnabarThanksText
	waitbutton
	closetext
	turnobject CINNABARISLAND_LOVER_M, RIGHT
	setevent EVENT_CINNABAR_DELIVERED_STUFF
	end

CinnabarHydratedScript:
	jumptextfaceplayer CinnabarHydratedText

CinnabarSunriseScript:
	jumptextfaceplayer CinnabarSunriseText

CinnabarIslandSign:
	jumptext CinnabarIslandSignText

CinnabarIslandPokecenterSign:
	jumpstd PokecenterSignScript

CinnabarIslandHiddenRareCandy:
	hiddenitem RARE_CANDY, EVENT_CINNABAR_ISLAND_HIDDEN_RARE_CANDY

CinnabarIslandBlueTeleport:
	teleport_from
	step_end

CinnabarSoda1:
	hiddenitem SODA_POP, EVENT_FOUND_CINNABAR_SODA_1

CinnabarSoda2:
	hiddenitem BRIGHTPOWDER, EVENT_FOUND_CINNABAR_SODA_2

CinnabarSoda3:
	hiddenitem SODA_POP, EVENT_FOUND_CINNABAR_SODA_3

CinnabarSellerGo_Movement:
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step_end

CinnabarSellerBack_Movement:
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step UP
	step RIGHT
	step_end

CinnabarIslandBlueText: 
if DEF(_FR_FR)
	text "T'es qui toi?"

	para "T'es dresseur,"
	line "ça se voit..."

	para "Moi c'est BLUE."

	para "J'ai été un MAITRE"
	line "pendant un temps."

	para "Enfin, pendant"
	line "quelques minutes."

	para "Juste avant que"
	line "RED me batte..."

	para "Je le hais ce"
	line "type..."

	para "Bon tu veux quoi?"
	line "Tu veux t'battre?"

	para "Désolé mais j'ai"
	line "pas la tête à ça."

	para "Regarde autour"
	line "de toi..."

	para "Un volcan explose"
	line "et une ville"

	para "disparaît d'un"
	line "coup."

	para "Faire du POKé POKé"
	line "c'est bien joli"

	para "mais on peut se"
	line "faire balayer par"

	para "une catastrophe"
	line "naturelle à tout"
	cont "moment..."

	para "..."

	para "C'est comme ça."
	line "On y peut rien."

	para "Mais bon. J'suis"
	line "quand même un"
	cont "dresseur."

	para "Et un balèze en"
	line "plus. J'te l'avais"
	cont "dit, non?"

	para "Si tu cherches un"
	line "bon combat, viens"
	cont "à l'ARENE de"
	cont "JADIELLE."

	para "Et ça sera ta"
	line "p'tite fête."
else
	text "Who are you?"

	para "Well, it's plain"
	line "to see that you're"
	cont "a trainer…"

	para "My name's BLUE."

	para "I was once the"
	line "CHAMPION, although"

	para "it was for only a"
	line "short time…"

	para "That meddling RED"
	line "did me in…"

	para "Anyway, what do"
	line "you want? You want"

	para "to challenge me or"
	line "something?"

	para "…I hate to say"
	line "it, but I'm not in"

	para "the mood for a"
	line "battle now."

	para "Take a good look"
	line "around you…"

	para "A volcano erupts,"
	line "and just like"

	para "that, a whole town"
	line "disappears."

	para "We can go on win-"
	line "ning and losing in"

	para "#MON. But if"
	line "nature so much as"

	para "twitches, we can"
	line "lose in a second."

	para "…"

	para "That's the way it"
	line "is…"

	para "But, anyway, I'm"
	line "still a trainer."

	para "If I see a strong"
	line "opponent, it makes"
	cont "me want to battle."

	para "If you want to"
	line "battle me, come to"
	cont "the VIRIDIAN GYM."

	para "I'll take you on"
	line "then."
endc

	done

CinnabarIslandPartyText:
if DEF(_FR_FR)
	text "C'EST LA FEEETE!!"
else
	text "PAR-TAAAY!!"
endc
	done

CinnabarIslandVolcanoSwimmingText:
if DEF(_FR_FR)
	text "YOUHOU! Je nage"
	line "dans un p*tain"
	cont "de volcan bébé!"
else
	text "WOOHOO! I'm swim-"
	line "ming in a f*cking"
	cont "volcano baby!"
endc
	done

CinnabarIslandVolcanoSwimmingSequelText:
if DEF(_FR_FR)
	text "Laisse-moi te"
	line "dire un secret:"

	para "Je ne porte"
	line "rien du tout!"
else
	text "Let me tell you"
	line "a secret, my dear:"

	para "I'm wearing"
	line "nothing!"
endc
	done

CinnabarIslandSickText:
if DEF(_FR_FR)
	text "(burp)"

	para "Je me sens"
	line "mal... Il me faut"
	cont "un truc frais"
	cont "(burp)"
	cont "à boire..."
else
	text "(burp)"

	para "I'm not feeling"
	line "well. I need some-"
	cont "thing refreshing"
	cont "(burp)"
	cont "to drink…"
endc
	done

CinnabarIslandAskWaterText:
if DEF(_FR_FR)
	text "Offrir de l'"
	line "EAU FRAICHE?"
else
	text "Offer FRESH"
	line "WATER?"
endc
	done

CinnabarIslandGiveWaterText:
if DEF(_FR_FR)
	text "<PLAYER> donne"
	line "EAU FRAICHE."
else
	text "<PLAYER> gave"
	line "FRESH WATER."
endc
	done

CinnabarIslandSickWaterText:
if DEF(_FR_FR)
	text "(glou glou)"

	para "..."

	para "Wouhou!"

	para "Je me sens déjà"
	line "mieux."

	para "J'étais"
	line "à bout..."

	para "Quelques secondes"
	line "de plus, et j'au-"
	cont "rais dû me servir"
	cont "de ça..."
else
	text "(drinks)"

	para "…"

	para "Woooo!"

	para "I'm feeling better"
	line "already."

	para "I was on"
	line "the edge…"

	para "A few seconds"
	line "more, and I would"
	cont "have needed to"
	cont "use this…"
endc
	done

CinnabarIslandSickMaxReviveBisText:
if DEF(_FR_FR)
	text "Je n'en ai"
	line "plus besoin,"
	cont "prends-la."
else
	text "I don't need"
	line "this anymore,"
	cont "please take it."
endc
	done

CinnabarIslandSickMakeRoomText:
if DEF(_FR_FR)
	text "Vide ton sac puis"
	line "reviens me voir."
else
	text "Empty your bag"
	line "then come back."
endc
	done

CinnabarIslandSickMakeRoom2Text:
if DEF(_FR_FR)
	text "Tu ne peux pas"
	line "la prendre?"
	cont "Reviens vite."
else
	text "You can't take it?"
	line "Come back swiftly."
endc
	done

CinnabarIslandSickBuySilenceText:
if DEF(_FR_FR)
	text "Je pense que j'ai"
	line "tenu grâce à ma"
	cont "CEINTURFORCE."

	para "A ton tour"
	line "d'en profiter!"
else
	text "I think I held out"
	line "thanks to my"
	cont "FOCUS SASH."

	para "Now it's your turn"
	line "to take advantage"
	cont "of it!"
endc
	done

CinnabarIslandSickBetterText:
if DEF(_FR_FR)
	text "Donne-moi une"
	line "minute, et c'est"
	cont "REPARTIIII!"
	cont "(burp)!"
else
	text "Give me a minute,"
	line "then let's"
	cont "PAR-TAY!"
	cont "(burp)!"
endc
	done

CinnabarIslandSignText: 
if DEF(_FR_FR)
	text "CRAMOIS'ILE"

	para "Rouge comme le feu"
else
	text "CINNABAR ISLAND"

	para "The Fiery Town of"
	line "Burning Desire"
endc

	done

CinnabarHydratedText:
if DEF(_FR_FR)
	text "Faut rester"
	line "hydraté, hihi!"
else
	text "Gotta stay"
	line "hydrated"
	cont "tee-hee!"
endc
	done

CinnabarGoFetchStuffText:
if DEF(_FR_FR)
	text "Hé toi!"
	line "Tu vois le type"
	cont "là-bas?"

	para "Ma copine dit"
	line "qu'il a de la"
	cont "bonne came."

	para "Dis-lui de m'en"
	line "ramener, ok?"
else
	text "Hey you!"
	line "You see the guy"
	cont "over there?"

	para "My girl says he's"
	line "got da good stuff."

	para "Tell him to bring"
	line "me some, would ya."
endc
	done

CinnabarBusyText:
if DEF(_FR_FR)
	text "Hé, je suis occupé"
	line "ça se voit pas?"
else
	text "Yo, I'm busy"
	line "can't you see?"
endc
	done

CinnabarDeliverStuffText:
if DEF(_FR_FR)
	text "Hein? Qui c'est qui"
	line "en veut t'as dit?"

	para "Ok, j'vais faire"
	line "la transaction."
else
	text "Wait. Who wants"
	line "some you said?"

	para "Ok, I'll go sell."
endc
	done

CinnabarThanksText:
if DEF(_FR_FR)
	text "Merci pour"
	line "le tuyau."
else
	text "Thanks for the"
	line "tip."
endc
	done

CinnabarWrongOrderText:
if DEF(_FR_FR)
	text "C'est quoi que"
	line "j'ai acheté?"

	para "J'avais jamais vu"
	line "ça en soirée."

	para "Aucun goût."

	para "Ca m'intéresse pas."
	line "Aide-moi à m'en"
	cont "débarrasser."
else
	text "What did I"
	line "just buy?"

	para "I've never seen"
	line "this at a party"
	cont "before."

	para "No flavour."

	para "I don't want it."
	line "Help me get rid"
	cont "of it."
endc
	done

CinnabarSyncText:
if DEF(_FR_FR)
	text "Ne me parle pas!"
	line "J'vais perdre le"
	cont "tempo!"
else
	text "Don't talk to me!"
	line "Imma lose my sync!"
endc
	done

CinnabarSingingText:
if DEF(_FR_FR)
	text "Ooh baby"
	line "I feel right"

	para "the music sounds"
	line "better with you"

	para "love might"
	line "bring us both"
	cont "together"

	para "I feel so good"
else
	text "You don't even"
	line "know me,"

	para "you say that I'm"
	line "not livin' right?"

	para "You don't"
	line "understand me,"

	para "so why do you"
	line "judge mah life?"
endc
	done

CinnabarSunriseText:
if DEF(_FR_FR)
	text "Cet endroit est"
	line "parfait. Personne"
	cont "ne pensera à nous"
	cont "chercher ici."

	para "On va s'amuser"
	line "jusqu'au bout"
	cont "de la nuit!"
	cont "(tousse)"
else
	text "This place is per-"
	line "fect, no one would"
	cont "think of searching"
	cont "here."

	para "Let's have fun"
	line "until the end"
	cont "of the night!"
	cont "(cough)"
endc
	done

CinnabarIsland_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11, 11, CINNABAR_POKECENTER_1F, 1
	warp_event 8,   5, SEAFOAM_GYM, 1

	def_coord_events

	def_bg_events
	bg_event 12, 11, BGEVENT_READ, CinnabarIslandPokecenterSign
	bg_event  7,  7, BGEVENT_READ, CinnabarIslandSign
	bg_event  9,  1, BGEVENT_ITEM, CinnabarIslandHiddenRareCandy
	bg_event  5,  6, BGEVENT_ITEM, CinnabarSoda1
	bg_event  4, 11, BGEVENT_ITEM, CinnabarSoda2
	bg_event 14, 12, BGEVENT_ITEM, CinnabarSoda3

	def_object_events
	object_event  9,  6, SPRITE_BLUE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CinnabarIslandBlue, EVENT_BLUE_IN_CINNABAR
	object_event  8,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CinnabarIslandLovers, 0
	object_event  7,  8, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CinnabarSellerScript, 0
	object_event 11,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	object_event 10, 16, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CinnabarHydratedScript, 0
	object_event 12, 16, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CinnabarBuyerScript, 0
	object_event  8,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_PATROL_X, 1, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	object_event  9,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_PATROL_X, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	;object_event  4, 11, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	object_event 14,  4, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 0, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CinnabarIslandVolcanoSwimmingScript, 0
	object_event  6, 13, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CinnabarIslandSickScript, 0
	object_event  5,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CinnabarSunriseScript, 0
	object_event 16, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	object_event 16, 10, SPRITE_ROCKER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
