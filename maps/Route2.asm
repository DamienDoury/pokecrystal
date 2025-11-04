	object_const_def
	const ROUTE2_BUG_CATCHER1
	const ROUTE2_BUG_CATCHER2
	const ROUTE2_BUG_CATCHER3
	const ROUTE2_POKE_BALL1
	const ROUTE2_POKE_BALL2
	const ROUTE2_WARNING_TOP
	const ROUTE2_WARNING_BOT

Route2_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBugCatcherRob:
	trainer BUG_CATCHER, ROB, EVENT_BEAT_BUG_CATCHER_ROB, BugCatcherRobSeenText, BugCatcherRobBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BugCatcherRobAfterBattleText

TrainerBugCatcherEd:
	trainer BUG_CATCHER, ED, EVENT_BEAT_BUG_CATCHER_ED, BugCatcherEdSeenText, BugCatcherEdBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BugCatcherEdAfterBattleText

TrainerBugCatcherDoug:
	trainer BUG_CATCHER, DOUG, EVENT_BEAT_BUG_CATCHER_DOUG, BugCatcherDougSeenText, BugCatcherDougBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BugCatcherDougAfterBattleText

Route2WarningTopLeft:
	showemote EMOTE_SHOCK, ROUTE2_WARNING_TOP, 15
	faceobject PLAYER, ROUTE2_WARNING_TOP
	applymovement ROUTE2_WARNING_TOP, Route2LeftStepMovement
	sjump Route2WarningTopScript

Route2WarningTopRight:
	showemote EMOTE_SHOCK, ROUTE2_WARNING_TOP, 15
	faceobject PLAYER, ROUTE2_WARNING_TOP
	pause 10
	
Route2WarningTopScript:
	setevent EVENT_VIRIDIAN_FOREST_WARNING_ISSUED
	faceplayer
	opentext
	writetext Route2WarningTopText
	sjump Route2WarningTopEndScript

Route2WarningTopEndScript:
	promptbutton
	writetext Route2WarningTextEnd
	waitbutton
	closetext
	end

Route2WarningBotLeft:
	showemote EMOTE_SHOCK, ROUTE2_WARNING_BOT, 15
	faceobject PLAYER, ROUTE2_WARNING_BOT
	applymovement ROUTE2_WARNING_BOT, Route2LeftStepMovement
	sjump Route2WarningBotScript

Route2WarningBotRight:
	showemote EMOTE_SHOCK, ROUTE2_WARNING_BOT, 15
	faceobject PLAYER, ROUTE2_WARNING_BOT

Route2WarningBotScript:
	setevent EVENT_VIRIDIAN_FOREST_WARNING_ISSUED
	faceplayer 
	opentext
	writetext Route2WarningBotText
	sjump Route2WarningTopEndScript

Route2Sign:
	jumptext Route2SignText

Route2DiglettsCaveSign:
	jumptext Route2DiglettsCaveSignText

Route2DireHit:
	itemball DIRE_HIT

Route2MaxPotion:
	itemball MAX_POTION

Route2Carbos:
	itemball CARBOS

Route2Elixer:
	itemball ELIXER

Route2LeftStepMovement:
	step LEFT
	step_end

Route2WarningTopText:
if DEF(_FR_FR)
	text "Tu ne devrais pas"
	line "t'aventurer dans"
	cont "la FORET DE JADE."
	
	para "Un enfant s'y"
	line "est perdu."

	para "Oh..."

	para "Tu es le MAITRE"
	line "de la LIGUE!"

	para "Je suppose que je"
	line "ne peux pas te"
	cont "stopper."
else
	text "You shouldn't go"
	line "into VIRIDIAN"
	cont "FOREST."
	
	para "A kid got lost"
	line "already."

	para "Oh…"
	
	para "You're the LEAGUE"
	line "CHAMPION!"

	para "I guess I can't"
	line "stop you."
endc
	done

Route2WarningBotText:
if DEF(_FR_FR)
	text "Sois sage, et"
	line "n'entre pas dans"
	cont "la FORET DE JADE."

	para "La forêt semble"
	line "vivante, c'est"
	cont "dangereux."
else
	text "Please don't go"
	line "into VIRIDIAN"
	cont "FOREST."

	para "The forest looks"
	line "alive, it's dange-"
	cont "rous out there."
endc
	done

Route2WarningTextEnd:
if DEF(_FR_FR)
	text "Suis au moins mon"
	line "conseil, et prends"
	
	para "un #MON qui"
	line "connait VOL ou"
	
	para "TELEPORT afin de"
	line "pouvoir quitter"
	cont "ces bois en toute"
	cont "sécurité."
else
	text "At least follow my"
	line "advice, and bring"
	
	para "a #MON that"
	line "knows FLY or"
	
	para "TELEPORT so you"
	line "can safely escape"
	cont "those woods."
endc
	done

BugCatcherRobSeenText: 
if DEF(_FR_FR)
	text "Mes #MON in-"
	line "secte sont forts."
	cont "Tu vas perdre!"
else
	text "My bug #MON are"
	line "tough. Prepare to"
	cont "lose!"
endc

	done

BugCatcherRobBeatenText: 
if DEF(_FR_FR)
	text "Tout perdu!"
else
	text "I was whipped…"
endc

	done

BugCatcherRobAfterBattleText: 
if DEF(_FR_FR)
	text "Je vais chercher"
	line "des #MON insec-"
	cont "te plus forts."
else
	text "I'm going to look"
	line "for stronger bug"
	cont "#MON."
endc

	done

BugCatcherEdSeenText:
if DEF(_FR_FR)
	text "Bouh!"

	para "Je suis l'esprit"
	line "de la FORET DE"
	cont "JADE!"
else
	text "Boo!"

	para "I'm the spirit from"
	line "VIRIDIAN FOREST!"
endc
	done

BugCatcherEdBeatenText: 
if DEF(_FR_FR)
	text "Aïeuuu!"
else
	text "Ouch, ouch, ouch!"
endc

	done

BugCatcherEdAfterBattleText:
if DEF(_FR_FR)
	text "Avant, je chassais"
	line "les INSECTES dans"
	cont "la FORET DE JADE."
	
	para "Maintenant, maman"
	line "me l'interdit."
else
	text "In the past, I"
	line "hunted BUGS in"
	cont "VIRIDIAN FOREST."
	
	para "Now mom won't"
	line "allow me."
endc
	done

BugCatcherDougSeenText:
if DEF(_FR_FR)
	text "Auparavant, je"
	line "flanais dans la"
	cont "FORET DE JADE."

	para "Depuis qu'elle a"
	line "repoussé, j'ai"
	cont "peur d'y aller."
else
	text "I used to wander"
	line "into VIRIDIAN"
	cont "FOREST."

	para "Since it grew back"
	line "up, I'm afraid"
	cont "to go."
endc
	done

BugCatcherDougBeatenText: 
if DEF(_FR_FR)
	text "Naaaaan!"
else
	text "No good!"
endc

	done

BugCatcherDougAfterBattleText:
if DEF(_FR_FR)
	text "La FORET DE JADE a"
	line "été rasée il y a"
	
	para "3 ans pour facili-"
	line "ter le passage"
	
	para "entre JADIELLE"
	line "et ARGENTA."

	para "La voir ainsi"
	line "m'avait attristé."

	para "Mais peu après,"
	line "la forêt a repous-"
	
	para "sé à une vitesse"
	line "surnaturelle."
else
	text "VIRIDIAN FOREST"
	line "had been cut down"
	
	para "3 years ago to"
	line "ease travel bet-"
	
	para "ween VIRIDIAN and"
	line "PEWTER cities."

	para "Seeing it"
	line "saddened me."

	para "But shortly after,"
	line "the forest grew"
	
	para "back up at a super"
	line "natural speed."
endc
	done

Route2SignText: 
if DEF(_FR_FR)
	text "ROUTE 2"

	para "JADIELLE -"
	line "ARGENTA"
else
	text "ROUTE 2"

	para "VIRIDIAN CITY -"
	line "PEWTER CITY"
endc

	done

Route2DiglettsCaveSignText: 
if DEF(_FR_FR)
	text "CAVE TAUPIQUEUR"
else
	text "DIGLETT'S CAVE"
endc

	done

Route2_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 19, 15, ROUTE_2_NUGGET_HOUSE, 1
	warp_event 19, 31, ROUTE_2_GATE, 3
	warp_event 20, 27, ROUTE_2_GATE, 1
	warp_event 21, 27, ROUTE_2_GATE, 2
	warp_event 16,  7, DIGLETTS_CAVE, 3

	warp_event  6, 16, VIRIDIAN_FOREST, 1
	warp_event  7, 16, VIRIDIAN_FOREST, 2
	warp_event  8, 27, VIRIDIAN_FOREST, 3
	warp_event  9, 27, VIRIDIAN_FOREST, 4

	def_coord_events
	coord_event  6,  9, CE_EVENT_FLAG_CLEARED, EVENT_VIRIDIAN_FOREST_WARNING_ISSUED, Route2WarningTopLeft
	coord_event  7,  9, CE_EVENT_FLAG_CLEARED, EVENT_VIRIDIAN_FOREST_WARNING_ISSUED, Route2WarningTopRight
	coord_event  8, 33, CE_EVENT_FLAG_CLEARED, EVENT_VIRIDIAN_FOREST_WARNING_ISSUED, Route2WarningBotLeft
	coord_event  9, 33, CE_EVENT_FLAG_CLEARED, EVENT_VIRIDIAN_FOREST_WARNING_ISSUED, Route2WarningBotRight

	def_bg_events
	bg_event 11, 51, BGEVENT_READ, Route2Sign
	bg_event 15,  9, BGEVENT_READ, Route2DiglettsCaveSign

	def_object_events
	object_event 14, 45, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 5, TrainerBugCatcherRob, -1
	object_event 10,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherEd, -1
	object_event  4, 40, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherDoug, -1
	object_event 23,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route2Carbos, EVENT_ROUTE_2_CARBOS
	object_event 18, 50, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route2Elixer, EVENT_ROUTE_2_ELIXER
	object_event  7, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route2WarningTopScript, EVENT_FOUGHT_ZAPDOS
	object_event  9, 31, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route2WarningBotScript, EVENT_FOUGHT_ZAPDOS
