	object_const_def
	const ROUTE17_BIKER1
	const ROUTE17_BIKER2
	const ROUTE17_BIKER3

Route17_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .AlwaysOnBike

.AlwaysOnBike:
	setflag ENGINE_ALWAYS_ON_BIKE
	setflag ENGINE_DOWNHILL
	endcallback

TrainerBikerRiley:
	trainer BIKER, RILEY, EVENT_BEAT_BIKER_RILEY, BikerRileySeenText, BikerRileyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerRileyAfterBattleText

TrainerBikerMarkey:
	trainer BIKER, MARKEY, EVENT_BEAT_BIKER_MARKEY, BikerMarkeySeenText, BikerMarkeyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerMarkeyAfterBattleText

TrainerBikerTeddy:
	trainer BIKER, TEDDY, EVENT_BEAT_BIKER_TEDDY, BikerTeddySeenText, BikerTeddyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerTeddyAfterBattleText

TrainerBikerDan:
	trainer BIKER, DAN, EVENT_BEAT_BIKER_DAN, BikerDanSeenText, BikerDanBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerDanAfterBattleText

TrainerBikerMaube:
	trainer BIKER, MAUBE, EVENT_BEAT_BIKER_MAUBE, BikerMaubeSeenText, BikerMaubeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerMaubeAfterBattleText

TrainerBikerFew:
	trainer BIKER, FEW, EVENT_BEAT_BIKER_FEW, BikerFewSeenText, BikerFewBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerFewAfterBattleText

TrainerBikerJoel:
	trainer BIKER, JOEL, EVENT_BEAT_BIKER_JOEL, BikerJoelSeenText, BikerJoelBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerJoelAfterBattleText

TrainerBikerGlenn:
	trainer BIKER, GLENN, EVENT_BEAT_BIKER_GLENN, BikerGlennSeenText, BikerGlennBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BikerGlennAfterBattleText

Route17Mid1Sign:
	jumptext Route17TrainerTips1Text

Route17Mid2Sign:
	jumptext Route17TrainerTips2Text

Route17Mid3Sign:
	jumptext Route17MidSign3Text

Route17Bot1Sign:
	jumptext Route17BotSign1Text

Route17Bot2Sign:
	jumptext Route17BotSign2Text

Route17HiddenMaxEther:
	hiddenitem MAX_ETHER, EVENT_ROUTE_17_HIDDEN_MAX_ETHER

Route17HiddenMaxElixer:
	hiddenitem MAX_ELIXER, EVENT_ROUTE_17_HIDDEN_MAX_ELIXER

BikerRileySeenText: 
if DEF(_FR_FR)
	text "Hé, toi!"
	line "T'es de JOHTO?"
else
	text "Hey, you! You're"
	line "from JOHTO, huh?"
endc

	done

BikerRileyBeatenText: 
if DEF(_FR_FR)
	text "Graaaaaah!"
else
	text "Whoa, you kick!"
endc

	done

BikerRileyAfterBattleText: 
if DEF(_FR_FR)
	text "Pas la peine de"
	line "crâner!"
else
	text "Don't get cocky,"
	line "you JOHTO punk!"
endc

	done

BikerJoelSeenText: 
if DEF(_FR_FR)
	text "Oh! Elle est cool"
	line "ta BICYCLETTE!"
else
	text "Wow. That's a cool"
	line "BICYCLE!"
endc

	done

BikerJoelBeatenText: 
if DEF(_FR_FR)
	text "Par contre, toi..."
	line "T'es pas cool."
else
	text "But you don't just"
	line "look cool…"
endc

	done

BikerJoelAfterBattleText: 
if DEF(_FR_FR)
	text "Moi j'ai trop la"
	line "classe. T'as vu"
	cont "mes fringues?"

	para "J'suis trop"
	line "relax."
else
	text "I look cool, but"
	line "I'm weak, so I'm"
	cont "not really cool."

	para "I have to train"
	line "harder…"
endc

	done

BikerGlennSeenText: 
if DEF(_FR_FR)
	text "Hé! Ca te dit un"
	line "chtit combat?"
else
	text "Hey! Want to have"
	line "a speed battle?"
endc

	done

BikerGlennBeatenText: 
if DEF(_FR_FR)
	text "Ayaah! Toi t'es"
	line "pas naze!"
else
	text "Yikes! You've got"
	line "awesome torque!"
endc

	done

BikerGlennAfterBattleText: 
if DEF(_FR_FR)
	text "Conduire sans les"
	line "mains, c'est la"
	cont "classe."
else
	text "Hands-free riding"
	line "is considered cool"
	cont "on CYCLING ROAD."
endc

	done

BikerMarkeySeenText:
if DEF(_FR_FR)
	text "Barre toi d'ma"
	line "route!"
else
	text "Don't get in"
	line "my way!"
endc
	done

BikerMarkeyBeatenText:
if DEF(_FR_FR)
	text "Pardon de t'avoir"
	line "gêné."
else
	text "Sorry I got in"
	line "your way."
endc
	done

BikerMarkeyAfterBattleText:
if DEF(_FR_FR)
	text "T'es encore là"
	line "toi?"
else
	text "You're still here?"
endc
	done

BikerTeddySeenText:
if DEF(_FR_FR)
	text "La liberté, c'est"
	line "sentir le vent"
	cont "dans ses cheveux."
	
	para "...et une coupe de"
	line "cheveux moderne."
else
	text "Freedom is feeling"
	line "the wind in your"
	cont "hair."
	
	para "Along with a bold"
	line "haircut."
endc
	done

BikerTeddyBeatenText:
if DEF(_FR_FR)
	text "J'ai les cheveux"
	line "qui se dressent."
else
	text "You made my hair"
	line "stand on end."
endc
	done

BikerTeddyAfterBattleText:
if DEF(_FR_FR)
	text "Pas mal ma coupe,"
	line "hein?"
else
	text "Not bad for a"
	line "haircut, huh?"
endc
	done

BikerDanSeenText:
if DEF(_FR_FR)
	text "La liberté, c'est"
	line "de pouvoir polluer"
	cont "si ça m'chante."
else
	text "Freedom is being"
	line "able to pollute if"
	cont "I feel like it."
endc
	done

BikerDanBeatenText:
if DEF(_FR_FR)
	text "M'en fous."
else
	text "I don't care."
endc
	done

BikerDanAfterBattleText:
if DEF(_FR_FR)
	text "Laisse-moi polluer"
	line "tranquillement."
else
	text "Let me pollute"
	line "in peace."
endc
	done

BikerMaubeSeenText:
if DEF(_FR_FR)
	text "Matte ma mob,"
	line "elle déchire!"
else
	text "Check out my ride,"
	line "it's awesome!"
endc
	done

BikerMaubeBeatenText:
if DEF(_FR_FR)
	text "T'y es tarpin"
	line "balaise!"
else
	text "Good game!"
endc
	done

BikerMaubeAfterBattleText:
if DEF(_FR_FR)
	text "J'ai designé cette"
	line "mob moi-même!"

	para "C'est mon taf!"
	line "VROOM VROOM!"
else
	text "I designed this"
	line "ride myself!"

	para "It's my job!"
	line "VROOM VROOM!"
endc
	done

BikerFewSeenText:
if DEF(_FR_FR)
	text "C'est quoi le plus"
	line "dangereux?"

	para "Une petite maladie"
	line "ou perdre nos"
	
	para "libertés fondamen-"
	line "tales?"
else
	text "What's the most"
	line "dangerous?"
	
	para "A short disease,"
	line "or losing our"
	cont "sacred freedoms?"
endc
	done
	
BikerFewBeatenText:
if DEF(_FR_FR)
	text "C'est toi le"
	line "danger."
else
	text "You're the danger."
endc
	done

BikerFewAfterBattleText:
if DEF(_FR_FR)
	text "La TEAM ROCKET a"
	line "soulevé un point"
	cont "valide quand elle"
	cont "a suggéré de nous"
	cont "battre pour nos"
	cont "libertés."
else
	text "TEAM ROCKET made a"
	line "valid point when"
	cont "they talked about"
	cont "fighting for our"
	cont "freedoms."
endc
	done

Route17MidSign3Text:
if DEF(_FR_FR)
	text "Route 16"
	line "CELADOPOLE -"
	cont "PARMANIE"
else
	text "Route 16"
	line "CELADON CITY -"
	cont "FUCHSIA CITY"
endc
	done

Route17MidSign1Text:
if DEF(_FR_FR)
	text "Un conseil!"

	para "Attention à ne"
	line "pas jeter un"
	cont "objet important!"
else
	text "It's a notice!"

	para "Watch out for"
	line "discarded items!"
endc
	done

Route17TrainerTips1Text:
if DEF(_FR_FR)
	text "ASTUCE"

	para "Chaque #MON"
	line "est unique."

	para "Des #MON de"
	line "même type et de"
	cont "même niveau sont"
	cont "plus ou moins"
	cont "forts."
else
	text "TRAINER TIPS"

	para "All #MON are"
	line "unique."

	para "Even #MON of"
	line "the same type and"
	cont "level grow at"
	cont "different rates."
endc
	done

Route17TrainerTips2Text:
if DEF(_FR_FR)
	text "C'est un graffiti:"

	para "“Après le COVID,"
	line "le FRIGOVID”"
else
	text "TRAINER TIPS"

	para "There's graffiti"
	line "written in French…"

	para "“Apres le COVID,"
	line "le FRIGOVID”"
endc
	done

Route17BotSign1Text:
if DEF(_FR_FR)
	text "Un conseil!"

	para "Ne jetez pas ce"
	line "jeu contre un mur"
	cont "avec violence et"
	cont "dégoût! Continuez"
	cont "à attraper des"
	cont "p'tits #MON"
	cont "tout mimi!"
else
	text "It's a notice!"

	para "Don't throw the"
	line "game, throw #"
	cont "BALLs instead!"
endc
	done

Route17BotSign2Text::
if DEF(_FR_FR)
	text "PISTE CYCLABLE"
	line "Fin de la"
	cont "descente!"
else
	text "CYCLING ROAD"
	line "slope ends here!"
endc
	done

Route17_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17, 136, ROUTE_17_ROUTE_18_GATE, 1
	warp_event 17, 137, ROUTE_17_ROUTE_18_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 17, 64, BGEVENT_ITEM, Route17HiddenMaxEther
	bg_event  8, 45, BGEVENT_ITEM, Route17HiddenMaxElixer
	bg_event  9, 51, BGEVENT_READ, Route17Mid1Sign
	bg_event  9, 63, BGEVENT_READ, Route17Mid2Sign
	bg_event  9, 75, BGEVENT_READ, Route17Mid3Sign
	bg_event  9, 99, BGEVENT_READ, Route17Bot1Sign
	bg_event  9, 129, BGEVENT_READ, Route17Bot2Sign

	def_object_events
	object_event  4, 75, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerBikerRiley, -1
	object_event 13,  9, SPRITE_BIKER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBikerMarkey, -1
	object_event 18, 86, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 4, TrainerBikerTeddy, -1
	object_event  2, 56, SPRITE_BIKER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 1, 3, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerBikerDan, -1
	object_event 14, 49, SPRITE_BIKER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 1, 3, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBikerMaube, -1
	object_event  5, 31, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBikerFew, -1
	object_event  9, 122, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerBikerJoel, -1
	object_event  3, 107, SPRITE_BIKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBikerGlenn, -1
